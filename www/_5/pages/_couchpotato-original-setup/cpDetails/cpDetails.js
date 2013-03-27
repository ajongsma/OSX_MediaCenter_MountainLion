(function () {
    "use strict";

    var appData = Windows.Storage.ApplicationData.current.roamingSettings;
    var cpURL = "http://" + appData.values['cpIP'] + ":" + appData.values['cpPort'];

    WinJS.UI.Pages.define("/pages/couchpotato/cpDetails/cpDetails.html", {
        // This function is called whenever a user navigates to this page. It
        // populates the page elements with the app's data.
        ready: function (element, options) {

            if (typeof (CPData.resolveItemReference(options.item)) == "undefined") {
                var item = options && options.item ? CPDataAll.resolveItemReference(options.item) : CPDataAll.items.getAt(0);
            } else {
                var item = options && options.item ? CPData.resolveItemReference(options.item) : CPData.items.getAt(0);
            }

            function loadInfo() {

                // title
                element.querySelector("article .item-title").textContent = item.title;

                // poster
                element.querySelector("article .item-image").src = item.poster;
                element.querySelector("article .item-image").alt = item.title;

                // look up show info via the couchpotato api
                var movieapi = cpURL + "/api/" + appData.values['cpAPI'] + "/movie.get/?id=" + item.id;
                $.getJSON(movieapi, function (data) {

                    // load up the json data in to some variables
                    var genres = data.movie.library.info.genres;
                    var plot = data.movie.library.info.plot;
                    var released = data.movie.library.info.released;
                    var release_dvd = data.movie.library.info.release_date.dvd;
                    var release_theatre = data.movie.library.info.release_date.theater;
                    var writers = data.movie.library.info.writers;
                    var directors = data.movie.library.info.directors;
                    var actors = data.movie.library.info.actors;
                    var runtime = data.movie.library.info.runtime;
                    var year = data.movie.library.info.year;
                    var imdb = data.movie.library.info.imdb;

                    //console.log(actors);
                    //console.log(genres);

                    // couchpotato uses 0 to indicate if a value isn't available
                    // this isn't very pretty so let's make it a bit more user-friendly
                    if (plot == "0" || plot == "") {
                        plot = "Plot details unavailable.";
                    }
                    if (release_dvd == "0" || release_dvd == "") {
                        var dvd_date = "Unknown";
                    } else {
                        // Refactor Dates
                        var dvd = new Date(release_dvd * 1000);
                        var dvd_date = dvd.getDate() + "/" + (dvd.getMonth() + 1) + "/" + dvd.getFullYear();
                    }
                    if (released == "0" || released == "") {
                        var theatre_date = "Unknown";
                    } else {
                        var theatre = new Date(released);
                        var theatre_date = theatre.getDate() + "/" + (theatre.getMonth() + 1) + "/" + theatre.getFullYear();
                    }
                    if (actors == "" || actors == "undefined" || typeof(actors) == "undefined") {
                        var actors_list = "Unknown";
                    } else {
                        // create empty actors_list variable
                        var actors_list = "";
                        // run through each actor
                        $.each(actors, function (i, actor) {
                            // check if any of the actors have spaces before their name
                            // we need to do this because sometimes the CP API returns comma-space (", ")
                            // separated actors, and sometimes just comma separated (",")
                            if (actor.substring(0, 1) == " ") {
                                // if there is a space at the front, cut it off
                                actor = actor.substring(1, actor.length);
                            }
                            // Now that everybody is formatted the same, let's enforce our 
                            // own formatting rules of ", "
                            // but not on the first actor.
                            if (i != 0) {
                                actor = ", " + actor;
                            }
                            actors_list = actors_list + actor;
                        });
                    }
                    if (genres == "" || genres == "0" || genres == "undefined") {
                        var genres_list = "Unknown";
                    } else {
                        var genres_list = "";
                        // do what we did with the actors above
                        // this ensure uniform formatting for this sort of data
                        $.each(genres, function (k, genre) {
                            if (genre.substring(0, 1) == " ") {
                                genre = genre.substring(1, genre.length);
                            }
                            if (k != 0) {
                                genre = ", " + genre;
                            }
                            genres_list = genres_list + genre;
                        });
                    }

                    // carefully place each piece of data on to our page
                    element.querySelector("article .item-synopsis").textContent = plot;
                    element.querySelector("article .item-genres span").textContent = genres_list;
                    element.querySelector("article .item-starring span").textContent = actors_list;
                    element.querySelector("article .item-theatre span").textContent = theatre_date;
                    element.querySelector("article .item-dvd span").textContent = dvd_date;

                    // IMDB Button
                    var imdblink = "http://www.imdb.com/title/" + imdb + "/";
                    element.querySelector("article button.imdb").onclick = function () {
                        location.href = imdblink;
                    }

                    // Refresh Info Button
                    var refreshlink = cpURL + "/api/" + appData.values['cpAPI'] + "/movie.refresh/?id=" + item.id;
                    element.querySelector("article button.reloadinfo").onclick = function () {
                        $.getJSON(refreshlink, function (data) {
                            CPData.regenerate();
                            loadInfo();
                        });
                    }

                    // Search for Movie Button
                    // .search-movie
                    var searchlink = cpURL + "/api/" + appData.values['cpAPI'] + "/movie.refresh/?id=" + item.id;
                    element.querySelector("article button.search-movie").onclick = function () {
                        $.getJSON(refreshlink, function (data) {
                            //CPData.regenerate();
                            //loadInfo();
                        });
                    }

                });
            }
            loadInfo();

            // content
            element.querySelector(".content").focus();
        }
    });
})();
