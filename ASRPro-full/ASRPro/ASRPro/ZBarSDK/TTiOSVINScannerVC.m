//
//  TTiOSVINScannerVC.m
//  ASRPro
//
//  Created by Guru Murthy Pulipati on 09/12/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "TTiOSVINScannerVC.h"
#import <CoreImage/CoreImage.h>

#define AVCAPTURE_EXPERIMENT 0

@interface TTiOSVINScannerVC ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) UIView *cameraPreview;
@end

@implementation TTiOSVINScannerVC {
    AVCaptureSession *captureSession;
    AVCaptureVideoPreviewLayer *previewLayer;
    
    BOOL ignoreRecognition;
    
    NSInteger sampleBufferCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureScanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)configureScanner{
    
    captureSession = [[AVCaptureSession alloc] init];
    AVCaptureDevice *videoCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoCaptureDevice error:&error];
    if(videoInput)
        [captureSession addInput:videoInput];
//    else
//        ErrorLog(@"Error: %@", error);
    
    
    //-- Create the output for the capture session.
    AVCaptureVideoDataOutput * dataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [dataOutput setAlwaysDiscardsLateVideoFrames:YES]; // Probably want to set this to NO when recording
    
#if AVCAPTURE_EXPERIMENT
    dispatch_queue_t videoOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    [videoOutput setSampleBufferDelegate:self queue:videoOutputQueue];
    [captureSession addOutput:videoOutput];
#endif
    
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [captureSession addOutput:metadataOutput];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    NSMutableArray *barcodeTypes = [NSMutableArray arrayWithArray:@[AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode]];
    // DataMatrix first available in iOS 8
    if (&AVMetadataObjectTypeDataMatrixCode != NULL) {
        [barcodeTypes addObject:AVMetadataObjectTypeDataMatrixCode];
    }
    metadataOutput.metadataObjectTypes = barcodeTypes;
    
    previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    // Need to swap width/height if iOS 8 or later
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        previewLayer.frame = [[UIScreen mainScreen] bounds];
    } else {
        previewLayer.frame = [[UIScreen mainScreen] bounds];
        CGPoint origin = [[UIScreen mainScreen] bounds].origin;
        CGFloat width = [[UIScreen mainScreen] bounds].size.height;
        CGFloat height = [[UIScreen mainScreen] bounds].size.width;
        previewLayer.frame = CGRectMake(origin.x, origin.y, width, height);
    }
    
    // Create a view into which the video preview layer will be placed.
    // Using this view instead of placing the layer directly into the root
    // view will allow for a smooth rotation animation.
    _cameraPreview = [[UIView alloc] init];
    _cameraPreview.transform = CGAffineTransformMakeRotation(-M_PI/2);
    _cameraPreview.frame = self.view.bounds;
    [_cameraPreview.layer addSublayer:previewLayer];
    
    // Place the preview imagery at the bottom of the view stack.
    [self.view insertSubview:_cameraPreview atIndex:0];
    
    [self startRecognition];
    
//    [self configureCamera];
    [self setBarCodeBGImageView];
}

- (void)setBarCodeBGImageView {
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView setFrame:[[UIScreen mainScreen] bounds]];
    [bgImageView setImage:[UIImage imageNamed:@"barcode-bg"]];
    [self.view addSubview:bgImageView];
    [self setCancelButtonOnImageView:self.view];
    [self setCustomBarCodeTextField:self.view];
    [self setLightButtonOnImageView:self.view];
    [self setManualEntryButtonOnImageView:self.view];
    [self setQuickAddButtonOnImageView:self.view];
}

- (void)setCancelButtonOnImageView:(UIView *) aImageView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(kScreenWidth - 130, 20, 100, 60)];
    [[button titleLabel] setFont:[UIFont regularFontOfSize:25 fontKey:kFontRegularKey]];
    [button setTitle:@"Cancel" forState:UIControlStateNormal];
    [button setTitle:@"Cancel" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    //    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aImageView addSubview:button];
}

- (void)setCustomBarCodeTextField:(UIView *)aImageView {
    BarcodeTextField *textField = [[BarcodeTextField alloc] init];
    [textField setFrame:CGRectMake(138, 315, 747, 138)];
    [textField initializeTextField];
    [textField showOrHideTextField:YES];
    [aImageView addSubview:textField];
    [self setBarcodeTextField:textField];
}

- (void)setLightButtonOnImageView:(UIView *) aImageView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(40, 20, 100, 60)];
    [button setTitle:@"    Light" forState:UIControlStateNormal];
    [button setTitle:@"    Light" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"bulb"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"bulb"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"bulb"] forState:UIControlStateSelected];
    [[button titleLabel] setFont:[UIFont regularFontOfSize:25 fontKey:kFontRegularKey]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(lightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aImageView addSubview:button];
}

- (void)setManualEntryButtonOnImageView:(UIView *) aImageView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 629, 511, 140)];
    [button setTitle:@"    Manual Entry" forState:UIControlStateNormal];
    [button setTitle:@"    Manual Entry" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateSelected];
    [[button titleLabel] setFont:[UIFont regularFontOfSize:25 fontKey:kFontRegularKey]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [button addTarget:self action:@selector(manualEntryButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aImageView addSubview:button];
}

- (void)setQuickAddButtonOnImageView:(UIView *) aImageView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(513, 629, 512, 140)];
    [button setTitle:@"    Quick Add" forState:UIControlStateNormal];
    [button setTitle:@"    Quick Add" forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"car"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"car"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"car"] forState:UIControlStateSelected];
    [[button titleLabel] setFont:[UIFont regularFontOfSize:25 fontKey:kFontRegularKey]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [button addTarget:self action:@selector(quickAddButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [aImageView addSubview:button];
}

- (IBAction)lightButtonAction:(id)sender {
}

- (IBAction)manualEntryButtonAction:(id)sender {
    [self.barcodeTextField showOrHideTextField:NO];
    [self.barcodeTextField becomeFirstResponder];
}

- (IBAction)quickAddButtonAction:(id)sender {
}

-(IBAction)cancelButtonAction:(id)sender {
    
    if (self.barcodeTextField.text != nil) {
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_ setVINTextToBeginVehicleCheckIn:self.barcodeTextField.text];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate methods

#if AVCAPTURE_EXPERIMENT
// Experimental - can we use the camera output to feed a DataMatrix scanner (libdmtx) on pre-iOS 8 versions?
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    //    sampleBufferCount++;
    //
    //    // get the image
    //    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    //    CIImage *ciImage = [[CIImage alloc] initWithCVPixelBuffer:pixelBuffer];
    //    UIImage *uiImage = [self makeUIImageFromCIImage:ciImage];
    //
    //    NSLog(@"+++ didOutputSampleBuffer... count: %d  w: %f  h: %f", sampleBufferCount, uiImage.size.width, uiImage.size.height);
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    NSLog(@"--- didDropSampleBuffer...");
}

-(UIImage*)makeUIImageFromCIImage:(CIImage*)ciImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    // finally!
    UIImage * returnImage;
    
    CGImageRef processedCGImage = [context createCGImage:ciImage
                                                fromRect:[ciImage extent]];
    
    returnImage = [UIImage imageWithCGImage:processedCGImage];
    CGImageRelease(processedCGImage);
    
    return returnImage;
}
#endif

- (void)startRecognition{
    [captureSession startRunning];
}

- (void)stopRecognition{
    [captureSession stopRunning];
}


#pragma mark - Barcode handling methods

- (void)ignoreRecognition:(BOOL)ignore{
    ignoreRecognition = ignore;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (ignoreRecognition) {
        return;
    }
    
    for(AVMetadataObject *metadataObject in metadataObjects)
    {
        AVMetadataMachineReadableCodeObject *readableObject = (AVMetadataMachineReadableCodeObject *)metadataObject;
        NSString *barcodeString = readableObject.stringValue;
        //        if ([self containsValidVIN:barcodeString]) {
        [self stopRecognition];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_ getVinNumberFromBarCode:barcodeString barCodeViewController:self];
        //            break;
    }
}


/**
 * Method to provide a smooth rotation transition for the preview imagery.
 *
 * @param interfaceOrientation The new orientation.
 */
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    [self setCameraPreviewTransform :toInterfaceOrientation];
}
/*
 * Returns a mask containing the set of desired
 * UI orientations. Used for iOS 6.0 or later.
 */
- (NSUInteger)supportedInterfaceOrientations {
    [self setCameraPreviewTransform :[[UIApplication sharedApplication] statusBarOrientation]];
    return UIInterfaceOrientationMaskLandscape;
}


/**
 * Method to set the transform for the preview imagery.
 *
 * @param toInterfaceOrientation The new orientation.
 */
- (void) setCameraPreviewTransform:(UIInterfaceOrientation)toInterfaceOrientation {
    if (_cameraPreview) {
        switch(toInterfaceOrientation) {
            case UIInterfaceOrientationPortrait:
                _cameraPreview.transform = CGAffineTransformMakeRotation(0);
                break;
            case UIInterfaceOrientationLandscapeLeft:
                _cameraPreview.transform = CGAffineTransformMakeRotation(M_PI/2);
                break;
            case UIInterfaceOrientationLandscapeRight:
                _cameraPreview.transform = CGAffineTransformMakeRotation(-M_PI/2);
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                _cameraPreview.transform = CGAffineTransformMakeRotation(M_PI);
                break;
            default: ;
        }
        _cameraPreview.frame = CGRectMake(0, 0, 1024, 768);
        //            NSLog(@"previewLayer :%@",NSStringFromCGRect(previewLayer.frame));
    }
    
    /*#define CAMERA_TRANSFORM                    2.12412
     
     self.wantsFullScreenLayout = YES;
     self.cameraPreview.transform = CGAffineTransformScale(self.cameraPreview.transform, CAMERA_TRANSFORM, CAMERA_TRANSFORM);*/
    
}

@end

