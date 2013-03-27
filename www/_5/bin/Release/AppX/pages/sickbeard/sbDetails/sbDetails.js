(function () {
    "use strict";

    var appData = Windows.Storage.ApplicationData.current.roamingSettings;
    var sbURL = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'];

    WinJS.UI.Pages.define("/pages/sickbeard/sbDetails/sbDetails.html", {
        // This function is called whenever a user navigates to this page. It
        // populates the page elements with the app's data.
        ready: function (element, options) {
            var item = options && options.item ? SBData.resolveItemReference(options.item) : SBData.items.getAt(0);

            // title
            element.querySelector("article .item-title").textContent = item.title;

            // poster
            element.querySelector("article .item-image").src = item.poster;
            element.querySelector("article .item-image").alt = item.title;

            // lookup new information about show via sickbeard API
            var showapi = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=show&tvdbid=" + item.tvdb;
            var seasonapi;
            lookupShowInfo(showapi);

            function lookupShowInfo(showapi) {
                var seasoninfo = [];
                $.getJSON(showapi, function (show) {
                    var airs = show.data.airs;
                    var network = show.data.network;
                    var nextep = show.data.next_ep_airdate;
                    var quality = show.data.quality;
                    var seasons = show.data.season_list;

                    if (nextep == "") {
                        nextep = "Unknown";
                    }

                    // show details
                    element.querySelector("article .item-airs span").textContent = airs;
                    element.querySelector("article .item-nextepisode span").textContent = nextep;
                    element.querySelector("article .item-quality span").textContent = quality;
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

                                    // create columns
                                    var tablerow = $("<tr class='season-row " + status + "'></tr>");

                                    tablerow.append("<td>" + epnum + "</td>");
                                    tablerow.append("<td>" + epname + "</td>");
                                    tablerow.append("<td>" + epdate + "</td>");
                                    tablerow.append("<td>" + status + "</td>");

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

            // content
            element.querySelector(".content").focus();
        }
    });
})();
