(function () {
    "use strict";

    var appData = Windows.Storage.ApplicationData.current.roamingSettings;
    var list = new WinJS.Binding.List();
    var groupedItems = list.createGrouped(
        function groupKeySelector(item) { return item.group.key; },
        function groupDataSelector(item) { return item.group; }
    );

    // set up our categories
    // I originally wanted a "recent" category that would list recent downloads
    // but CP2 doesn't have any sort of "history" or any way to filter movie.list?status=done by date downloaded
    var categories = [
        { key: "0_recent", title: "Recently Downloaded" },
        { key: "2_theatre", title: "Soon at the Theatre" },
        { key: "1_dvd", title: "Soon on DVD" },
    ];

    // Load couchpotato data via generateCPDate then push to the list variable
    function loadCPData() {
        generateCPData().then(function (xhr) {

            var json = JSON.parse(xhr.responseText);

            $.each(json.movies, function (i, movie) {
                var theid = movie.library_id;
                var thetitle = movie.library.info.titles[0];
                var theyear = movie.library.info.year;
                var theposter = movie.library.info.images.poster_original;
                // yukky dates
                var gettheatre = movie.library.info.released;
                if (typeof (movie.library.info.release_date) != "undefined") {
                    var getdvd = movie.library.info.release_date.dvd;
                } else {
                    var getdvd = "Unknown";
                }
                // make fallback image for poster
                if (theposter == "" || theposter == undefined) {
                    theposter = "/images/blank-couchpotato.png";
                }
                // convert unknown dates
                if (gettheatre == "" || gettheatre == "0") {
                    var theatre = "unknown";
                } else {
                    var theatre = new Date(gettheatre);
                    var thedate = theatre.getDate() + "/" + (theatre.getMonth() + 1) + "/" + theatre.getFullYear();
                    // check if the user has opted not to show theatre dates before today (ie. dates that have already passed)
                    var now = new Date();
                    if (appData.values['cpPastTheatre']) {
                        // show past dates, so just push out everything
                        var output = { group: categories[1], title: thetitle + " (" + theyear + ")", poster: theposter, date: thedate, id: theid };
                        // push to final list array
                        list.push(output);
                    } else {
                        // don't show movies where theatre is more than now (ie. in the future)
                        if (theatre > now) {
                            var output = { group: categories[1], title: thetitle + " (" + theyear + ")", poster: theposter, date: thedate, id: theid };
                            // push to final list array
                            list.push(output);
                        }
                    }
                }
                if (getdvd == "" || getdvd == "0") {
                    var dvd = "unknown";
                } else {
                    var dvd = new Date(getdvd * 1000);
                    thedate = dvd.getDate() + "/" + (dvd.getMonth() + 1) + "/" + dvd.getFullYear();
                    var output = { group: categories[2], title: thetitle + " (" + theyear + ")", poster: theposter, date: thedate, id: theid };
                    list.push(output);
                }
            });

            // Sort by release date
            // https://gist.github.com/1772996
            var date_sort_asc = function (obj1, obj2) {
                // get our dates in non-american format
                var date1x = obj1.date.split("/");
                var date2x = obj2.date.split("/");
                // define our date objects for comparison
                var date1 = new Date(date1x[2], date1x[1], date1x[0]);
                var date2 = new Date(date2x[2], date2x[1], date2x[0]);
                // test order requirements
                if (date1 > date2) return 1;
                if (date1 < date2) return -1;
                // if it's the same, do nothing
                return 0;
            }
            list.sort(date_sort_asc);


        }, function (error) {
            var message = "There appears to be an error with your CouchPotato configuration. Please check all fields are correct in your settings.";
            var msg = new Windows.UI.Popups.MessageDialog(message, "Error");
            msg.commands.append(new Windows.UI.Popups.UICommand("Show Settings", showCPSettings));
            msg.commands.append(new Windows.UI.Popups.UICommand("Close", closePopup));
            msg.defaultCommandIndex = 0;
            msg.cancelCommandIndex = 1;
            msg.showAsync();

            function showCPSettings() {
                WinJS.UI.SettingsFlyout.showSettings("services", "/pages/settings/services.html#settings-couchpotato");
            }
            function closePopup(){
                // hide dialog
            }
        });
    }

    WinJS.Namespace.define("CPData", {
        items: groupedItems,
        groups: groupedItems.groups,
        getItemReference: getItemReference,
        getItemsFromGroup: getItemsFromGroup,
        resolveGroupReference: resolveGroupReference,
        resolveItemReference: resolveItemReference,
        regenerate: regenerateCPData
    });

    function regenerateCPData() {
        // redefine list
        list.splice(0, list.length);
        // add new items to list
        loadCPData();
    }
    regenerateCPData();

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
    function generateCPData() {

        var cp_list = "http://" + appData.values["cpIP"] + ":" + appData.values["cpPort"] + "/api/" + appData.values["cpAPI"] + "/movie.list/";

        return WinJS.xhr({
            url: cp_list,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }

})();
