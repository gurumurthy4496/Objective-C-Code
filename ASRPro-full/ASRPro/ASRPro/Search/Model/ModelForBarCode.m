//
//  ModelForBarCode.m
//  ASRPro
//
//  Created by GuruMurthy on 04/09/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForBarCode.h"
#import "BarcodeViewController.h"

@implementation ModelForBarCode

//@synthesize enableAdd2Code;
//@synthesize enableAdd5Code;
//@synthesize enableAustralianPost4StateCode;
//@synthesize enableAztecCode;
//@synthesize enableBCDMatrixCode;
//@synthesize enableCodabarCode;
//@synthesize enableCode128Code;
//@synthesize enableCode32Code;
//@synthesize enableCode39Code;
//@synthesize enableCode39ExtendedCode;
//@synthesize enableCode93Code;
//@synthesize enableCode93ExtendedCode;
//@synthesize enableDataLogic2of5Code;
//@synthesize enableDataMatrixCode;
//@synthesize enableEAN128Code;
//@synthesize enableEAN13Code;
//@synthesize enableEAN8Code;
//@synthesize enableGS1DataBarCode;
//@synthesize enableIATA2of5Code;
//@synthesize enableIndustry2of5Code;
//@synthesize enableIntelligentMailCode;
//@synthesize enableInterleaved2of5Code;
//@synthesize enableInvertiert2of5Code;
//@synthesize enableMatrix2of5Code;
//@synthesize enablePDF417Code;
//@synthesize enablePatchCode;
//@synthesize enablePostNetCode;
//@synthesize enableQRCode;
//@synthesize enableRoyalPost4StateCode;
//@synthesize enableUPCACode;
//@synthesize enableUPCECode;

//Call this method in the application did finish launching
- (void)initWithData {
    /*
     * Set default values for each item in the Settings.
     * Default value for Settings is YES, unless changed by the user.
     */
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSDictionary *appDefault1 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableAdd2Code"];
//    [defaults registerDefaults:appDefault1];
//    NSDictionary *appDefault2 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableAdd5Code"];
//    [defaults registerDefaults:appDefault2];
//    NSDictionary *appDefault3 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableAustralianPost4StateCode"];
//    [defaults registerDefaults:appDefault3];
//    NSDictionary *appDefault4 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableAztecCode"];
//    [defaults registerDefaults:appDefault4];
//    NSDictionary *appDefault5 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableBCDMatrixCode"];
//    [defaults registerDefaults:appDefault5];
//    NSDictionary *appDefault6 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableCodabarCode"];
//    [defaults registerDefaults:appDefault6];
//    NSDictionary *appDefault7 = [NSDictionary dictionaryWithObject:@"YES" forKey:@"enableCode128Code"];
//    [defaults registerDefaults:appDefault7];
//    NSDictionary *appDefault8 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableCode32Code"];
//    [defaults registerDefaults:appDefault8];
//    NSDictionary *appDefault9 = [NSDictionary dictionaryWithObject:@"YES" forKey:@"enableCode39Code"];
//    [defaults registerDefaults:appDefault9];
//    NSDictionary *appDefault10 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableCode39ExtendedCode"];
//    [defaults registerDefaults:appDefault10];
//    NSDictionary *appDefault11 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableCode93Code"];
//    [defaults registerDefaults:appDefault11];
//    NSDictionary *appDefault12 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableCode93ExtendedCode"];
//    [defaults registerDefaults:appDefault12];
//    NSDictionary *appDefault13 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableDataLogic2of5Code"];
//    [defaults registerDefaults:appDefault13];
//    NSDictionary *appDefault14 = [NSDictionary dictionaryWithObject:@"YES" forKey:@"enableDataMatrixCode"];
//    [defaults registerDefaults:appDefault14];
//    NSDictionary *appDefault15 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableEAN128Code"];
//    [defaults registerDefaults:appDefault15];
//    NSDictionary *appDefault16 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableEAN13Code"];
//    [defaults registerDefaults:appDefault16];
//    NSDictionary *appDefault17 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableEAN8Code"];
//    [defaults registerDefaults:appDefault17];
//    NSDictionary *appDefault18 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableIATA2of5Code"];
//    [defaults registerDefaults:appDefault18];
//    NSDictionary *appDefault19 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableIndustry2of5Code"];
//    [defaults registerDefaults:appDefault19];
//    NSDictionary *appDefault20 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableIntelligentMailCode"];
//    [defaults registerDefaults:appDefault20];
//    NSDictionary *appDefault21 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableInterleaved2of5Code"];
//    [defaults registerDefaults:appDefault21];
//    NSDictionary *appDefault22 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableInvertiert2of5Code"];
//    [defaults registerDefaults:appDefault22];
//    NSDictionary *appDefault23 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableMatrix2of5Code"];
//    [defaults registerDefaults:appDefault23];
//    NSDictionary *appDefault24 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enablePDF417Code"];
//    [defaults registerDefaults:appDefault24];
//    NSDictionary *appDefault25 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enablePatchCode"];
//    [defaults registerDefaults:appDefault25];
//    NSDictionary *appDefault26 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enablePostNetCode"];
//    [defaults registerDefaults:appDefault26];
//    NSDictionary *appDefault27 = [NSDictionary dictionaryWithObject:@"YES" forKey:@"enableQRCode"];
//    [defaults registerDefaults:appDefault27];
//    NSDictionary *appDefault28 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableRoyalPost4StateCode"];
//    [defaults registerDefaults:appDefault28];
//    NSDictionary *appDefault29 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableUPCACode"];
//    [defaults registerDefaults:appDefault29];
//    NSDictionary *appDefault30 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableUPCECode"];
//    [defaults registerDefaults:appDefault30];
//    NSDictionary *appDefault31 = [NSDictionary dictionaryWithObject:@"NO" forKey:@"enableGS1DataBarCode"];
//    [defaults registerDefaults:appDefault31];
//    [defaults synchronize];
//    
//    // Get the current value for each item in the settings.
//    [self updateFromSettings];
}

/**
 * Update internal values from application Settings.
 */
-(void)updateFromSettings
{
    // Configure barcode types to decode, using the Settings.
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    enableAdd2Code = [defaults boolForKey:@"enableAdd2Code"];
//    enableAdd5Code = [defaults boolForKey:@"enableAdd5Code"];
//    enableAustralianPost4StateCode = [defaults boolForKey:@"enableAustralianPost4StateCode"];
//    enableAztecCode = [defaults boolForKey:@"enableAztecCode"];
//    enableBCDMatrixCode = [defaults boolForKey:@"enableBCDMatrixCode"];
//    enableCodabarCode = [defaults boolForKey:@"enableCodabarCode"];
//    enableCode128Code = [defaults boolForKey:@"enableCode128Code"];
//    enableCode32Code = [defaults boolForKey:@"enableCode32Code"];
//    enableCode39Code = [defaults boolForKey:@"enableCode39Code"];
//    enableCode39ExtendedCode = [defaults boolForKey:@"enableCode39ExtendedCode"];
//    enableCode93Code = [defaults boolForKey:@"enableCode93Code"];
//    enableCode93ExtendedCode = [defaults boolForKey:@"enableCode93ExtendedCode"];
//    enableDataLogic2of5Code = [defaults boolForKey:@"enableDataLogic2of5Code"];
//    enableDataMatrixCode = [defaults boolForKey:@"enableDataMatrixCode"];
//    enableEAN128Code = [defaults boolForKey:@"enableEAN128Code"];
//    enableEAN13Code = [defaults boolForKey:@"enableEAN13Code"];
//    enableEAN8Code = [defaults boolForKey:@"enableEAN8Code"];
//    enableGS1DataBarCode = [defaults boolForKey:@"enableGS1DataBarCode"];
//    enableIATA2of5Code = [defaults boolForKey:@"enableIATA2of5Code"];
//    enableIndustry2of5Code = [defaults boolForKey:@"enableIndustry2of5Code"];
//    enableIntelligentMailCode = [defaults boolForKey:@"enableIntelligentMailCode"];
//    enableInterleaved2of5Code = [defaults boolForKey:@"enableInterleaved2of5Code"];
//    enableInvertiert2of5Code = [defaults boolForKey:@"enableInvertiert2of5Code"];
//    enableMatrix2of5Code = [defaults boolForKey:@"enableMatrix2of5Code"];
//    enablePDF417Code = [defaults boolForKey:@"enablePDF417Code"];
//    enablePatchCode = [defaults boolForKey:@"enablePatchCode"];
//    enablePostNetCode = [defaults boolForKey:@"enablePostNetCode"];
//    enableQRCode = [defaults boolForKey:@"enableQRCode"];
//    enableRoyalPost4StateCode = [defaults boolForKey:@"enableRoyalPost4StateCode"];
//    enableUPCACode = [defaults boolForKey:@"enableUPCACode"];
//    enableUPCECode = [defaults boolForKey:@"enableUPCECode"];
}

/**
 * Restart any tasks that were paused (or not yet started) while the application was inactive.
 * - Obtain values for settings defined by the system-wide Settings app.
 * - Set the version information displayed by the Settings app with values defined by the
 * decoding library.
 * - Disable the display timeout.
 *
 * @param application This application's property object.
 */
- (void)applicationDidBecomeActive:(UIApplication *)application viewController :(UIViewController *)aViewController
{
    // Update internal values from Settings, since they may have changed.
//    BarcodeViewController *barcodeViewController = (BarcodeViewController*)aViewController;
//    [self updateFromSettings];
//    [barcodeViewController setBarcodeTypesUsingSettings];
//    
//    // Set the version number in the application Settings.
//    const char *libraryVersion = [barcodeViewController reportVersion];
//    NSString *lv = [NSString stringWithFormat:@"%s", libraryVersion];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:lv forKey:@"Version"];
//    [defaults synchronize];
//    
//    /*
//     * Keep the display on. Changing the setting to NO before YES is
//     * a workaround for a bug in iOS 3.x that can sometimes ignore
//     * a YES setting unless it is preceded by a NO setting.
//     */
//    [application setIdleTimerDisabled:NO];
//    [application setIdleTimerDisabled:YES];
    
}

@end
