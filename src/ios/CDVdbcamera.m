/********* CDVdbcamera.m Cordova Plugin Implementation *******/

#import "Cordova/CDV.h"
#import "DBCameraViewController.h"
#import "DBCameraContainer.h"

//#import "CustomCamera.h"

#define CDV_DBCAMERA_PHOTO_PREFIX @"cdv_dbcamera_photo_"

@interface CDVdbcamera : CDVPlugin <DBCameraViewControllerDelegate>{}

@property (copy) NSString* callbackId;

- (void)openCamera:(CDVInvokedUrlCommand*)command;
//- (void)openCustomCamera:(CDVInvokedUrlCommand*)command;
- (void)openCameraWithoutSegue:(CDVInvokedUrlCommand*)command;
- (void)openCameraWithoutContainer:(CDVInvokedUrlCommand*)command;
- (void)cleanup:(CDVInvokedUrlCommand*)command;
@end

@implementation CDVdbcamera

- (void)openCamera:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[DBCameraContainer alloc] initWithDelegate:self]];
    [nav setNavigationBarHidden:YES];
    [self.viewController presentViewController:nav animated:YES completion:nil];
}

//- (void)openCustomCamera:(CDVInvokedUrlCommand*)command
//{
//    self.callbackId = command.callbackId;
//    CustomCamera *camera = [CustomCamera initWithFrame:[[UIScreen mainScreen] bounds]];
//    [camera buildInterface];
//
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[DBCameraViewController alloc] initWithDelegate:self cameraView:camera]];
//    [nav setNavigationBarHidden:YES];
//    [self.viewController presentViewController:nav animated:YES completion:nil];
//}

- (void)openCameraWithoutSegue:(CDVInvokedUrlCommand*)command
{
    self.callbackId = command.callbackId;
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setUseCameraSegue:NO];
    DBCameraContainer *container = [[DBCameraContainer alloc] initWithDelegate:self];
    [container setCameraViewController:cameraController];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
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

- (void)cleanup:(CDVInvokedUrlCommand*)command
{
    // empty the tmp directory
    NSFileManager* fileMgr = [[NSFileManager alloc] init];
    NSError* err = nil;
    BOOL hasErrors = NO;

    // clear contents of NSTemporaryDirectory
    NSString* tempDirectoryPath = NSTemporaryDirectory();
    NSDirectoryEnumerator* directoryEnumerator = [fileMgr enumeratorAtPath:tempDirectoryPath];
    NSString* fileName = nil;
    BOOL result;

    while ((fileName = [directoryEnumerator nextObject])) {
        // only delete the files we created
        if (![fileName hasPrefix:CDV_DBCAMERA_PHOTO_PREFIX]) {
            continue;
        }
        NSString* filePath = [tempDirectoryPath stringByAppendingPathComponent:fileName];
        result = [fileMgr removeItemAtPath:filePath error:&err];
        if (!result && err) {
            NSLog(@"Failed to delete: %@ (error: %@)", filePath, err);
            hasErrors = YES;
        }
    }

    CDVPluginResult* pluginResult;
    if (hasErrors) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_IO_EXCEPTION messageAsString:@"One or more files failed to be deleted."];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
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
        NSMutableDictionary* resultDictionary = [[NSMutableDictionary alloc] init];
        [resultDictionary setValue:[[NSURL fileURLWithPath:filePath] absoluteString] forKey:@"imageURL"];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDictionary];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackId];
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

 - (void) dismissCamera
 {
     [self.viewController dismissViewControllerAnimated:YES completion:nil];
 }

@end
