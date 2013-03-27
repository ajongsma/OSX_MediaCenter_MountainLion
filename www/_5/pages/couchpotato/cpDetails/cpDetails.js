(function () {
    "use strict";

    var appData = Windows.Storage.ApplicationData.current.roamingSettings;
    var cpURL = "http://" + appData.values['cpIP'] + ":" + appData.values['cpPort'];

    WinJS.UI.Pages.define("/pages/couchpotato/cpDetails/cpDetails.html", {
        // This function is called whenever a user navigates to this page. It
        // populates the page elements with the app's data.
        ready: function (element, options) {

            // Due to our data being all over the place, I've passed a "type" option through the nav.Navigate command
            // that explains which data type we should be using
            // Here I use a case statement to define which data set our "item" should be referenced from
            switch (options.type) {
                case "CPDataSoon":
                    var item = options && options.item ? CPDataSoon.resolveItemReference(options.item) : CPDataSoon.items.getAt(0);
                    break;
                case "CPDataDownloaded":
                    var item = options && options.item ? CPDataDownloaded.resolveItemReference(options.item) : CPDataDownloaded.items.getAt(0);
                    break;
                case "CPData":
                    var item = options && options.item ? CPData.resolveItemReference(options.item) : CPData.items.getAt(0);
                    break;
                default:
                    var item = options && options.item ? CPData.resolveItemReference(options.item) : CPData.items.getAt(0);
                    break;
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
                    var quality = data.movie.profile.label;
                    var titles = data.movie.library.titles;
                    var libraryid = data.movie.library_id;

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
                    element.querySelector("article .item-quality span").textContent = quality;

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

                    // Delete Movie
                    var deletelink = cpURL + "/api/" + appData.values['cpAPI'] + "/movie.delete/?id=" + item.id + "&delete_from=all"
                    element.querySelector("article button.delete-movie").onclick = function () {

                        // load popup window asking confirmation
                        var message = "You are about to delete "+item.title+" from CouchPotato. Are you sure you want to do that?";
                        var msg = new Windows.UI.Popups.MessageDialog(message, "Confirm Delete");
                        msg.commands.append(new Windows.UI.Popups.UICommand("Delete", deleteMovieConfirm));
                        msg.commands.append(new Windows.UI.Popups.UICommand("Cancel", closePopup));
                        msg.defaultCommandIndex = 1;
                        msg.cancelCommandIndex = 1;
                        msg.showAsync();

                        function deleteMovieConfirm() {
                            $.getJSON(deletelink, function (data) {
                                if (data.success == true) {
                                    // go back to where you came from!
                                    WinJS.Navigation.back(1).done(function () {
                                        // reload SBData, SBDataSoon and CPDataDownloaded
                                        if (typeof (CPData) != "undefined") { CPData.regenerate(); }
                                        if (typeof (CPDataSoon) != "undefined") { CPDataSoon.regenerate(); }
                                        if (typeof (CPDataDownloaded) != "undefined") { CPDataDownloaded.regenerate(); }
                                    });
                                } else {
                                    var messagefail = "Movie failed to delete.";
                                    var msgfail = new Windows.UI.Popups.MessageDialog(messagefail, "Error");
                                    msg.showAsync();
                                }
                            });
                        }
                        function closePopup() {
                            // hide dialog
                        }
                    }

                    // Edit Movie Button
                    $(".item-edit-anchor").unbind("click");
                    $(".item-edit-anchor").click(function () {

                        var expandedItem = document.querySelector(".item-edit");
                        var affectedItems = document.querySelectorAll(".expand-affected-item");

                        // Check if the edit box is already visible
                        // This way, we're only populating the dropdown boxes on the way in
                        if (expandedItem.style.display === "none") {

                            // Load in current titles
                            var titleBox = $("<select id='edit-titleBox' />");
                            $.each(titles, function (i, title) {
                                // compare to current title
                                if (title.default == true) {
                                    titleBox.append("<option value='" + title.title + "' selected>" + title.title + "</option>");
                                } else {
                                    titleBox.append("<option value='" + title.title + "'>" + title.title + "</option>");
                                }
                            });
                            $(".item-edit-title").html(titleBox);

                            // Load in profiles
                            var profileBox = $("<select id='edit-profileBox' />");
                            var profileURL = "http://" + appData.values['cpIP'] + ":" + appData.values['cpPort'] + "/api/" + appData.values['cpAPI'] + "/profile.list/";
                            $.ajax({
                                url: profileURL,
                                dataType: 'json',
                                async: false,
                                success: function (profiles) {
                                    $.each(profiles.list, function (j, profile) {
                                        // Don't show hidden profiles
                                        if (profile.hide == false) {
                                            if (profile.label == quality) {
                                                profileBox.append("<option value='" + profile.id + "' selected>" + profile.label + "</option>");
                                            } else {
                                                profileBox.append("<option value='" + profile.id + "'>" + profile.label + "</option>");
                                            }
                                        }
                                    });
                                }
                            });
                            $(".item-edit-quality").html(profileBox);

                            // Finally, animate the edit box in
                            showEditBox(expandedItem, affectedItems);
                        } else {
                            hideEditBox(expandedItem, affectedItems);
                        }

                        $(".item-edit-save").click(function () {
                            // get values from both drop-down boxes
                            var newtitle = $("#edit-titleBox").val();
                            var newprofile = $("#edit-profileBox").val();
                            // use the couchpotato api to send an update request
                            var updateURL = "http://" + appData.values['cpIP'] + ":" + appData.values['cpPort'] + "/api/" + appData.values['cpAPI'] + "/movie.edit/?profile_id=" + newprofile + "&id=" + libraryid + "&default_title=" + newtitle;
                            $.ajax({
                                url: updateURL,
                                dataType: "json",
                                async: false,
                                success: function (data) {
                                    hideEditBox(expandedItem, affectedItems);
                                    reloadData();
                                    element.querySelector("article .item-image").alt = newtitle + " (" + year + ")";
                                    element.querySelector("article .item-title").textContent = newtitle + " (" + year + ")";
                                }
                            });
                        });
                    });

                });
            }
            loadInfo();

            // hide edit box by default
            document.querySelector(".item-edit").style.display = "none";

            // function to show edit box
            function showEditBox(expandedItem, affectedItems) {
                var expandAnimation = WinJS.UI.Animation.createExpandAnimation(expandedItem, affectedItems);
                // apply styles to element
                expandedItem.style.display = "block";
                expandedItem.style.position = "inherit";
                expandedItem.style.opacity = "1";
                // execute animation
                expandAnimation.execute();
            }

            // function to hide the edit box
            function hideEditBox(expandedItem, affectedItems) {
                var collapseAnimation = WinJS.UI.Animation.createCollapseAnimation(expandedItem, affectedItems);
                // Apply styles
                expandedItem.style.position = "absolute";
                expandedItem.style.opacity = "0";
                // Execute animation
                collapseAnimation.execute().done(
                    function () { expandedItem.style.display = "none"; }
                );
            }

            // Reloading the data is done after an edit has taken place
            function reloadData() {
                if (typeof (CPData) != "undefined") { CPData.regenerate(); }
                if (typeof (CPDataSoon) != "undefined") { CPData.regenerate(); }
                if (typeof (CPDataDownloaded) != "undefined") { CPData.regenerate(); }
                loadInfo();
            }

            // content
            element.querySelector(".content").focus();
        }
    });
})();
