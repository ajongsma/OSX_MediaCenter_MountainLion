(function () {
    "use strict";

    var appData = Windows.Storage.ApplicationData.current.roamingSettings;
    var cpURL = "http://" + appData.values['cpIP'] + ":" + appData.values['cpPort'];

    var list = new WinJS.Binding.List();
    var groupedItems = list.createGrouped(
        function groupKeySelector(item) { return item.group.key; },
        function groupDataSelector(item) { return item.group; }
    );

    // set up our categories
    var categories = [
        { key: "01_allmovies", title: "Wanted Movies" },
    ];

    function loadCPData() {
        var cpURL = "http://" + appData.values['sbIP'] + ":" + appData.values['sbPort'];

        // launch CP button
        $(".titlearea .launch-couchpotato").attr("onclick", "location.href='" + cpURL + "'");

        generateCPData().then(function (xhr) {

            var json = JSON.parse(xhr.responseText);

            $.each(json.movies, function (i, movie) {
                var theid = movie.library_id;
                var titles = movie.library.titles;
                var theyear = movie.library.info.year;
                var theposter = movie.library.info.images.poster_original;
                var thetitle = "";

                // check for default title
                $.each(titles, function (h, title) {
                    if (title.default == true) {
                        thetitle = title.title;
                    }
                });

                // yukky dates
                var gettheatre = movie.library.info.released;
                if (typeof (movie.library.info.release_date) != "undefined") {
                    var getdvd = movie.library.info.release_date.dvd;
                } else {
                    var getdvd = "Date Unknown";
                }
                // make fallback image for poster
                if (theposter == "" || theposter == undefined) {
                    theposter = "/images/blank-couchpotato.png";
                }
                // convert unknown dates
                var theatredate = "";
                if (gettheatre == "" || gettheatre == "0") {
                    theatredate = "Date Unknown";
                } else {
                    var theatre = new Date(gettheatre);
                    theatredate = theatre.getDate() + "/" + (theatre.getMonth() + 1) + "/" + theatre.getFullYear();
                }

                var output = { group: categories[0], title: thetitle + " (" + theyear + ")", poster: theposter, subtitle: theatredate, id: theid };
                list.push(output);

            });


        }, function (error) {
            var message = "There appears to be an error with your Couchpotato configuration. Please check all fields are correct in your settings.";
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
    function regenerateCPData() {
        // redefine list
        list.splice(0, list.length);
        // add new items to list
        loadCPData();
    }
    regenerateCPData();

    WinJS.Namespace.define("CPData", {
        items: groupedItems,
        groups: groupedItems.groups,
        getItemReference: getItemReference,
        getItemsFromGroup: getItemsFromGroup,
        resolveGroupReference: resolveGroupReference,
        resolveItemReference: resolveItemReference,
        regenerate: regenerateCPData
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

    function generateCPData() {

        var url = "http://" + appData.values["cpIP"] + ":" + appData.values["cpPort"] + "/api/" + appData.values["cpAPI"] + "/movie.list/";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }

})();
