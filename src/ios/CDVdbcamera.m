/********* CDVdbcamera.m Cordova Plugin Implementation *******/

#import <UIKit/UIKit.h>
#import "Cordova/CDV.h"
#import "DBCameraViewController.h"
#import "DBCameraContainer.h"

#define CDV_DBCAMERA_PHOTO_PREFIX @"cdv_dbcamera_photo_"

@interface CDVdbcamera : CDVPlugin <DBCameraViewControllerDelegate>{
  // Member variables go here.
}

@property (copy) NSString* callbackId;

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)openCamera:(CDVInvokedUrlCommand*)command;
- (void)openCameraWithoutContainer:(CDVInvokedUrlCommand*)command;
@end

@implementation CDVdbcamera

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void)openCamera:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[DBCameraContainer alloc] initWithDelegate:self]];
    [nav setNavigationBarHidden:YES];
    [self.viewController presentViewController:nav animated:YES completion:nil];
}


- (void)openCameraWithoutContainer:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[DBCameraViewController initWithDelegate:self]];
    [nav setNavigationBarHidden:YES];
    [self.viewController presentViewController:nav animated:YES completion:nil];
}



#pragma mark - DBCameraViewControllerDelegate

- (void) captureImageDidFinish:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    NSData* data = UIImageJPEGRepresentation(image, 1.0);
    NSString* docsPath = [NSTemporaryDirectory()stringByStandardizingPath];
    NSError* err = nil;
    NSFileManager* fileMgr = [[NSFileManager alloc] init];
    NSString* filePath;

    int i = 1;
    do {
        filePath = [NSString stringWithFormat:@"%@/%@%03d.%@", docsPath, CDV_DBCAMERA_PHOTO_PREFIX, i++, @"jpg"];
    } while ([fileMgr fileExistsAtPath:filePath]);

    CDVPluginResult* pluginResult = nil;
    if (![data writeToFile:filePath options:NSAtomicWrite error:&err]) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_IO_EXCEPTION messageAsString:[err localizedDescription]];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[[NSURL fileURLWithPath:filePath] absoluteString]];
    }


//    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:metadata];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];

    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

 - (void) dismissCamera
 {
     [self.viewController dismissViewControllerAnimated:YES completion:nil];
 }

@end
