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
        { key: "01_seasonstart", title: "Season Start Dates" },
    ];

    function loadSBDataSeasonStarts() {
        var sbURL = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'];

        // Generate Season Start Dates
        generateSBStartDates().then(function (xhr) {

            var json = JSON.parse(xhr.responseText);

            $.each(json.data.later, function (i, show) {
                // only return episodes that are "episode 1"
                if (show.episode == "1") {
                    // date formating
                    var date = new Date(show.airdate);
                    var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
                    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
                    var prettydate = days[date.getDay()] + ", " + date.getDate() + " " + months[date.getMonth()] + " " + date.getFullYear();
                    // show paster
                    var tvdb = show.tvdbid;
                    var theposter = sbURL + "/showPoster/?show=" + tvdb + "&which=poster";
                    // show details
                    var name = show.show_name + " Season " + show.season;
                    var output = { group: categories[0], title: name, subtitle: prettydate, poster: theposter, tvdb: tvdb }
                    list.push(output);
                }
            });


        }, function (error) {
            console.log(error);
        });

    }
    function regenerateSBDataSeasonStarts() {
        // redefine list
        list.splice(0, list.length);
        // add new items to list
        loadSBDataSeasonStarts();
    }
    regenerateSBDataSeasonStarts();

    WinJS.Namespace.define("SBDataSeasonStarts", {
        items: groupedItems,
        groups: groupedItems.groups,
        getItemReference: getItemReference,
        getItemsFromGroup: getItemsFromGroup,
        resolveGroupReference: resolveGroupReference,
        resolveItemReference: resolveItemReference,
        regenerate: regenerateSBDataSeasonStarts
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

    // Returns an array of sample data that can be added to the application's
    // data list. 
    function generateSBStartDates() {

        var url = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'] + "/api/" + appData.values['sbAPI'] + "/?cmd=future&sort=date&type=later";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }

})();
