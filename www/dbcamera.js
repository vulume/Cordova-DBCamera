var exec = require('cordova/exec');

exports.coolMethod = function(arg0, success, error) {
    exec(success, error, "DBCamera", "coolMethod", [arg0]);
};

exports.sweetPhoto = function() {

    var suc = function(){ console.log('SUCCESS');};
    var err = function(){ console.log('ERROR');};
    var args = [0, 1, 2];
    console.log('got here');
    exec(suc, err, "DBCamera", "sweetPhoto", args);
};
