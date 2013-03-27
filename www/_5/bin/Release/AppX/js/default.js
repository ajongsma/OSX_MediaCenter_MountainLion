// For an introduction to the Grid template, see the following documentation:
// http://go.microsoft.com/fwlink/?LinkID=232446
(function () {
    "use strict";

    WinJS.Binding.optimizeBindingReferences = true;

    var app = WinJS.Application;
    var activation = Windows.ApplicationModel.Activation;
    var nav = WinJS.Navigation;

    app.addEventListener("activated", function (args) {
        if (args.detail.kind === activation.ActivationKind.launch) {
            if (args.detail.previousExecutionState !== activation.ApplicationExecutionState.terminated) {
                // TODO: This application has been newly launched. Initialize
                // your application here.
            } else {
                // TODO: This application has been reactivated from suspension.
                // Restore application state here.
            }

            if (app.sessionState.history) {
                nav.history = app.sessionState.history;
            }
            args.setPromise(WinJS.UI.processAll().then(function () {
                if (nav.location) {
                    nav.history.current.initialPlaceholder = true;
                    return nav.navigate(nav.location, nav.state);
                } else {
                    return nav.navigate(Application.navigator.home);
                }
            }));
        }
    });

    app.oncheckpoint = function (args) {
        // TODO: This application is about to be suspended. Save any state
        // that needs to persist across suspensions here. If you need to 
        // complete an asynchronous operation before your application is 
        // suspended, call args.setPromise().
        app.sessionState.history = nav.history;
    };

    // Adding settings to our app
    /*
    WinJS.Application.onsettings = function (e) {
        e.detail.applicationcommands = { "services": { title: "Services", href: "/pages/settings/services.html" } };
        WinJS.UI.SettingsFlyout.populateSettings(e);
    };
    */
    //WinJS.Application.start();
    /*
    function initializeSettings() {
        WinJS.Application.onsettings = function (e) {
            e.detail.applicationcommands = {
                "services": {
                    title: "Services",
                    href: "/pages/settings/services.html"
                }
            };
            WinJS.UI.SettingsFlyout.populateSettings(e);
        };
        // Make sure the following is called after the DOM has initialized. 
        // Typically this would be part of app initialization
        WinJS.Application.start();
    }
    initializeSettings();
    */

    // Settings
    // http://volaresystems.com/Blog/post/2012/10/22/Showing-and-saving-user-settings-in-a-Windows-8-app-with-JavaScript.aspx
    app.onsettings = function (e) {
        e.detail.applicationcommands = {
            "services": { title: "Services", href: "/pages/settings/services.html" },
        };
        WinJS.UI.SettingsFlyout.populateSettings(e);
    }

    // Listening and Saving our Settings
    // https://blogs.msdn.com/b/eternalcoding/archive/2012/04/19/how-to-cook-a-complete-windows-8-application-with-html5-css3-and-javascript-in-a-week-day-1.aspx?Redirected=true
    /*
    var sabToggle = $("#sabToggle"),
        sabToggleStorage = Windows.Storage.ApplicationData.current.roamingSettings.values["sabToggle"],
        sabIP = $("#sabIP"),
        sabIPStorage = Windows.Storage.ApplicationData.current.roamingSettings.values["sabIP"],
        sabPort = $("#sabPort"),
        sabPortStorage = Windows.Storage.ApplicationData.current.roamingSettings.values["sabPort"],
        sabAPI = $("#sabAPI"),
        sabAPIStorage = Windows.Storage.ApplicationData.current.roamingSettings.values["sabAPI"]
    */

    /*
    if (sabToggleStorage == "true") { sabToggle.val("checked", "checked"); }
    sabToggle.change(function () {
        Windows.Storage.ApplicationData.current.roamingSettings.values["sabToggle"] = sabToggle.value;
        Windows.Storage.ApplicationData.current.signalDataChanged();
    });
    */
    /*
    if (sabIPStorage) {
        sabIP.val(sabIPStorage);
    }
    sabIP.change(function () {
        Windows.Storage.ApplicationData.current.roamingSettings.values["sabIP"] = sabIP.val();
        Windows.Storage.ApplicationData.current.signalDataChanged;
    });
    */

    app.start();
})();
