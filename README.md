Cordova-DBCamera
================

Plugman compatible wrapper for DBCamera (currently at 2.0)
https://github.com/danielebogo/DBCamera

Install Instructions
---------------------

 * Install this plugin using plugman / cordova / phonegap `cordova plugin add com.vulume.cordova.dbcamera`

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

Updating
---------
This project uses https://github.com/mkcode/cocoapod-to-cordova to manage updating. See that projects README for instructions to update to a new version of DBCamera.

MIT Licensed
