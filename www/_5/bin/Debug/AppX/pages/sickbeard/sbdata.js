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
        { key: "01_missed", title: "Today" },
        { key: "02_today", title: "Tomorrow" },
        { key: "03_soon", title: "Soon" },
    ];

    function loadSBData() {
        var sbURL = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'];

        // launch sickbeard button
        $(".titlearea .launch-sickbeard").attr("onclick", "location.href='" + sbURL + "'");

        generateSBToday().then(function (xhr) {
            var json = JSON.parse(xhr.responseText);
            $.each(json.data.missed, function (i, show) {
                loadShow(categories[0], i, show);
            });
            $.each(json.data.today, function (j, show) {
                loadShow(categories[1], j, show);
            });
            $.each(json.data.soon, function (k, show) {
                loadShow(categories[2], k, show);
            });
        }, function (error) {
            console.log(error);
        });

    }

    function loadShow(category, index, show) {
        var tvdb = show.tvdbid;
        var name = show.show_name;
        var pretty_episode = show.season + "x" + show.episode + " - " + show.ep_name;
        var theposter = sbURL + "/showPoster/?show=" + tvdb + "&which=poster";
        var output = { group: category, title: name, subtitle: pretty_episode, poster: theposter, tvdb: tvdb }
        list.push(output);
    }

    function regenerateSBData() {
        // redefine list
        list.splice(0, list.length);
        // add new items to list
        loadSBData();
    }
    regenerateSBData();

    WinJS.Namespace.define("SBData", {
        items: groupedItems,
        groups: groupedItems.groups,
        getItemReference: getItemReference,
        getItemsFromGroup: getItemsFromGroup,
        resolveGroupReference: resolveGroupReference,
        resolveItemReference: resolveItemReference,
        regenerate: regenerateSBData
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

    function generateSBToday() {

        var url = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'] + "/api/" + appData.values['sbAPI'] + "/?cmd=future&sort=date&type=today|missed|soon";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }

})();
