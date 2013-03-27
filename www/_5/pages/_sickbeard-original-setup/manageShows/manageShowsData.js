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
    var categories = [
        { key: "01_continuing", title: "Continuing" },
        { key: "02_ended", title: "Ended" },
    ];

    function loadSBDataAll() {
        var sbURL = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'];

        // launch sickbeard button
        $(".titlearea .launch-sickbeard").attr("onclick", "location.href='" + sbURL + "'");

        // Load sickbeard data via generateSBDate then push to the list variable
        generateSBAll().then(function (xhr) {

            var json = JSON.parse(xhr.responseText);

            // Cycle through each show
            $.each(json.data, function (i, show) {

                // get show details
                var name = i;
                var status = show.status;
                var tvdb = show.tvdbid;
                var theposter = sbURL + "/showPoster/?show=" + tvdb + "&which=poster";

                if (status == "Continuing") {
                    var category = categories[0];
                } else {
                    var category = categories[1];
                }
                var output = { group: category, title: name, subtitle: "", poster: theposter, tvdb: tvdb }
                list.push(output);

            });


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
    function regenerateSBDataAll() {
        // redefine list
        list.splice(0, list.length);
        // add new items to list
        loadSBDataAll();
    }
    regenerateSBDataAll();

    WinJS.Namespace.define("SBDataAll", {
        items: groupedItems,
        groups: groupedItems.groups,
        getItemReference: getItemReference,
        getItemsFromGroup: getItemsFromGroup,
        resolveGroupReference: resolveGroupReference,
        resolveItemReference: resolveItemReference,
        regenerate: regenerateSBDataAll
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

    function generateSBAll() {

        var url = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'] + "/api/" + appData.values['sbAPI'] + "/?cmd=shows&sort=name";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }

})();
