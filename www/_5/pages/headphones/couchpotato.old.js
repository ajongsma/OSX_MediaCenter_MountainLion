(function () {
    "use strict";

    var appView = Windows.UI.ViewManagement.ApplicationView;
    var appViewState = Windows.UI.ViewManagement.ApplicationViewState;
    var nav = WinJS.Navigation;
    var ui = WinJS.UI;

    ui.Pages.define("/pages/couchpotato/couchpotato.html", {
        // Navigates to the groupHeaderPage. Called from the groupHeaders,
        // keyboard shortcut and iteminvoked.
        navigateToGroup: function (key) {
            /*
            nav.navigate("/pages/groupDetail/groupDetail.html", { groupKey: key });
            */
        },

        // This function is called whenever a user navigates to this page. It
        // populates the page elements with the app's data.
        ready: function (element, options) {
            /*
            var cplistView = element.querySelector(".groupeditemslist").winControl;
            cplistView.groupHeaderTemplate = element.querySelector(".headertemplate");
            cplistView.itemTemplate = element.querySelector(".itemtemplate");

            // Set up a keyboard shortcut (ctrl + alt + g) to navigate to the
            // current group when not in snapped mode.
            cplistView.addEventListener("keydown", function (e) {
                if (appView.value !== appViewState.snapped && e.ctrlKey && e.keyCode === WinJS.Utilities.Key.g && e.altKey) {
                    var data = cplistView.itemDataSource.list.getAt(cplistView.currentItem.index);
                    this.navigateToGroup(data.group.key);
                    e.preventDefault();
                    e.stopImmediatePropagation();
                }
            }.bind(this), true);

            this._initializeLayout(cplistView, appView.value);
            cplistView.element.focus();

            getCPList();
            */
            var cplistView = new WinJS.UI.ListView(document.getElementById("ListView_CouchPotato"), {
                itemDataSource: itemDataSource,
                groupDataSource: groupDataSource,
                itemTemplate: element.querySelector(".itemtemplate"),
                groupHeaderTemplate: element.querySelector(".headertemplate"),
                layout: new WinJS.UI.GridLayout()
            });
        },

        // This function updates the page layout in response to viewState changes.
        updateLayout: function (element, viewState, lastViewState) {
            /// <param name="element" domElement="true" />

            var cplistView = element.querySelector(".groupeditemslist").winControl;
            if (lastViewState !== viewState) {
                if (lastViewState === appViewState.snapped || viewState === appViewState.snapped) {
                    var handler = function (e) {
                        cplistView.removeEventListener("contentanimating", handler, false);
                        e.preventDefault();
                    }
                    cplistView.addEventListener("contentanimating", handler, false);
                    this._initializeLayout(cplistView, viewState);
                }
            }
        },

        // This function updates the cplistView with new layouts
        _initializeLayout: function (cplistView, viewState) {
            /// <param name="cplistView" value="WinJS.UI.cplistView.prototype" />

            if (viewState === appViewState.snapped) {
                cplistView.itemDataSource = CPData.groups.dataSource;
                cplistView.groupDataSource = null;
                cplistView.layout = new ui.ListLayout();
            } else {
                cplistView.itemDataSource = CPData.items.dataSource;
                cplistView.groupDataSource = CPData.groups.dataSource;
                cplistView.layout = new ui.GridLayout({ groupHeaderPosition: "top" });
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
                var link = "/pages/" + item.template + "/" + item.template + ".html";
                nav.navigate(link, { item: CPData.getItemReference(item) });
            }
        }
    });
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

    var cpGroups = [
        { key: "0_recent", title: "Recently Downloaded", subtitle: "" },
        { key: "1_dvd", title: "Soon on DVD", subtitle: "Shows that are coming out on DVD" },
        { key: "2_theatre", title: "Soon at the Theatre", subtitle: "Shows that are coming out at the movies" },
    ];
    var cpRecentList = [
        { group: cpGroups[1], title: "test", subtitle: "Downloading" },
        { group: cpGroups[1], title: "test", subtitle: "Downloading" },
    ];
    var itemDataSource, groupDataSource;

    function initData() {
        // form an array of keys to help with the sort
        var groupKeys = [];
        for (var i = 0; i < cpGroups.length; i++) {
            groupKeys[i] = cpGroups[i].key;
        }

        // 
        var itemData = cpRecentList;
        itemData.sort(function CompareForSort(item1, item2) {
            var first = groupKeys.indexOf(item1.group), second = groupKeys.indexOf(item2.kind);
            if (first === second) { return 0; }
            else if (first < second) { return -1; }
            else { return 1; }
        });

        // Calculate the indexes of the first item for each group, ideally this should also be done at the source of the data
        var itemIndex = 0;
        for (var j = 0, len = cpGroups.length; j < len; j++) {
            cpGroups[j].firstItemIndex = itemIndex;
            var key = cpGroups[j].key;
            for (var k = itemIndex, len2 = itemData.length; k < len2; k++) {
                if (itemData[k].group !== key) {
                    itemIndex = k;
                    break;
                }
            }
        }
    }

    function getCPList() {
        WinJS.xhr({
            url: cp_list,
            headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
        }).done(function completed(response) {
            var json = JSON.parse(response.responseText);

            $.each(json.movies, function (i, movie) {
                var title = movie.library.info.titles[0];
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
                    var output = "{ group: cpGroups[1], title: " + title + ", image: " + poster + ", date: " + theatre + "}";
                    cpRecentList.push(output);
                }
                if (getdvd == "" || getdvd == "0") {
                    dvd = "unknown";
                } else {
                    // add dvd array
                    var output = "{ group: cpGroups[2], title: " + title + ", image: " + poster + ", date: " + theatre + "}";
                    cpRecentList.push(output);
                }
            });

        }, function (error) {
            // log errors
            console.log(error);
        });

    }
})();
