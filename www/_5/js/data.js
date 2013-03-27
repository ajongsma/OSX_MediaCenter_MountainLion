(function () {
    "use strict";

    var appData = Windows.Storage.ApplicationData.current.roamingSettings;

    var list = new WinJS.Binding.List();
    var groupedItems = list.createGrouped(
        function groupKeySelector(item) { return item.group.key; },
        function groupDataSelector(item) { return item.group; }
    );

    // TODO: Replace the data with your real data.
    // You can add data from asynchronous sources whenever it becomes available.
    /*
    generateMainData().forEach(function (item) {
        list.push(item);
    });
    */

    WinJS.Namespace.define("Data", {
        items: groupedItems,
        groups: groupedItems.groups,
        getItemReference: getItemReference,
        getItemsFromGroup: getItemsFromGroup,
        resolveGroupReference: resolveGroupReference,
        resolveItemReference: resolveItemReference,
        regenerate: regenerateMainData
    });

    // Regenerate main data on homepage
    function regenerateMainData() {
        // redefine list
        list.splice(0, list.length);
        // add new items to list
        generateMainData().forEach(function (item) {
            list.push(item);
        });
    }
    // Load the data in the first instance
    regenerateMainData();

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
    function generateMainData() {

        var sabLogo = "images/services/sab.png";
        var sbLogo = "images/services/sickbeard.png";
        var cpLogo = "images/services/couch.png";
        var hpLogo = "images/services/headphones.png";
        var gaLogo = "images/services/sab.png";
        var myLogo = "images/services/sab.png";

        // Each of these sample groups must have a unique key to be displayed
        // separately.
        var maingroups = [
            { key: "1_services", title: "Services", subtitle: "Quick links to access your services" },
            //{ key: "2_links", title: "Links", subtitle: "Links", backgroundImage: lightGray, description: groupDescription },
            //{ key: "3_movies", title: "Upcoming Movies", subtitle: "Upcoming movie releases", backgroundImage: mediumGray, description: groupDescription },
        ];

        // Each of these sample items should have a reference to a particular
        // group.
        /*
        var mainitems = [
            { group: maingroups[0], title: "sabNZBD", subtitle: "Downloading", backgroundImage: sabLogo, template: "sabnzbd" },
            { group: maingroups[0], title: "SickBeard", subtitle: "TV Shows", backgroundImage: sbLogo, template: "sickbeard" },
            { group: maingroups[0], title: "CouchPotato", subtitle: "Movies", backgroundImage: cpLogo, template: "couchpotato" },
            { group: maingroups[0], title: "Headphones", subtitle: "Music", backgroundImage: hpLogo, template: "headphones" },
            // Gamez API is currently broken { group: sampleGroups[0], title: "Gamez", subtitle: "Games", backgroundImage: gaLogo, template: "couchpotato" },
            // Mylar has no API enabled yet { group: sampleGroups[0], title: "Mylar", subtitle: "Comics", backgroundImage: myLogo, template: "couchpotato" },
            { group: maingroups[0], title: "Links", subtitle: "Quicklinks", backgroundImage: "", template: "couchpotato" },
        ];
        */
        var mainitems = [];
        var totalObjects = 0;

        // Only push in our services if the user has them enabled
        if (appData.values["sabToggle"] == true) {
            totalObjects++;
            var item = { group: maingroups[0], title: "SABnzbd", subtitle: "Downloading", backgroundImage: sabLogo, template: "sabnzbd" };
            mainitems.push(item);
        }
        if (appData.values["sbToggle"] == true) {
            totalObjects++;
            var item = { group: maingroups[0], title: "SickBeard", subtitle: "TV Shows", backgroundImage: sbLogo, template: "sickbeard" };
            mainitems.push(item);
        }
        if (appData.values["cpToggle"] == true) {
            totalObjects++;
            var item = { group: maingroups[0], title: "CouchPotato", subtitle: "Movies", backgroundImage: cpLogo, template: "couchpotato" };
            mainitems.push(item);
        }
        if (appData.values["hpToggle"] == true) {
            totalObjects++;
            var item = { group: maingroups[0], title: "Headphones", subtitle: "Music", backgroundImage: hpLogo, template: "headphones" };
            mainitems.push(item);
        }
        if (appData.values["linksToggle"] == true) {
            totalObjects++;
            var item = { group: maingroups[0], title: "Links", subtitle: "Quicklinks", backgroundImage: "", template: "couchpotato" };
            mainitems.push(item);
        }

        if (totalObjects > 0) {
            $("#configureServices").hide();
        } else {
            $("#configureServices").show().click(function () {
                WinJS.UI.SettingsFlyout.showSettings("services", "/pages/settings/services.html");
            });
        }

        return mainitems;
    }

})();
