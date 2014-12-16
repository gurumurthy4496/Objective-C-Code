//
//  BarcodeViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 04/09/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//@class BXInterface;
//@class BXResult;

@interface BarcodeViewController : UIViewController

///** Preview Layer, where all camera images are displayed. */
//@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
///** Image from camera, optionally displays images before they are sent for decoding. */
//@property (nonatomic, strong) IBOutlet UIImageView *cameraImage;
///** Preview imagery from the camera. */
//@property (nonatomic, strong) UIView *cameraPreview;
///** Semi-opaque viewfinder overlay. */
//@property (nonatomic, strong) IBOutlet UIImageView *hashImage;
///** Laser-like line across center of the viewfinder. Blurred image detection happens across this line. */
//@property (nonatomic, strong) IBOutlet UIImageView *laserImage;
///** Image inside of which a barcode was decoded. Displayed with the barcode outlined. */
//@property (nonatomic, strong) IBOutlet UIImageView *thumbnailImage;
///** The value decoded from the barcode. */
//@property (nonatomic, strong) IBOutlet UITextView *resultText;
///** The "Processing.." text that moves once for each frame that is sent for decoding. */
//@property (nonatomic, strong) IBOutlet UILabel *processLabel;
///** Button that restarts scanning and closes the results Views. */
//@property (nonatomic, strong) IBOutlet UIButton *backButton;
///** Accusoft icon */
//@property (nonatomic, strong) IBOutlet UIButton *bxIcon;
///** Scrollview that contains thumbnailImage and resultText. */
//@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
///** Recognition Library */
//@property (nonatomic, strong) BXInterface *barcodeXpress;
//- (IBAction)cancelButtonAction:(id)sender;
//
///**
// * Utility routine that moves the laser animation in the viewfinder.
// */
//-(void)animateLaser;
//
///**
// * Draw the viewfinder overlay using a semi-transparent set of rectangles
// * around the perimeter of the display with a solid red "laser" line
// * through the center.  The "laser" line is where detection of a possibly
// * blurred image happens.
// */
//-(void)createBorder;
//
///**
// * Load and initialize the structures used for drawing the animated
// * laser in the viewfinder overlay.
// */
//-(void)createLaser;
//
///**
// * Copy a UIImage and draw a red border around the barcode region that
// * was identified by the recognition library.
// *
// * @param image UIImage that was sent to the recognition library for recognition.
// * @param result BXResult returned by the recognition library as a result
// * of processing the image. See BXResult.
// * @returns A new UIImage with a red border draw between the points defined
// * in the result.
// */
//-(UIImage *)drawBarcodeBorder :(UIImage *)image :(BXResult*)result;
//
///**
// * Called when the Back button is pressed, this will set the Running state
// * to YES (processing images) if it is not already set.  The Back button is
// * only visible while displaying recognition results.
// *
// * @param sender ID of the sending object. Unused.
// */
//-(IBAction)onClickBackButton:(id)sender;
//
///**
// * Action that is invoked when the Accusoft UITextView is touched.
// * The browswer is invoked to display Accusoft's website.
// *
// * @param sender ID of the sending object. Unused.
// */
//-(IBAction)onClickAccusoft:(id)sender;
//
///**
// * Query the Accusoft recognition library for its version information and return that.
// *
// * @returns a UTF8 character string containing the library version number.
// */
//-(const char *)reportVersion;
//
///**
// * Set the types of barcodes that will be recognized by the recognition library,
// * using the booleans set earlier by querying our application settings from the
// * system-wide Settings app.
// */
//-(void)setBarcodeTypesUsingSettings;
//
///**
// * Method to set the transform for the preview imagery.
// *
// * @param toInterfaceOrientation The new orientation.
// */
//- (void) setCameraPreviewTransform:(UIInterfaceOrientation)toInterfaceOrientation;
//
///**
// * Get the rotation necessary to rotate a video camera image
// * to appear right-side-up in the current UI orientation.
// */
//-(UIImageOrientation)getImageOrientationFromUIOrientation :(UIInterfaceOrientation) orientation;

@end
