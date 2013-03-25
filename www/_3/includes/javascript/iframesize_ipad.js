/*
The function below allows the current iFrame to dynamically resize
based on the browser window by taking the current width and height
of the "WorkArea" and subtracting the width of the Left Menu and
height of the Top Navigation.
 */
$(function(){
    $("iframe#ifrm").width($(document).width() - 115);
    $(window).resize(function(){
        $("iframe#ifrm").width($(document).width() - 115);
    });
    $("iframe#ifrm").height($(document).height() - 33);
    $(window).resize(function(){
        $("iframe#ifrm").height($(document).height() - 33);
    });
});