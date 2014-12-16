//
//  TTiOSVINScannerVC.h
//  ASRPro
//
//  Created by Guru Murthy Pulipati on 09/12/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarcodeTextField.h"
@class BarcodeTextField;

@interface TTiOSVINScannerVC : UIViewController
@property (nonatomic, strong) BarcodeTextField *barcodeTextField;
- (void)configureScanner;
@end
