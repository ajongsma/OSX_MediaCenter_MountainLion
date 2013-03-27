(function () {
    "use strict";

    var appData = Windows.Storage.ApplicationData.current.roamingSettings;
    var sbURL = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'];

    var list = new WinJS.Binding.List();
    var groupedItems = list.createGrouped(
        function groupKeySelector(item) { return item.group.key; },
        function groupDataSelector(item) { return item.group; }
    );

    // set up our categories
    // I originally wanted a "recent" category that would list recent downloads
    // but CP2 doesn't have any sort of "history" or any way to filter movie.list?status=done by date downloaded
    var categories = [
        { key: "0", title: "Season End Dates" },
    ];

    function loadSBDataSeasonEnds() {
        var sbURL = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'];

        // Generate Ending Season Dates
        generateSBEndDates().then(function (xhr) {

            var json = JSON.parse(xhr.responseText);

            // Cycle through every show on your list
            $.each(json.data, function (i, show) {
                // only return is show status is "Continuing"
                if (show.status == "Continuing") {

                    // Look up DB to get season list for another ajax lookup (i is the json object key, which is the tvdbid)
                    var seasonFeed = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=show&tvdbid=" + i;
                    // ajax season feed via jquery getJSON instead of winjs.xhr, nested winjs.xhr was for some reason continuing to use original URL rather than seasonFeed
                    $.getJSON(seasonFeed, function (data) {

                        // get the latest season in sickbeard's database
                        // they are ordered latest at the top, so we need the first value in the season_list array
                        var showName = data.data.show_name;
                        var lastSeason = data.data.season_list[0];
                        var episodeFeed = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=show.seasons&tvdbid="+i+"&season="+lastSeason;
                
                        // Now load the episode feed to find out episode information
                        $.getJSON(episodeFeed, function(episodes){
                            // get the number of episodes by counting how many entries there are in the array
                            // http://stackoverflow.com/questions/5223/length-of-javascript-object-ie-associative-array
                            Object.countSize = function (obj) {
                                var size = 0, key;
                                for (key in obj) {
                                    if (obj.hasOwnProperty(key)) size++;
                                }
                                return size;
                            };
                            var number = Object.countSize(episodes.data);

                            // Check if airdate is available
                            if (typeof (episodes.data[number]) != "undefined") {

                                // get now
                                var now = new Date();

                                // get airdate
                                var date = episodes.data[number].airdate;
                                var comparisonDate = new Date(date);

                                // check if airdate is after now
                                if (comparisonDate > now) {
                                    var theposter = sbURL + "/showPoster/?show=" + i + "&which=poster";
                                    var output = { group: categories[0], title: showName, subtitle: date, poster: theposter }
                                    list.push(output);
                                }

                            }
                        });
                    });

                }
            });

            // Sort by end date
            // https://gist.github.com/1772996
            var date_sort_asc = function (obj1, obj2) {
                // get our dates in non-american format
                var date1x = obj1.subtitle.split("-");
                var date2x = obj2.subtitle.split("-");
                // define our date objects for comparison
                var date1 = new Date(obj1.subtitle);
                var date2 = new Date(obj2.subtitle);
                // test order requirements
                if (date1 > date2) return 1;
                if (date1 < date2) return -1;
                // if it's the same, do nothing
                return 0;
            }
            list.sort(date_sort_asc);

        }, function (error) {
            console.log(error);
        });

    }
    function regenerateSBDataSeasonEnds() {
        // redefine list
        list.splice(0, list.length);
        // add new items to list
        loadSBDataSeasonEnds();
    }
    regenerateSBDataSeasonEnds();

    WinJS.Namespace.define("SBDataSeasonEnds", {
        items: groupedItems,
        groups: groupedItems.groups,
        getItemReference: getItemReference,
        getItemsFromGroup: getItemsFromGroup,
        resolveGroupReference: resolveGroupReference,
        resolveItemReference: resolveItemReference,
        regenerate: regenerateSBDataSeasonEnds
    });

    // Get a reference for an item, using the group key and item title as a
    // unique reference to the item that can be easily serialized.
    function getItemReference(item) {
        return [item.group.key, item.title];
    }

    // This function returns a WinJS.Binding.List containing only the items
    // that belong to the provided group.
    function getItemsFromGroup(group) {
        return list.createFiltered(function (item) { return item.group.key === group.key; });
    }

    // Get the unique group corresponding to the provided group key.
    function resolveGroupReference(key) {
        for (var i = 0; i < groupedItems.groups.length; i++) {
            if (groupedItems.groups.getAt(i).key === key) {
                return groupedItems.groups.getAt(i);
            }
        }
    }

    // Get a unique item from the provided string array, which should contain a
    // group key and an item title.
    function resolveItemReference(reference) {
        for (var i = 0; i < groupedItems.length; i++) {
            var item = groupedItems.getAt(i);
            if (item.group.key === reference[0] && item.title === reference[1]) {
                return item;
            }
        }
    }

    function generateSBEndDates() {

        var url = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'] + "/api/" + appData.values['sbAPI'] + "/?cmd=shows";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }

})();
