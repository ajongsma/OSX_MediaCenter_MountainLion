(function () {
    "use strict";

    var list = new WinJS.Binding.List();
    var groupedItems = list.createGrouped(
        function groupKeySelector(item) { return item.group.key; },
        function groupDataSelector(item) { return item.group; }
    );

    // TODO: Replace the data with your real data.
    // You can add data from asynchronous sources whenever it becomes available.
    generateCPData().forEach(function (item) {
        list.push(item);
    });

    WinJS.Namespace.define("CPData", {
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

    // Returns an array of sample data that can be added to the application's
    // data list. 
    function generateCPData() {


        /* ===============================================
            FAKE TESTING LISTS
        =============================================== */
        var categories = [
            { key: "recent", title: "Recently Downloaded" },
            { key: "dvd", title: "Soon on DVD" },
            { key: "theatre", title: "Soon at the Theatre" },
        ];

        /*
        var movies = [
            { group: categories[1], title: "example 1", year: "2012", poster: "http://cf2.imgobject.com/t/p/w185/mG2lDhS7MktB4v5OkQZqrU0SBM2.jpg", date: "1/2/3" },
            { group: categories[1], title: "example 1", year: "2012", poster: "http://cf2.imgobject.com/t/p/w185/mG2lDhS7MktB4v5OkQZqrU0SBM2.jpg", date: "1/2/3" },
            { group: categories[1], title: "example 1", year: "2012", poster: "http://cf2.imgobject.com/t/p/w185/mG2lDhS7MktB4v5OkQZqrU0SBM2.jpg", date: "1/2/3" },
        ];
        */
        // var movies = [];

        //var newmovie = { group: "dvd", title: "example 1", year: "2012", poster: "http://cf2.imgobject.com/t/p/w185/mG2lDhS7MktB4v5OkQZqrU0SBM2.jpg", date: "1/2/3" };
        //movies.push(newmovie);

        /* ===============================================
            COUCH POTATO SETTINGS
        =============================================== */
        var settings = new Array();
        settings['ip'] = "192.168.0.9";

        // Couchpotato
        settings['cp_port'] = "5050";
        settings['cp_api'] = "489ff22b167540a88eb65b915ff93449";


        // Building URLS
        var cpurl = "http://" + settings['ip'] + ":" + settings['cp_port'];
        var cp_list = cpurl + "/api/489ff22b167540a88eb65b915ff93449/movie.list/"

        //function getCPList() {
            var mymovies = [];
            WinJS.xhr({
                url: cp_list,
                headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
            }).done(function completed(response) {
                var json = JSON.parse(response.responseText);

                /*
                $.each(json.movies, function (i, movie) {
                    var thetitle = movie.library.info.titles[0];
                    var year = movie.library.info.year;
                    var poster = movie.library.info.images.poster_original;
                    // yukky dates
                    var gettheatre = movie.library.info.released;
                    var getdvd = movie.library.info.release_date.dvd;
                    // nice dates :)
                    var theatre = new Date(gettheatre);
                    var dvd = new Date(getdvd);
                    // convert unknown dates
                    if (gettheatre == "") {
                        theatre = "unknown";
                    } else {
                        // add theatre array
                        //var output = { group: cpGroups[1], title: title, image: poster, date: theatre};
                        var output = { group: "dvd", title: "example 1", year: "2012", poster: "http://cf2.imgobject.com/t/p/w185/mG2lDhS7MktB4v5OkQZqrU0SBM2.jpg", date: "1/2/3" };
                        mymovies.push(output);
                    }
                    if (getdvd == "" || getdvd == "0") {
                        dvd = "unknown";
                    } else {
                        // add dvd array
                        //var output = { group: cpGroups[2], title: thetitle, image: poster, date: theatre };
                        var output = { group: "dvd", title: "example 1", year: "2012", poster: "http://cf2.imgobject.com/t/p/w185/mG2lDhS7MktB4v5OkQZqrU0SBM2.jpg", date: "1/2/3" };
                        mymovies.push(output);
                    }
                });
                */

                // push to movies
                //movies = mymovies;
                //console.log("test: "+mymovies);

                //var movies = [];
                var output = { group: "dvd", title: "example 1", year: "2012", poster: "http://cf2.imgobject.com/t/p/w185/mG2lDhS7MktB4v5OkQZqrU0SBM2.jpg", date: "1/2/3" };
                mymovies.push(output);
                console.log(mymovies);
                //return movies;

            }, function (error) {
                // log errors
                console.log(error);
            });

            //var movies = [];
            //var output = { group: "dvd", title: "example 1", year: "2012", poster: "http://cf2.imgobject.com/t/p/w185/mG2lDhS7MktB4v5OkQZqrU0SBM2.jpg", date: "1/2/3" };
            //movies.push(output);
            //return movies;

            //console.log(movies);
            //return getmovies;
            
        //}

        //console.log(cpRecentList[1].title);
        //return cpRecentList;
        return mymovies;
    }

})();
