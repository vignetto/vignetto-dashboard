
showPkgTip = function(element){
    var tip = "#" + element;
    $(tip).css("opacity", 1);
}

hidePkgTip = function(element){
    var tip = "#" + element;
    $(tip).css("opacity", 0);
}

showPackage = function(id) {
    window.location = "/packages/" + id;
}

showEvent = function(id) {
    window.location = "/events/" + id;
}


