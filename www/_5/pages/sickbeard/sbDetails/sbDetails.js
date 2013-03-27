(function () {
    "use strict";

    var appData = Windows.Storage.ApplicationData.current.roamingSettings;
    var sbURL = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'];

    WinJS.UI.Pages.define("/pages/sickbeard/sbDetails/sbDetails.html", {
        // This function is called whenever a user navigates to this page. It
        // populates the page elements with the app's data.
        ready: function (element, options) {

            console.log(options.type);

            switch (options.type) {
                case "SBData":
                    var item = options && options.item ? SBData.resolveItemReference(options.item) : SBData.items.getAt(0);
                    break;
                case "SBDataHistory":
                    var item = options && options.item ? SBDataHistory.resolveItemReference(options.item) : SBDataHistory.items.getAt(0);
                    break;
                case "SBDataAll":
                    var item = options && options.item ? SBDataAll.resolveItemReference(options.item) : SBDataAll.items.getAt(0);
                    break;
                case "SBDataSeasonStarts":
                    var item = options && options.item ? SBDataSeasonStarts.resolveItemReference(options.item) : SBDataSeasonStarts.items.getAt(0);
                    break;
                case "SBDataSeasonEnds":
                    var item = options && options.item ? SBDataSeasonEnds.resolveItemReference(options.item) : SBDataSeasonEnds.items.getAt(0);
                    break;
                default:
                    var item = options && options.item ? SBData.resolveItemReference(options.item) : SBData.items.getAt(0);
                    break;
            }

            // title
            // remove "Season X" from title if found
            var splitTitle = item.title.split(" Season");
            element.querySelector("article .item-title").textContent = splitTitle[0];

            // poster
            element.querySelector("article .item-image").src = item.poster;
            element.querySelector("article .item-image").alt = splitTitle[0];

            // lookup new information about show via sickbeard API
            var showapi = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=show&tvdbid=" + item.tvdb;
            lookupShowInfo(showapi);

            var seasonapi;
            function lookupShowInfo(showapi) {
                var seasoninfo = [];
                $(".item-seasonlist").html("");
                $.getJSON(showapi, function (show) {
                    var airs = show.data.airs;
                    var network = show.data.network;
                    var nextep = show.data.next_ep_airdate;
                    var quality = show.data.quality;
                    var seasons = show.data.season_list;
                    var status = show.data.status;

                    if (nextep == "") {
                        nextep = "Unknown";
                    }

                    // show details
                    element.querySelector("article .item-airs span").textContent = airs;
                    element.querySelector("article .item-nextepisode span").textContent = nextep;
                    element.querySelector("article .item-network span").textContent = network;
                    element.querySelector("article .item-quality span").textContent = quality;
                    element.querySelector("article .item-status span").textContent = status;
                    element.querySelector("article .item-tvdblink button").onclick = function () { location.href = 'http://thetvdb.com/?tab=series&id=' + item.tvdb; }

                    // season lists
                    $.each(seasons, function (j, season) {
                        // new getJSON lookup for season lists
                        //lookupSeasonInfo(season);
                        var seasonapi = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=show.seasons&tvdbid=" + item.tvdb + "&season=" + season;
                        // using $.ajax instead of $.getJSON because of timing issue, we need this to not be async because it has the potential to return seasons out of order
                        $.ajax({
                            url: seasonapi,
                            dataType: 'json',
                            async: false,
                            success: function (episodes) {
                                // create a new column section with season number heading
                                if(season == 0) {
                                    var heading = "<h2>Specials</h2>";
                                } else {
                                    var heading = "<h2>Season " + season + "</h2>";
                                }
                                var container = $("<div class='season'>"+heading+"</div>");
                                // create a table to contain each episode for this season
                                var table = $("<table border='0' cellspacing='0'></table>");
                                // create headers
                                var tablehead = $("<thead></thead>");
                                var tableheadrow = $("<tr></tr>");
                                tableheadrow.append("<th class='epnum'>#</th>");
                                tableheadrow.append("<th class='name'>Name</th>");
                                tableheadrow.append("<th class='date'>Date</th>");
                                tableheadrow.append("<th class='status'>Status</th>");
                                tableheadrow.append("<th class='search'></th>");
                                // add headers to table
                                tablehead.append(tableheadrow);
                                table.append(tablehead);

                                // create table body
                                var tablebody = $("<tbody></tbody>");

                                $.each(episodes.data, function (k, episode) {

                                    // get episode details
                                    var epnum = k;
                                    var epdate = episode.airdate;
                                    var epname = episode.name;
                                    var quality = episode.quality;
                                    var status = episode.status;

                                    // search button
                                    // built-in segoe ui icons: http://msdn.microsoft.com/en-au/library/windows/apps/hh770557.aspx
                                    // using them outside of appbar: https://mattduffield.wordpress.com/2012/11/23/developing-windows-8-using-appbarcommand-icons-outside-the-appba/
                                    var searchbtn = $("<span class='search' title='Search for Episode'>&#xe11a;</span>");
                                    var searchcell = $("<td />").append(searchbtn);

                                    // search button click function (searches for episode)
                                    searchbtn.click(function () {
                                        var thisbutton = $(this);

                                        // check if searcbtn has the class of "searching"
                                        // this means a search is already underway
                                        // we'll stop the uesr from initiating more searches for this episode until
                                        // the previous search finishes
                                        if (thisbutton.hasClass("searching")) { return; }

                                        // replace icon with a searching icon
                                        // add temporary "searching" class, used directly above
                                        thisbutton.html("&#xe0c2;").attr({ "class": "search searching", "title": "Searching for Episode" });

                                        // trigger a show search via the sickbeard api
                                        var lookup = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=episode.search&tvdbid=" + item.tvdb + "&season=" + season + "&episode=" + k;
                                        $.getJSON(lookup, function (data) {

                                            // check results when they come in
                                            if (data.result == "failure") {
                                                // replace with failure icon it comes back failure
                                                thisbutton.html("&#xe10a;").attr({ "class": "search error", "title": data.message });
                                            } else {
                                                // it didn't come back with failure it found the episode
                                                // replace with a success icon
                                                thisbutton.html("&#xe10b;").attr({ "class": "search found", "title": data.message });
                                            }
                                        }, function (err) {
                                            //console.log(err);
                                        });
                                    });

                                    // create columns
                                    var tablerow = $("<tr class='season-row " + status + "'></tr>");

                                    tablerow.append("<td>" + epnum + "</td>");
                                    tablerow.append("<td>" + epname + "</td>");
                                    tablerow.append("<td>" + epdate + "</td>");
                                    tablerow.append("<td>" + status + "</td>");
                                    tablerow.append(searchcell);

                                    // add row to tablebody
                                    tablebody.append(tablerow);
                                    
                                });

                                // add columns to table
                                table.append(tablebody);

                                // add whole table to container
                                container.append(table);
                                // add container to the item-seasonlist element on our template
                                container.appendTo(".item-seasonlist");
                                //console.log($(".item-seasonlist").html());
                            }
                        });

                    });

                }, function(error){
                    console.log(error);
                });
            }

            var refreshlink = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=show.update&tvdbid=" + item.tvdb;
            element.querySelector("article .item-reload-info button").onclick = function () {
                $.getJSON(refreshlink, function (data) {
                    if (typeof (SBData) != "undefined") { SBData.regenerate(); }
                    if (typeof (SBDataAll) != "undefined") { SBDataAll.regenerate(); }
                    lookupShowInfo(showapi);
                });
            }

            // content
            element.querySelector(".content").focus();
        }
    });
})();
