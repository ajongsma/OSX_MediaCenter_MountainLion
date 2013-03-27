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
        { key: "01_recent", title: "Recently Downloaded" },
    ];

    function loadSBDataHistory() {
        var sbURL = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'];

        // launch sickbeard button
        $(".titlearea .launch-sickbeard").attr("onclick", "location.href='" + sbURL + "'");

        // Load sickbeard data via generateSBDate then push to the list variable
        generateSBRecent().then(function (xhr) {

            var json = JSON.parse(xhr.responseText);

            // Check if array is empty
            if (json.length = 0) {
                // no download history found
            } else {
                // start a count so we can cap our downloads at a specific limit
                var downloadCount = -1;
                if (appData.values['sbRecentShows']) {
                    var maxDownloads = appData.values['sbRecentShows'];
                } else {
                    var maxDownloads = 12;
                }
                $.each(json.data, function (i, show) {
                    if (show.status == "Downloaded") {
                        // limit to max shows number
                        downloadCount = downloadCount + 1;
                        if (downloadCount < maxDownloads) {
                            var tvdb = show.tvdbid;
                            var name = show.show_name;
                            var season = show.season;
                            var episode = show.episode;
                            var quality = show.quality;
                            var pretty_episode = season + "x" + episode;
                            var theposter = sbURL + "/showPoster/?show=" + tvdb + "&which=poster";
                            // find out if this episode is a proper/repack
                            var filename = show.resource;
                            if (filename.indexOf("PROPER") > -1) {
                                // is a PROPER
                                pretty_episode = pretty_episode + " (PROPER)";
                            } else if (filename.indexOf("REPACK") > -1) {
                                // is a REPACK
                                pretty_episode = pretty_episode + " (REPACK)";
                            }
                            var output = { group: categories[0], title: name, subtitle: pretty_episode, poster: theposter, tvdb: tvdb }
                            list.push(output);
                        }
                    }
                });
            }


        }, function (error) {
            var message = "There appears to be an error with your Sickbeard configuration. Please check all fields are correct in your settings.";
            var msg = new Windows.UI.Popups.MessageDialog(message, "Error");
            msg.commands.append(new Windows.UI.Popups.UICommand("Show Settings", showSettings));
            msg.commands.append(new Windows.UI.Popups.UICommand("Close", closePopup));
            msg.defaultCommandIndex = 0;
            msg.cancelCommandIndex = 1;
            msg.showAsync();

            function showSettings() {
                WinJS.UI.SettingsFlyout.showSettings("services", "/pages/settings/services.html");
            }
            function closePopup() {
                // hide dialog
            }
        });

    }
    function regenerateSBDataHistory() {
        // redefine list
        list.splice(0, list.length);
        // add new items to list
        loadSBDataHistory();
    }
    regenerateSBDataHistory();

    WinJS.Namespace.define("SBDataHistory", {
        items: groupedItems,
        groups: groupedItems.groups,
        getItemReference: getItemReference,
        getItemsFromGroup: getItemsFromGroup,
        resolveGroupReference: resolveGroupReference,
        resolveItemReference: resolveItemReference,
        regenerate: regenerateSBDataHistory
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

    function generateSBRecent() {

        var url = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'] + "/api/" + appData.values['sbAPI'] + "/?cmd=history&limit=50";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }


})();
