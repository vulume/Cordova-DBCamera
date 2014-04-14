/********* CDVdbcamera.m Cordova Plugin Implementation *******/

#import <UIKit/UIKit.h>
#import "Cordova/CDV.h"
#import "DBCameraViewController.h"
#import "DBCameraContainer.h"


@interface CDVdbcamera : CDVPlugin <DBCameraViewControllerDelegate>{
  // Member variables go here.
}

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
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[DBCameraContainer alloc] initWithDelegate:self]];
    [nav setNavigationBarHidden:YES];
    [self.viewController presentViewController:nav animated:YES completion:nil];
}


- (void)openCameraWithoutContainer:(CDVInvokedUrlCommand*)command
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[DBCameraViewController initWithDelegate:self]];
    [nav setNavigationBarHidden:YES];
    [self.viewController presentViewController:nav animated:YES completion:nil];
}
