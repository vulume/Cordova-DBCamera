Cordova-DBCamera
================

Plugman compatible wrapper for DBCamera (currently at 2.0)
https://github.com/danielebogo/DBCamera

Install Instructions
---------------------

 * Install this plugin using this git repo url `cordova plugin add ...`

Usage
-------

 The following methods are implemented (See https://github.com/danielebogo/DBCamera for more)

 * Open camera - `cordova.plugins.dbcamera.openCamera(success, error)`
 * Open camera with settings - `cordova.plugins.dbcamera.openCameraWithSettings(success, error)`
 * Open camera without segue - `cordova.plugins.dbcamera.openCameraWithoutSegue(success, error)`
 * Open camera without container - `cordova.plugins.dbcamera.openCameraWithoutContainer(success, error)`


All methods return a JSON object with the created / selected image URL and exif data. The image URL is a local image file so it is ready to be used in the DOM.

Example
------------

```js
var success = function(dbCameraResults){
  $('#my-image-id').attr('src', dbCameraResults.imageURL);
};
cordova.plugins.dbcamera.openCamera(success);
```

There is a template for the openCameraWithSettings and openCustomCamera methods that are ready to be forked and customized.

MIT Licensed
