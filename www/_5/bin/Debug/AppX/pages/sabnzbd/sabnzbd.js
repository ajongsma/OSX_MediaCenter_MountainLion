(function () {
    "use strict";

    var appData = Windows.Storage.ApplicationData.current.roamingSettings;
    WinJS.UI.Pages.define("/pages/sabnzbd/sabnzbd.html", {
        // This function is called whenever a user navigates to this page. It
        // populates the page elements with the app's data.
        ready: function (element, options) {

            var launchURL = "http://" + appData.values['sabIP'] + ":" + appData.values['sabPort'];
            $(".titlearea button").attr("onclick", "location.href='" + launchURL + "'");

            /* ===============================================
                SABNZBD DOWNLOAD STATUS
            =============================================== */

            // Download Pane Target
            var downloadPane = $("#sabDownloading");

            function getSabStatus() {

                var statusurl = "http://" + appData.values['sabIP'] + ":" + appData.values['sabPort'] + "/sabnzbd/api?mode=qstatus&output=json&apikey="+ appData.values['sabAPI'];

                // Load sab status via JSON/AJAX
                WinJS.xhr({
                    url: statusurl,
                    headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
                }).done(function completed(response) {
                    var json = JSON.parse(response.responseText);
                    // Status of application
                    var sab_paused = json.paused;
                    var sab_speed = json.speed;

                    // Check if a file is downloading
                    if (json.jobs.length > 0) {

                        // Filename of current job
                        var sab_file_name = json.jobs[0].filename;

                        // File sizes
                        var sab_file_size = json.jobs[0].mb;
                        var sab_file_left = json.jobs[0].mbleft;
                        var sab_file_done = parseInt(sab_file_size) - parseInt(sab_file_left);

                        var mb_full_noround = sab_file_size.toString().split(".")[0];
                        var mb_percent = sab_file_done / mb_full_noround * 100;
                        var mb_percent_pretty = mb_percent.toString().split(".")[0];

                        var output = "<span class='currentdl'>";
                        if (sab_paused == true) {
                            output += "<em class='p'>PAUSED: </em>";
                        }
                        output += sab_file_name + "</span>";
                        output += "<progress value='" + sab_file_done + "' max='" + sab_file_size + "'></progress>";
                        output += "<span class='stats'>" + sab_file_done + "mb / " + mb_full_noround + "mb (" + mb_percent_pretty + "%) @ " + sab_speed + "</span>";

                        $("#sabDownloading").html(output);

                        // If a file isn't downloading?
                    } else {

                        var output = "<em class='nodownloads'>No current downloads</em>";
                        $("#sabDownloading").html(output);

                    }

                    // Keep refreshing this ajax call
                    setTimeout(getSabStatus, 1000);

                }, function (error) {
                    // log errors
                    var message = "There appears to be an error with your SABnzbd configuration. Please check all fields are correct in your settings.";
                    var msg = new Windows.UI.Popups.MessageDialog(message, "Error");
                    msg.commands.append(new Windows.UI.Popups.UICommand("Show Settings", showSettings));
                    msg.commands.append(new Windows.UI.Popups.UICommand("Close", closePopup));
                    msg.defaultCommandIndex = 0;
                    msg.cancelCommandIndex = 1;
                    msg.showAsync();

                    function showSettings() {
                        WinJS.UI.SettingsFlyout.showSettings("services", "/pages/settings/services.html");
                    }
                    function closePopup() {
                        // hide dialog
                    }
                });

            };

            // First run on page load
            getSabStatus();

            /* ===============================================
                SABNZBD DOWNLOAD HISTORY
            =============================================== */

            function getSabHistory() {

                var historyurl = "http://" + appData.values['sabIP'] + ":" + appData.values['sabPort'] + "/sabnzbd/api?mode=history&output=json&limit=15&apikey=" + appData.values['sabAPI'];

                // Load sab status via JSON/AJAX
                WinJS.xhr({
                    url: historyurl,
                    headers: { "Cache-Control": "no-cache", "If-Modified-Since": "Mon, 27 Mar 1972 00:00:00 GMT" }
                }).done(function completed(response) {
                    var json = JSON.parse(response.responseText);
                    // some stats
                    var downloads_thismonth = json.history.month_size;
                    var downloads_total = json.history.total_size;
                    var output_list = $("#sabHistory ul");
                    // empty any existing list items
                    output_list.html("");

                    // cycle through each "slot" (download) and add the pertenant details to our variables
                    $.each(json.history.slots, function (i, slot) {
                        var category = slot.category;
                        var name = slot.name;
                        var size = slot.size;
                        if (category == "*") {
                            category = "other";
                        }
                        output_list.append("<li>[" + category + "] " + name + " (" + size + ")</li>");
                    });

                    // Add our completed variable to the page
                    //$("#sabHistory").html(output);

                }, function (error) {
                    // log errors
                    // console.log(error);
                });

                // Keep refreshing this ajax call
                setTimeout(getSabHistory, 1000);

            }

            // first run on page load
            getSabHistory();

        }
    });
})();