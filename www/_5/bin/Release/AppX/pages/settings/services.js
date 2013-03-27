//// THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
//// ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
//// THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
//// PARTICULAR PURPOSE.
////
//// Copyright (c) Microsoft Corporation. All rights reserved

(function () {
    "use strict";
    var appData = Windows.Storage.ApplicationData.current.roamingSettings;
    var page = WinJS.UI.Pages.define("/pages/settings/services.html", {

        ready: function (element, options) {

            // load our settings form elements in to variables
            var sabToggle = document.getElementById("sabToggle").winControl,
                sabSettings = $("#sabSettings"),
                sabIP = document.getElementById("sabIP"),
                sabPort = document.getElementById("sabPort"),
                sabAPI = document.getElementById("sabAPI"),
                // sickbeard
                sbToggle = document.getElementById("sbToggle").winControl,
                sbSettings = $("#sbSettings"),
                sbIP = document.getElementById("sbIP"),
                sbPort = document.getElementById("sbPort"),
                sbAPI = document.getElementById("sbAPI"),
                sbTvToday = document.getElementById("sbTvToday"),
                sbRecentShows = document.getElementById("sbRecentShows"),
                // couchpotato
                cpToggle = document.getElementById("cpToggle").winControl,
                cpSettings = $("#cpSettings"),
                cpIP = document.getElementById("cpIP"),
                cpPort = document.getElementById("cpPort"),
                cpAPI = document.getElementById("cpAPI"),
                cpPastTheatre = document.getElementById("cpPastTheatre").winControl,
                // headphones
                hpToggle = document.getElementById("hpToggle").winControl,
                hpSettings = $("#hpSettings"),
                hpIP = document.getElementById("hpIP"),
                hpPort = document.getElementById("hpPort"),
                hpAPI = document.getElementById("hpAPI"),
                // links
                linksPlaceholder = "";

            // set settings to existing values
            // first check if appdata has a size of more than 0 (implies we might already have settings available)
            if (appData.values.size > 0) {
                // sabnzbd
                if (appData.values["sabToggle"]) {
                    sabToggle.checked = appData.values["sabToggle"];
                    sabSettings.show();
                } else {
                    sabSettings.hide();
                }
                if (appData.values["sabIP"]) {
                    sabIP.value = appData.values["sabIP"];
                }
                if (appData.values["sabPort"]) {
                    sabPort.value = appData.values["sabPort"];
                }
                if (appData.values["sabAPI"]) {
                    sabAPI.value = appData.values["sabAPI"];
                }
                // sickbeard
                if (appData.values["sbToggle"]) {
                    sbToggle.checked = appData.values["sbToggle"];
                    sbSettings.show();
                } else {
                    sbSettings.hide();
                }
                if (appData.values["sbIP"]) {
                    sbIP.value = appData.values["sbIP"];
                }
                if (appData.values["sbPort"]) {
                    sbPort.value = appData.values["sbPort"];
                }
                if (appData.values["sbAPI"]) {
                    sbAPI.value = appData.values["sbAPI"];
                }
                if (appData.values["sbTvToday"]) {
                    sbTvToday.value = appData.values["sbTvToday"];
                }
                if (appData.values["sbRecentShows"]) {
                    sbRecentShows.value = appData.values["sbRecentShows"];
                }
                // couchpotato
                if (appData.values["cpToggle"]) {
                    cpToggle.checked = appData.values["cpToggle"];
                    cpSettings.show();
                } else {
                    cpSettings.hide();
                }
                if (appData.values["cpIP"]) {
                    cpIP.value = appData.values["cpIP"];
                }
                if (appData.values["cpPort"]) {
                    cpPort.value = appData.values["cpPort"];
                }
                if (appData.values["cpAPI"]) {
                    cpAPI.value = appData.values["cpAPI"];
                }
                if (appData.values["cpPastTheatre"]) {
                    cpPastTheatre.checked = appData.values["cpPastTheatre"];
                }
                // headphones
                if (appData.values["hpToggle"]) {
                    hpToggle.checked = appData.values["hpToggle"];
                    hpSettings.show();
                } else {
                    hpSettings.hide();
                }
                if (appData.values["hpIP"]) {
                    hpIP.value = appData.values["hpIP"];
                }
                if (appData.values["hpPort"]) {
                    hpPort.value = appData.values["hpPort"];
                }
                if (appData.values["hpAPI"]) {
                    hpAPI.value = appData.values["hpAPI"];
                }
                // links
                
            }

            // Wire up on change events for settings controls
            // sabnzbd
            sabToggle.onchange = function () {
                appData.values["sabToggle"] = sabToggle.checked;
                if (sabToggle.checked == true) {
                    sabSettings.show();
                } else {
                    sabSettings.hide();
                }
            };
            sabIP.onchange = function () {
                appData.values["sabIP"] = sabIP.value;
            };
            sabPort.onchange = function () {
                appData.values["sabPort"] = sabPort.value;
            };
            sabAPI.onchange = function () {
                appData.values["sabAPI"] = sabAPI.value;
            };
            // sickbeard
            sbToggle.onchange = function () {
                appData.values["sbToggle"] = sbToggle.checked;
                if (sbToggle.checked == true) {
                    sbSettings.show();
                } else {
                    sbSettings.hide();
                }
            };
            sbIP.onchange = function () {
                appData.values["sbIP"] = sbIP.value;
            };
            sbPort.onchange = function () {
                appData.values["sbPort"] = sbPort.value;
            };
            sbAPI.onchange = function () {
                appData.values["sbAPI"] = sbAPI.value;
            };
            //sbTvToday.onchange = function () {
            //    appData.values["sbTvToday"] = sbTvToday.value;
            //};
            sbRecentShows.onchange = function () {
                appData.values["sbRecentShows"] = sbRecentShows.value;
            };
            // couchpotato
            cpToggle.onchange = function () {
                appData.values["cpToggle"] = cpToggle.checked;
                if (cpToggle.checked == true) {
                    cpSettings.show();
                } else {
                    cpSettings.hide();
                }
            };
            cpIP.onchange = function () {
                appData.values["cpIP"] = cpIP.value;
            };
            cpPort.onchange = function () {
                appData.values["cpPort"] = cpPort.value;
            };
            cpAPI.onchange = function () {
                appData.values["cpAPI"] = cpAPI.value;
            };
            cpPastTheatre.onchange = function () {
                appData.values["cpPastTheatre"] = cpPastTheatre.checked;
            };
            // headphones
            hpToggle.onchange = function () {
                appData.values["hpToggle"] = hpToggle.checked;
                if (hpToggle.checked == true) {
                    hpSettings.show();
                } else {
                    hpSettings.hide();
                }
            };
            hpIP.onchange = function () {
                appData.values["hpIP"] = hpIP.value;
            };
            hpPort.onchange = function () {
                appData.values["hpPort"] = hpPort.value;
            };
            hpAPI.onchange = function () {
                appData.values["hpAPI"] = hpAPI.value;
            };
            // links
        },

        unload: function () {
            //
        },
    });

})();

