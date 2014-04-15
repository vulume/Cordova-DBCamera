Cordova-DBCamera
================

Plugman compatible wrapper for DBCamera (currently at tags/1.2)
https://github.com/danielebogo/DBCamera

Install Instructions
---------------------

 * Install this plugin using this git repo url `cordova plugin add ...`
 * In XCode - Under Build Settings - Set 'C Language Dialect' to '-std=gnu99'
 * Build / Run and follow the usage instructions

Usage
-------

 The following methods are implemented (See https://github.com/danielebogo/DBCamera for more)
  
 * Open camera - `cordova.plugins.dbcamera.openCamera(success, error)`
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

There is a template for the openCustomCamera method that is ready to be forked and customized.

MIT Licensed 

 

