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
        { key: "02_today", title: "TV Today" },
        { key: "03_seasonstart", title: "Season Start Dates" },
        { key: "04_seasonend", title: "Season End Dates" },
    ];

    // Load sickbeard data via generateSBDate then push to the list variable
    generateSBRecent().then(function (xhr) {

        var json = JSON.parse(xhr.responseText);

        // Check if array is empty
        if(json.length = 0) {
            // no download history found
        } else {
            // start a count so we can cap our downloads at a specific limit
            var downloadCount = -1;
            if(appData.values['sbRecentShows']){
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
                        if(filename.indexOf("PROPER") > -1 ){
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


    }, function(error){
        console.log(error);
    });

    generateSBToday().then(function (xhr) {
        var json = JSON.parse(xhr.responseText);
        $.each(json.data.missed, function (i, show) {
            var tvdb = show.tvdbid;
            var name = show.show_name;
            var pretty_episode = show.season + "x" + show.episode + " - " + show.ep_name;
            var theposter = sbURL + "/showPoster/?show=" + tvdb + "&which=poster";
            var output = { group: categories[1], title: name, subtitle: pretty_episode, poster: theposter, tvdb: tvdb }
            list.push(output);
        });
    }, function (error) {
        console.log(error);
    });

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
                var output = { group: categories[2], title: name, subtitle: prettydate, poster: theposter, tvdb: tvdb }
                list.push(output);
            }
        });


    }, function (error) {
        console.log(error);
    });

    // Generate Ending Season Dates
    generateSBEndDates().then(function (xhr) {
        /*

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
                        // WHY ISNT THIS WORKING?
                        var date = episodes.data[number].airdate;
                        var theposter = sbURL + "/showPoster/?show=" + i + "&which=poster";
                        var output = { group: categories[3], title: showName, subtitle: date, poster: theposter }
                        list.push(output);
                    });
                });

            }
        });
        */


    }, function (error) {
        console.log(error);
    });

    WinJS.Namespace.define("SBData", {
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

    function generateSBRecent() {

        var url = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=history&limit=50";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }

    function generateSBToday() {

        var url = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=future&sort=date&type=missed";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }

    // Returns an array of sample data that can be added to the application's
    // data list. 
    function generateSBStartDates() {

        var url = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=future&sort=date&type=later";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }

    function generateSBEndDates() {

        var url = sbURL + "/api/" + appData.values['sbAPI'] + "/?cmd=shows";
        return WinJS.xhr({
            url: url,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        });

    }

})();
