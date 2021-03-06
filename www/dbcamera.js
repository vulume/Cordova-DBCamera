var exec = require('cordova/exec');

_logMessage = function(message){
  return console.log(message);
};

exports.openCamera = function(success, error) {
    success = success || _logMessage;
    error = error || _logMessage;
    exec(success, error, "DBCamera", "openCamera", []);
};

exports.openCameraWithSettings = function(success, error) {
    success = success || _logMessage;
    error = error || _logMessage;
    exec(success, error, "DBCamera", "openCameraWithSettings", []);
};

exports.openCustomCamera = function(success, error) {
    // success = success || _logMessage;
    // error = error || _logMessage;
    // exec(success, error, "DBCamera", "openCustomCamera", []);
    return console.log("You have not implemented a custom camera.");
};

exports.openCameraWithoutSegue = function(success, error) {
    success = success || _logMessage;
    error = error || _logMessage;
    exec(success, error, "DBCamera", "openCameraWithoutSegue", []);
};

exports.openCameraWithoutContainer = function(success, error) {
    success = success || _logMessage;
    error = error || _logMessage;
    exec(success, error, "DBCamera", "openCameraWithoutContainer", []);
};

exports.cleanup = function(success, error) {
    success = success || _logMessage;
    error = error || _logMessage;
    exec(success, error, "DBCamera", "cleanup", []);
};
