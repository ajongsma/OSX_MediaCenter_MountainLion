(function () {
    "use strict";

    var appData = Windows.Storage.ApplicationData.current.roamingSettings;
    var appView = Windows.UI.ViewManagement.ApplicationView;
    var appViewState = Windows.UI.ViewManagement.ApplicationViewState;
    var nav = WinJS.Navigation;
    var ui = WinJS.UI;

    ui.Pages.define("/pages/couchpotato/couchpotato.html", {
        // Navigates to the groupHeaderPage. Called from the groupHeaders,
        // keyboard shortcut and iteminvoked.
        navigateToGroup: function (key) {
            //nav.navigate("/pages/sickbeard/sbDetails/sbDetails.html", { groupKey: key });
        },

        // This function is called whenever a user navigates to this page. It
        // populates the page elements with the app's data.
        ready: function (element, options) {
            var listView = element.querySelector(".groupeditemslist").winControl;
            listView.groupHeaderTemplate = element.querySelector(".headertemplate");
            listView.itemTemplate = element.querySelector(".itemtemplate");
            listView.oniteminvoked = this._itemInvoked.bind(this);

            // Set up a keyboard shortcut (ctrl + alt + g) to navigate to the
            // current group when not in snapped mode.
            listView.addEventListener("keydown", function (e) {
                if (appView.value !== appViewState.snapped && e.ctrlKey && e.keyCode === WinJS.Utilities.Key.g && e.altKey) {
                    var data = listView.itemDataSource.list.getAt(listView.currentItem.index);
                    this.navigateToGroup(data.group.key);
                    e.preventDefault();
                    e.stopImmediatePropagation();
                }
            }.bind(this), true);

            this._initializeLayout(listView, appView.value);
            listView.element.focus();

            /* ===============================================
                APP BAR FUNCTIONS
            =============================================== */
            document.getElementById("launchCouchPotato").onclick = function () {
                // launch couchpotato in your browser
                var cpURL = "http://" + appData.values['cpIP'] + ":" + appData.values['cpPort'];
                location.href = cpURL;
            }
            document.getElementById("cpDownloaded").onclick = function () {
                // navigate to downloaded movies
                nav.navigate("/pages/couchpotato/cpDownloaded/cpDownloaded.html");
            }
            document.getElementById("cpSoon").onclick = function () {
                // navigate to soon
                nav.navigate("/pages/couchpotato/cpSoon/cpSoon.html");
            }
            document.getElementById("cpAddShow").onclick = function () {
                // hide the appbar
                var appBar = document.getElementById("appbar").winControl;
                appBar.hide();
                // show popup asking name to lookup
                addNewMoviePopup.style.opacity = 1;
                WinJS.UI.Animation.showPopup(addNewMoviePopup, null).done(function () {
                    addNewQuery.focus();
                    // Close button behaviour
                    element.querySelector(".close-popup").onclick = function () {
                        addNewMoviePopup.style.opacity = 0;
                        WinJS.UI.Animation.hidePopup(addNewMoviePopup);
                        $("#addNewResults").html("");
                    }
                    // button event listener to search for movie results
                    addNewSubmit.onclick = function () {
                        addMovieLookup(addNewQuery.value);
                    }
                });
            }

            $.ajaxSetup({ cache: false });
        },

        // This function updates the page layout in response to viewState changes.
        updateLayout: function (element, viewState, lastViewState) {
            /// <param name="element" domElement="true" />

            var listView = element.querySelector(".groupeditemslist").winControl;
            if (lastViewState !== viewState) {
                if (lastViewState === appViewState.snapped || viewState === appViewState.snapped) {
                    var handler = function (e) {
                        listView.removeEventListener("contentanimating", handler, false);
                        e.preventDefault();
                    }
                    listView.addEventListener("contentanimating", handler, false);
                    this._initializeLayout(listView, viewState);
                }
            }
        },

        // This function updates the ListView with new layouts
        _initializeLayout: function (listView, viewState) {
            /// <param name="listView" value="WinJS.UI.ListView.prototype" />

            if (viewState === appViewState.snapped) {
                listView.itemDataSource = CPData.groups.dataSource;
                listView.groupDataSource = null;
                listView.layout = new ui.ListLayout();
            } else {
                listView.itemDataSource = CPData.items.dataSource;
                listView.groupDataSource = CPData.groups.dataSource;
                listView.layout = new ui.GridLayout({ groupHeaderPosition: "top" });
            }
        },

        _itemInvoked: function (args) {
            if (appView.value === appViewState.snapped) {
                // If the page is snapped, the user invoked a group.
                var group = CPData.groups.getAt(args.detail.itemIndex);
                this.navigateToGroup(group.key);
            } else {
                // If the page is not snapped, the user invoked an item.
                var item = CPData.items.getAt(args.detail.itemIndex);
                nav.navigate("/pages/couchpotato/cpDetails/cpDetails.html", { item: CPData.getItemReference(item), type: "CPData" });
            }
        }
    });

    // Function for +Add Movie button
    // This show takes your search terms and passes them through
    // couchpotato's lookup API and returns a list of available options
    function addMovieLookup(query) {
        // empty existings results
        var resultsArea = $("#addNewResults");
        resultsArea.html("");
        // look up movie query
        var addMovieURL = "http://" + appData.values['cpIP'] + ":" + appData.values['cpPort'] + "/api/" + appData.values['cpAPI'] + "/movie.search/?q=" + query;
        // ideally we'd use $.getJSON here but IE is caching the results
        // caching the results is a good idea, but we are altering the results based on couchpotatos current state
        // if you add a movie to CP, then search for it again, it will pull in the cached results where it thinks the movie is not in your list
        // to combat this, we add the current time on to the URL
        //var nowTime = new Date().getTime();
        //var addMovieURL = addMovieURL + "&_=" + nowTime;
        $.getJSON(addMovieURL, function (data) {
            if (data.empty !== false) {
                resultsArea.html("<p class='nomovies'>No movies were found</p>");
            } else {
                $.each(data.movies, function (i, movie) {
                    // create variables for our data
                    var titles = movie.titles;
                    var year = movie.year;
                    var poster = movie.images.poster_original;
                    var plot = movie.plot;
                    var imdbid = movie.imdb;
                    var inwanted = movie.in_wanted;
                    var inlibrary = movie.in_library;

                    // fallback poster
                    if (poster == "" || poster == "0") {
                        poster = "/images/blank-couchpotato.png";
                    }

                    // create mark up for each result
                    var result = $("<div class='result' data-id='" + imdbid + "'></div>");
                    result.append("<img src='" + poster + "' alt='" + titles[0] + "' class='poster' />");
                    result.append("<div class='resultDetails'><h3>" + titles[0] + " (" + year + ") <span class='add'>&#xe109;</span></h3><p class='plot'>" + plot + "</p></div>");

                    // create more mark up for the 'add movie' reveal
                    var addInfo = $("<div class='addInfo' />");
                    addInfo.append("<h3>Add this movie to your wanted list</h3>");

                    // create a titles dropdown box
                    var titlesBox = $("<select class='titlesBox' />");
                    $.each(titles, function (k, title) {
                        titlesBox.append("<option value='" + title + "'>" + title + "</option>");
                    });
                    addInfo.append(titlesBox);

                    // look up quality options and add those in too
                    var profileBox = $("<select class='profileBox' />");
                    var profileURL = "http://" + appData.values['cpIP'] + ":" + appData.values['cpPort'] + "/api/" + appData.values['cpAPI'] + "/profile.list/";
                    $.getJSON(profileURL, function (profiles) {
                        $.each(profiles.list, function (j, profile) {
                            // Don't show hidden profiles
                            if (profile.hide == false) {
                                profileBox.append("<option value='" + profile.id + "'>" + profile.label + "</option>");
                            }
                        });
                    });
                    addInfo.append(profileBox);

                    // check if movie is already in wanted list
                    if (inwanted !== false) {
                        addInfo.append("<div class='already-in-wanted'>This movie is already in your wanted list: "+inwanted.profile.label+"</div>");
                    } else if (inlibrary !== false) {
                        addInfo.append("<div class='already-in-wanted'>This movie is already in your completed library: " + inlibrary.profile.label + "</div>");
                    }
                    // add a submit button
                    addInfo.append("<button class='submit-movie'>Add</button>");

                    // add a cancel button
                    addInfo.append("<button class='cancel-add'>Cancel</button>");

                    // add to result div
                    addInfo.appendTo(result);

                    // add a success div
                    result.append("<div class='success'>Movie successfully added to couchpotato!</div>");

                    // add an error div
                    result.append("<div class='error'>Something's gone horribly wrong!</div>");

                    // chuck in a clearfix for good measure
                    result.append("<div class='clear'></div>");

                    // populate results div with results
                    resultsArea.append(result);

                    // "add" button to show addInfo
                    result.find("span").click(function () {
                        result.find(".resultDetails").hide();
                        result.find(".addInfo").show();
                    });

                    // "add" button to send to couchpotato
                    result.find(".submit-movie").click(function () {
                        var qualityid = result.find(".profileBox").val();
                        var title = result.find(".titlesBox").val();
                        // call the function to add the movie to couchpotato
                        addMovieToLibrary(title, imdbid, qualityid);
                    });
                    // cancel button to show plot details again
                    result.find(".cancel-add").click(function () {
                        result.find(".addInfo").hide();
                        result.find(".resultDetails").show();
                    });

                });
            }
        });
    }

    // Function to add a movie from the lookup results to your library
    function addMovieToLibrary(title, imdbid, qualityid) {

        // disable add button for result
        var result = $(".result[data-id='" + imdbid + "']");
        result.find(".addInfo").hide();

        // send the data to couchpotato
        var addMovieURL = "http://" + appData.values['cpIP'] + ":" + appData.values['cpPort'] + "/api/" + appData.values['cpAPI'] + "/movie.add/?profile_id=" + qualityid + "&identifier=" + imdbid + "&title=" + title;
        $.getJSON(addMovieURL, function (addedData) {
            if (addedData.success == true) {
                // movie has successfully been added to couchpotato
                result.find(".success").show();
                // reload CPData and CPDataSoon
                // the movie can take a couple seconds to appear in CP, so I used a set timeout to increase
                // the likihood of the movie being ready for display
                setTimeout(function () {
                    if (typeof (CPData) != "undefined") { CPData.regenerate(); }
                    if (typeof (CPDataSoon) != "undefined") { CPDataSoon.regenerate(); }
                }, 2000);
            } else {
                // show error message
                result.find(".error").show();
            }
        });
    }



})();
