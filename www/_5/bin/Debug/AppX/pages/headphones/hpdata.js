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
        { key: "recent", title: "Recently Downloaded" },
        { key: "upcoming", title: "Upcoming" },
        { key: "wanted", title: "Wanted" },
    ];

    generateHPRecent().then(function (xhr) {

        var json = JSON.parse(xhr.responseText);
        var albumcount = 0;

        $.each(json, function (i, album) {
            if (album.Status == "Processed") {
                albumcount++;
                if (albumcount < 10) {
                    var albumid = album.AlbumID;
                    var title = album.FolderName;
                    // getAlbumArt API doesn't appear to work any more and the history API doesn't include an ASIN number so no album art for me :(
                    // var albumartURL = "";
                    var output = { group: categories[0], title: title, date: "", poster: "/images/blank.gif" };
                    list.push(output);
                }
            }
        });

    }, function (error) {
        console.log(error);
    });

    // Load couchpotato data via generateCPDate then push to the list variable
    generateHPUpcoming().then(function (xhr) {

        var json = JSON.parse(xhr.responseText);

        $.each(json, function (i, album) {
            var thetitle = album.AlbumTitle;
            var theartist = album.ArtistName;
            var thedate = album.ReleaseDate;
            var thesin = album.AlbumASIN;
            if(thesin == "null" || thesin == "") {
                var theposter = "/images/blank.gif";
            } else {
                var theposter = "http://ec1.images-amazon.com/images/P/"+thesin+".01.MZZZZZZZ.jpg";
            }
            var output = { group: categories[1], title: theartist + " - " + thetitle, date: thedate, poster: theposter };
            // push to final list array
            list.push(output);
        });


    }, function(error){
        console.log(error);
    });

    generateHPWanted().then(function (xhr) {

        var json = JSON.parse(xhr.responseText);

        $.each(json, function (i, album) {
            var thetitle = album.AlbumTitle;
            var theartist = album.ArtistName;
            var thedate = album.ReleaseDate;
            var thesin = album.AlbumASIN;
            if (thesin == "null" || thesin == "") {
                var theposter = "/images/blank.gif";
            } else {
                var theposter = "http://ec1.images-amazon.com/images/P/" + thesin + ".01.MZZZZZZZ.jpg";
            }
            var output = { group: categories[2], title: theartist + " - " + thetitle, date: thedate, poster: theposter };
            // push to final list array
            list.push(output);
        });

    }, function (error) {
        console.log(error);
    });

    WinJS.Namespace.define("HPData", {
        items: groupedItems,
        groups: groupedItems.groups,
        getItemReference: getItemReference,
        getItemsFromGroup: getItemsFromGroup,
        resolveGroupReference: resolveGroupReference,
        resolveItemReference: resolveItemReference
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

    function generateHPRecent() {
        var url = "http://" + appData.values['hpIP'] + ":" + appData.values['hpPort'] + "/api?apikey=" + appData.values['hpAPI'] + "&cmd=getHistory";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });
    }

    function generateHPUpcoming() {
        var url = "http://" + appData.values['hpIP'] + ":" + appData.values['hpPort'] + "/api?apikey=" + appData.values['hpAPI'] + "&cmd=getUpcoming";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });
    }

    function generateHPWanted() {
        var url = "http://" + appData.values['hpIP'] + ":" + appData.values['hpPort'] + "/api?apikey=" + appData.values['hpAPI'] + "&cmd=getWanted";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });
    }

})();
