//
//  BarcodeViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 04/09/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "BarcodeViewController.h"
/*#import "BarcodeXpressIOS.h"
#import "BXLicense.h"
#import "BXAuxFunctions.h"
#import "BXThreadData.h"*/

@interface BarcodeViewController () {
//    AppDelegate *appDelegate;
}

@end
//BOOL saveImage = NO;

@implementation BarcodeViewController
//@synthesize previewLayer;
//@synthesize cameraImage;
//@synthesize cameraPreview;
//@synthesize hashImage;
//@synthesize laserImage;
//@synthesize resultText;
//@synthesize processLabel;
//@synthesize backButton;
//@synthesize bxIcon;
//@synthesize thumbnailImage;
//@synthesize scrollView;
//@synthesize barcodeXpress;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self initDataForBarCode];
//}

//-(void)initDataForBarCode {
//    // Do any additional setup after loading the view from its nib.
//    appDelegate = [[SharedUtilities sharedUtilities] appDelegateInstance];
//    // Create the viewfinder overlay.
//    [self createBorder];
//    
//    // Create the laser animation.
//    [self createLaser];
//    
//    // Create and initialize a BXLicense.
//    BXLicense* license = [[BXLicense alloc]
//                          initWithData:
//                          @"2cy5BNjNDf4BHizpUQK8TA7IgzbWYnvialLGV0jhu/YFY1jgi3kPI5mM5UYmhyfa\n"
//                          "n8zEMAdBjR47OJxcZsC0Dggq+qcw8xWV+EcDYcYfqsGX1qDy9xEZUVPdkDKJCNBN\n"
//                          "YEA/mgwgTGFTIOHSvthR/qRFZh4rflJ0YWxOgFXRgnU=\n"
//                          
//                          mainBundle:[NSBundle mainBundle]
//                          key1:1 key2:2 key3:3 key4:4 ];
//    
//    // Initialize the interface to the decoding library.
//    barcodeXpress = [[BXInterface alloc] initWithLicense:license];
//    
//    // Set the types of barcodes to be decoded.
//    [self setBarcodeTypesUsingSettings];
//    
//    // Define the callbacks that allow program control to be altered at key points.
//    [barcodeXpress SetCameraCallback :self :@selector(onCameraUpdate:)];
//    [barcodeXpress SetRecognitionCallback :self :@selector(onBarcodeRecognition:)];
//    [barcodeXpress SetProcessingCallback :self :@selector(onProcessingBarcode:)];
//    
//    // Configure the camera and start processing video frames.
//    [barcodeXpress StartRecognition];
//    
//    // Create a layer that will display preview imagery from the camera.
//    // Note that the call to GetCaptureSession will return nil until after
//    // StartRecognition is called.
//    AVCaptureSession* captureSession = [barcodeXpress GetCaptureSession];
//    previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
//    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//    previewLayer.frame = [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0?CGRectMake(0, 0, 768, 1024):[[UIScreen mainScreen] bounds];
//    // Create a view into which the video preview layer will be placed.
//    // Using this view instead of placing the layer directly into the root
//    // view will allow for a smooth rotation animation.
//    cameraPreview = [[UIView alloc] init];
//    [cameraPreview.layer addSublayer:previewLayer];
//    
//    // Place the preview imagery at the bottom of the view stack.
//    [self.view insertSubview:cameraPreview atIndex:0];
//    [self.view setBackgroundColor:[UIColor redColor]];
//    [self.cameraPreview setBackgroundColor:[UIColor yellowColor]];
//    [self.previewLayer setBackgroundColor:[UIColor whiteColor].CGColor];
//}
//- (void)viewWillAppear:(BOOL)animated {
//    // Define the callbacks that allow program control to be altered at key points.
//    [barcodeXpress SetCameraCallback :self :@selector(onCameraUpdate:)];
//    [barcodeXpress SetRecognitionCallback :self :@selector(onBarcodeRecognition:)];
//    [barcodeXpress SetProcessingCallback :self :@selector(onProcessingBarcode:)];
//
//}

/**
 * Set the rotation transformation for the camera preview,
 * now that the orientation can be obtained from the UI.
 */
//-(void)viewDidAppear:(BOOL)animated {
//    
//    /*[self setCameraPreviewTransform:[[UIApplication sharedApplication] statusBarOrientation]];*/
//    
//    [super viewDidAppear:animated];
//}

/*
 * Called when the view is unloaded.  Perform cleanup, release memory, etc.
 */
//- (void)viewDidUnload {
//    [self setCameraImage:nil];
//    [self setCameraPreview:nil];
//    [self setHashImage:nil];
//    [self setResultText:nil];
//    [self setProcessLabel:nil];
//    [self setLaserImage:nil];
//    [self setBackButton:nil];
//    [self setBxIcon:nil];
//    [self setScrollView:nil];
//    [self setThumbnailImage:nil];
//    [self setPreviewLayer:nil];
//    [self setBackButton:nil];
//    [self setBarcodeXpress:nil];
//    
//    [super viewDidUnload];
//    
//    return;
//}

/*
 * Define whether the UI should autorotate.
 * Used for iOS 6.0 or later.
 */
//- (BOOL)shouldAutorotate {
//    return YES;
//}

/*
 * Returns a mask containing the set of desired
 * UI orientations. Used for iOS 6.0 or later.
 */
//- (NSUInteger)supportedInterfaceOrientations {
//    /*[self setCameraPreviewTransform :[[UIApplication sharedApplication] statusBarOrientation]];*/
//    return UIInterfaceOrientationMaskLandscape;
//}


/**
 * Method to set the transform for the preview imagery.
 *
 * @param toInterfaceOrientation The new orientation.
 */
//- (void) setCameraPreviewTransform:(UIInterfaceOrientation)toInterfaceOrientation {
//        if (cameraPreview) {
//            switch(toInterfaceOrientation) {
//                case UIInterfaceOrientationPortrait:
//                    cameraPreview.transform = CGAffineTransformMakeRotation(0);
//                    break;
//                case UIInterfaceOrientationLandscapeLeft:
//                    cameraPreview.transform = CGAffineTransformMakeRotation(M_PI/2);
//                    break;
//                case UIInterfaceOrientationLandscapeRight:
//                    cameraPreview.transform = CGAffineTransformMakeRotation(-M_PI/2);
//                    break;
//                case UIInterfaceOrientationPortraitUpsideDown:
//                    cameraPreview.transform = CGAffineTransformMakeRotation(M_PI);
//                    break;
//                default: ;
//            }
//            cameraPreview.frame = CGRectMake(0, 0, 1024, 768);
////            NSLog(@"previewLayer :%@",NSStringFromCGRect(previewLayer.frame));
//        }
//    
///*#define CAMERA_TRANSFORM                    2.12412
//        
//        self.wantsFullScreenLayout = YES;
//        self.cameraPreview.transform = CGAffineTransformScale(self.cameraPreview.transform, CAMERA_TRANSFORM, CAMERA_TRANSFORM);*/
//    
//}

/**
 * Method to provide a smooth rotation transition for the preview imagery.
 *
 * @param interfaceOrientation The new orientation.
 */
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    
//    [self setCameraPreviewTransform :toInterfaceOrientation];
//}

/**
 * Get the rotation necessary to rotate a video camera image
 * to appear right-side-up in the current UI orientation.
 */
//-(UIImageOrientation)getImageOrientationFromUIOrientation :(UIInterfaceOrientation) orientation {
//    switch(orientation) {
//        case UIInterfaceOrientationPortrait:
//            return UIImageOrientationRight;
//        case UIInterfaceOrientationPortraitUpsideDown:
//            return UIImageOrientationLeft;
//        case UIInterfaceOrientationLandscapeRight:
//            return UIImageOrientationUp;
//        case UIInterfaceOrientationLandscapeLeft:
//            return UIImageOrientationDown;
//        default:
//            return UIImageOrientationUp;
//    }
//}

/* Called before the parent view will layout subviews.
 */
//- (void)viewWillLayoutSubviews {
//    
//    // Size the results UIScrollView to hold both the image and the results.
////    self.view.superview.bounds = CGRectMake(0, 0, 480, 320);
//    CGSize size = self.scrollView.contentSize;
//    size.height = self.resultText.frame.size.height +
//    self.thumbnailImage.frame.size.height + 100;
//    self.scrollView.contentSize = size;
//}

/**
 * Manage the application running state. Toggle visibility of Views that display
 * recognition results.
 *
 * @param state A boolean that denotes if we want to enter the Running state or not.
 * - YES if we are going to start or re-start recognizing images from the camera.
 * - NO if we are displaying results.
 */
//- (void)setRunningState :(BOOL)state {
//    if(state == YES) {
//        self.cameraImage.image = nil;
//        self.backButton.hidden = YES;
//        self.resultText.text = @"";
//        self.processLabel.text = @"Initializing Camera...";
//        self.hashImage.backgroundColor = [UIColor clearColor];
//        self.cameraImage.backgroundColor = [UIColor clearColor];
//        self.bxIcon.hidden = YES;
//        self.scrollView.hidden = YES;
//        [self createBorder];
//        [self.barcodeXpress ResumeRecognition];
//    } else {
//        [self.barcodeXpress PauseRecognition];
//        self.processLabel.text = @"";
//        self.hashImage.backgroundColor = [UIColor blackColor];
//        self.cameraImage.backgroundColor = [UIColor blackColor];
//        self.hashImage.image = nil;
//        self.backButton.hidden = NO;
//        self.bxIcon.hidden = NO;
//        self.scrollView.hidden = NO;
//    }
//    
//    return;
//}

/**
 * Report application running state.
 *
 * @returns YES if imagery is being processed or NO if recognition results are
 * being displayed.  Determines the state by checking the visibility of the
 * Back button.
 */
//- (BOOL)isRunning {
//    
//    return self.backButton.hidden;
//}

/**
 * Callback that is executed when a new image is captured from the video camera.
 * This is executed in parallel with dispatching the image for recognition.
 * Un-commenting some code here will threshold and display each image
 * on top of the preview layer, displaying an image like the one
 * that is ultimately used for barcode detection.
 *
 * @param data Image information including width, height, etc that is being
 * sent for decoding. YUV420p format. See BXThreadData.
 */
//- (void)onCameraUpdate :(BXThreadData*)data {
//    if([self isRunning] == NO) return;
//    
//    /*
//     * Uncomment this section to see what the binarized image looks like.
//     */
//#if 0
//    self.cameraImage.image = [BXAuxFunctions binarizeGrayscaleImage:(uint8_t*)data.m_image
//                                                              width:data.m_width
//                                                             height:data.m_height];
//    self.cameraImage.backgroundColor = [UIColor blackColor];
//    self.cameraImage.hidden = NO;
//#endif
//    
//    /*
//     * Uncomment this section to see what the grayscale image looks like.
//     */
//#if 0
//    uint8_t *imgData = (uint8_t *) malloc(data.m_width * data.m_height);
//    memcpy(imgData, data.m_image, (data.m_width * data.m_height));
//    
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
//    CGContextRef cgctx = CGBitmapContextCreate(imgData, data.m_width, data.m_height, 8, data.m_width, colorSpace, kCGImageAlphaNone);
//    CGColorSpaceRelease( colorSpace );
//    
//    CGImageRef imgRef = CGBitmapContextCreateImage(cgctx);
//    CGContextRelease(cgctx);
//    free(imgData);
//    
//    UIImage *retImage = [UIImage imageWithCGImage:imgRef];
//    CGImageRelease(imgRef);
//    
//    self.cameraImage.image = retImage;
//    self.cameraImage.backgroundColor = [UIColor blackColor];
//    self.cameraImage.hidden = NO;
//    
//    /*
//     * This code will overwrite the Test.png file in the sandbox
//     * Documents directory with the current grayscale image
//     * that is being sent for recognition.  To enable this behavior,
//     * the boolean saveImage must have a value of YES.  Its value will
//     * be set to NO before saving the grayscale image, so that just one
//     * image will be saved each time the boolean is set to YES.  A
//     * convenient place to set the boolean to YES would be in the method
//     * onClickAccusoft(), re-purposing it.
//     */
//    if (YES == saveImage) {
//        saveImage = NO;
//        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                             NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString* path = [documentsDirectory stringByAppendingPathComponent:@"Test.png" ];
//        
//        [UIImagePNGRepresentation(retImage) writeToFile:path atomically:YES];
//    }
//#endif
//    
//    return;
////}

/**
 * Callback that performs actions with the results of barcode detection.
 * This method is called when a barcode is detected by the recognition
 * library, or when the detection method reports an error.
 *
 * @param data NSDictionary with two keys:
 * - "image" is a UIImage that contains the image upon which decoding was performed.
 * - "results" is a BXResult that contains decoding results and status information.  See BXResult.
 */
//- (void)onBarcodeRecognition :(NSDictionary*)data {
//    // If we are already displaying results, throw these away.
//    if([self isRunning] == NO) return;
//    [self setRunningState :NO];
//    
//    // The YUV420p format image that was sent in to be decoded, converted to RGBA format and placed into a UIImage.
//    UIImage *resultImage = [data objectForKey:@"image"];
//    
//    // Status. If recognition was successful, also contains the type of barcode and its decoded value.  See BXResult.
//    BXResult *bxr = [data objectForKey:@"result"];
//    
//    
//    NSString *str = [[NSString alloc] initWithData:bxr.m_valueData encoding:NSUTF8StringEncoding];
////    NSLog(@"%@",str);
//    
//    // Get a character string from the barcode type.
//    const char *barcodeTypeName = [BXInterface BarcodeTypeToString:(enum BarcodeTypes)[bxr.m_type longValue]];
//    
//    /* If the decoding library was compiled in debug mode, display timing information.
//     * The times are zero for non-debug builds of the library, so don't display them.
//     */
//    long decodingTime = [bxr.m_decodingTime longValue];
//    if (decodingTime > 0) {
//        self.resultText.text = [NSString
//                                stringWithFormat:@"Type: %s\nDecoding Time (ms): %ld\nBinarization Time (ms): %@\nImage Frames Processed: %ld\nData: %@",
//                                barcodeTypeName, decodingTime, bxr.m_binarizationTime, [barcodeXpress GetNumProcessedFrames], bxr.m_value];
//        [barcodeXpress ClearNumProcessedFrames];
//    } else {
//        self.resultText.text = [NSString stringWithFormat:@"Type: %s\nValue: %@",
//                                barcodeTypeName, bxr.m_value];
//    }
//    // set the VIN number to textfield..
//    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mBeginVehicleCheckInView_] getVinNumberFromBarCode:bxr.m_value barCodeViewController:self];
//    // Size the results value UITextView for this result.
//    CGRect frame = self.resultText.frame;
//    frame.size.height = self.resultText.contentSize.height;
//    self.resultText.frame = frame;
//    
//    // Draw a border around the region in the image where a barcode was detected.
//    UIImage *imageWithBorder = [self drawBarcodeBorder :resultImage :bxr];
//    resultImage = nil;
//    
//    // Rotate the image to match the current display orientation,
//    // since the camera orientation is fixed.
//    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//    if (orientation == UIInterfaceOrientationLandscapeRight) {
//        // No need to rotate the image.
//        self.thumbnailImage.image = imageWithBorder;
//    } else {
//        self.thumbnailImage.image = [[UIImage alloc] initWithCGImage: imageWithBorder.CGImage
//                                                               scale: 1.0
//                                                         orientation: [self getImageOrientationFromUIOrientation:orientation]];
//    }
//    imageWithBorder = nil;
//    
//    // Size the results UIScrollView to hold both the image and the results.
//    CGSize size = self.scrollView.contentSize;
//    size.height = self.resultText.frame.size.height + self.thumbnailImage.frame.size.height + 100;
//    self.scrollView.contentSize = size;
//    
//    // Reset the UIScrollView to the top of its scrolling range.
//    self.scrollView.contentOffset = CGPointZero;
//    
//    return;
//}

/**
 * Called when the Back button is pressed, this will set the Running state
 * to YES (processing images) if it is not already set.  The Back button is
 * only visible while displaying recognition results.
 *
 * @param sender ID of the sending object. Unused.
 */
//- (IBAction)onClickBackButton:(id)sender {
//    if([self isRunning] == YES) return;
//    
//    [self setRunningState :YES];
//    
//    return;
//}

/**
 * Callback that is executed when an image is being sent to the recognition
 * library for decoding.  It performs animations that show images are being
 * processed.  The laser animation moves forward, and the dots following the
 * word "Processing" move.
 *
 * @param image Not currently used.
 */
//- (void)onProcessingBarcode :(BXThreadData*)data {
//    if([self isRunning] == NO) return;
//    static int currentDot=0;
//    currentDot++; currentDot%=5;
//    
//    NSString *status = @"Processing: .";
//    for(int i=0; i<5; ++i) {
//        if(i==currentDot) status = [NSString stringWithFormat:@"%@ ",status];
//        status = [NSString stringWithFormat:@"%@.",status];
//    }
//    
//    self.processLabel.text = status;
//    [self animateLaser];
//    
//    return;
//}

/**
 * Action that is invoked when the Accusoft UITextView is touched.
 * The browswer is invoked to display Accusoft's website.
 *
 * @param sender ID of the sending object. Unused.
 */
//- (IBAction)onClickAccusoft:(id)sender {
//    
//    return;
//}

/**
 * Copy a UIImage and draw a red border around the barcode region that
 * was identified by the recognition library.
 *
 * @param image UIImage that was sent to the recognition library for recognition.
 * @param result BXResult returned by the recognition library as a result
 * of processing the image. See BXResult.
 * @returns A new UIImage with a red border draw between the points defined
 * in the result.
 */
//- (UIImage *)drawBarcodeBorder :(UIImage *)image :(BXResult*)result {
//    CGPoint p1,p2,p3,p4;
//    p1=[result.m_P1 CGPointValue];
//    p2=[result.m_P2 CGPointValue];
//    p3=[result.m_P3 CGPointValue];
//    p4=[result.m_P4 CGPointValue];
//    
//    // Begin a graphics context of sufficient size.
//    UIGraphicsBeginImageContext(image.size);
//    
//    // Draw original image into the context.
//    [image drawAtPoint:CGPointZero];
//    
//    // Get the context for CoreGraphics.
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    // Set line color and width
//    [[UIColor redColor] setStroke];
//    CGContextSetLineWidth(ctx, 3.0);
//    
//    CGPoint pointList[8];
//    pointList[7] = pointList[0] = p1;
//    pointList[1] = pointList[2] = p2;
//    pointList[3] = pointList[4] = p3;
//    pointList[5] = pointList[6] = p4;
//    
//    // Draw lines.
//    CGContextStrokeLineSegments(ctx, pointList, 8);
//    
//    // Make image out of bitmap context.
//    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // Remove graphics context from the stack.
//    UIGraphicsEndImageContext();
//    
//    return retImage;
//}

/**
 * Utility routine that moves the laser animation in the viewfinder.
 */
//- (void)animateLaser {
//    int w = hashImage.bounds.size.width;
//    int h = hashImage.bounds.size.height;
//    int lw = laserImage.bounds.size.width;
//    int lh = laserImage.bounds.size.height;
//    
//    laserImage.frame = (CGRect){{0,h/2},{lw,lh}};
//    
//    [UIView animateWithDuration:0.5 animations:^(void) {
//        laserImage.frame = (CGRect){{w,h/2},{lw,lh}};
//    }];
//    
//    return;
//}

/**
 * Load and initialize the structures used for drawing the animated
 * laser in the viewfinder overlay.
 */
//- (void)createLaser {
//    int w = 2;
//    int h = 1;
//    
//    // Create & get the context for CoreGraphics.
//    UIGraphicsBeginImageContext((CGSize){w,h});
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    // Set stroke color to red and draw lines.
//    [[UIColor whiteColor] setFill];
//    CGContextFillRect(ctx, (CGRect){{0,0},{w,h}});
//    
//    // Make image out of bitmap context and free the context.
//    laserImage.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    laserImage.frame = (CGRect){{0,0},{w,h}};
//    
//    return;
//}

/**
 * Draw the viewfinder overlay using a semi-transparent set of rectangles
 * around the perimeter of the display with a solid red "laser" line
 * through the center.  The "laser" line is where detection of a possibly
 * blurred image happens.
 */
//- (void)createBorder {
//    // hashImage is UIImageView where the viewfinder overlay is drawn.
//    int w = hashImage.bounds.size.width;
//    int h = hashImage.bounds.size.height;
//    
//    // Size the semi-transparent area.
//    int mw = w * 0.2;
//    int mh = h * 0.2;
//    
//    // Create a CoreGraphics context that we'll draw into.
//    UIGraphicsBeginImageContext(self.hashImage.bounds.size);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    // Set fill color to black and draw border.
//    [[UIColor blackColor] setFill];
//    CGContextFillRect(ctx, (CGRect){{0,      0}, {mw, h}});
//    CGContextFillRect(ctx, (CGRect){{0,      0}, {w, mh}});
//    CGContextFillRect(ctx, (CGRect){{w - mw, 0}, {mw, h}});
//    CGContextFillRect(ctx, (CGRect){{0, h - mh}, {w, mh}});
//    
//    // Set stroke color to red and draw laser line across the center.
//    CGPoint points[2];
//    [[UIColor redColor] setStroke];
//    CGContextSetLineWidth(ctx, 2.0);
//    points[0]=(CGPoint){0,h/2}; points[1]=(CGPoint){w,h/2};
//    CGContextStrokeLineSegments(ctx, points, 2);
//    
//    // Extract a UIImage from the graphics context and free the context.
//    hashImage.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return;
//}

/**
 * Query the Accusoft recognition library for its version information and return that.
 *
 * @returns a UTF8 character string containing the library version number.
 */
//- (const char *)reportVersion {
//    
//    return [barcodeXpress ReportVersion];
//}

/**
 * Set the types of barcodes that will be recognized by the recognition library,
 * using the booleans set earlier by querying our application settings from the
 * system-wide Settings app.
 */
//- (void)setBarcodeTypesUsingSettings {
//    long barcodeType =
//    (appDelegate.modelForBarCode.enableAdd2Code ? Add2BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableAdd5Code ? Add5BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableAustralianPost4StateCode ? AustralianPost4StateBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableAztecCode ? AztecBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableBCDMatrixCode ? BCDMatrixBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableCodabarCode ? CodabarBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableCode128Code ? Code128BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableCode32Code ? Code32BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableCode39Code ? Code39BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableCode39ExtendedCode ? Code39ExtendedBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableCode93Code ? Code93BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableCode93ExtendedCode ? Code93ExtendedBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableDataLogic2of5Code ? DataLogic2of5BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableDataMatrixCode ? DataMatrixBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableEAN128Code ? EAN128BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableEAN13Code ? EAN13BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableEAN8Code ? EAN8BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableGS1DataBarCode ? GS1DataBarBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableIATA2of5Code ? IATA2of5BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableIndustry2of5Code ? Industry2of5BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableIntelligentMailCode ? IntelligentMailBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableInterleaved2of5Code ? Interleaved2of5BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableInvertiert2of5Code ? Invertiert2of5BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableMatrix2of5Code ? Matrix2of5BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enablePDF417Code ? PDF417BarcodeType : 0) +
//    (appDelegate.modelForBarCode.enablePatchCode ? PatchCodeBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enablePostNetCode ? PostNetBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableQRCode ? QRCodeBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableRoyalPost4StateCode ? RoyalPost4StateBarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableUPCACode ? UPCABarcodeType : 0) +
//    (appDelegate.modelForBarCode.enableUPCECode ? UPCEBarcodeType : 0);
//    
//    [barcodeXpress SetBarcodeTypes :barcodeType];
//}

//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

//- (IBAction)cancelButtonAction:(id)sender {
//    
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//}
@end
