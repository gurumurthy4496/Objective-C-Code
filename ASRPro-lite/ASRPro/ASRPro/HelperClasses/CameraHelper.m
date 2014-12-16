//
//  CameraHelper.m
//  ASR Pro
//
//  Created by GuruMurthy on 07/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "CameraHelper.h"

@implementation CameraHelper
@synthesize cameraDelegate;
@synthesize mParentController_;

- (id)init{
	
	if (self=[super init]) {
		return self;
	}
	return self;
}

- (void)invokeImgPickerController:(UIImagePickerControllerSourceType)sourceType
                 parentController:(UIViewController*)controller{
    
	if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
		UIImagePickerController *lImagePickerController=[[UIImagePickerController alloc]init];
		lImagePickerController.delegate=self;
		lImagePickerController.sourceType=sourceType;
        [controller presentViewController:lImagePickerController animated:NO completion:^{
            }];
        
        // ----------------------------;
        // Setting frames for UIImagePickerControllerSourceTypeCamera and UIImagePickerControllerSourceTypePhotoLibrary for IOS7;
        // ----------------------------;
        
        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                CGRect lFrame = [[UIScreen mainScreen] bounds];
                lFrame.origin.y = Y_POS;
                lFrame.size.height -= Y_POS;
                [lImagePickerController.view setFrame:lFrame];
            }
        }else {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
                CGRect lFrame = [[UIScreen mainScreen] bounds];
                lFrame.origin.y = 0;
                [lImagePickerController.view setFrame:lFrame];
            }
        }
	}else {
        UIAlertView *lAlert = [[UIAlertView alloc] initWithTitle:@"Source Type" message:@"Specified Source type is not available on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [lAlert show];
        
	}
}
//When you have camera in the view controller use below method
- (void)navigationController:(UINavigationController *)navigationController     willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    }
}


#pragma mark Image picker Delegates
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
//    [cameraDelegate setImage:image];
//
//    [picker dismissModalViewControllerAnimated:YES];
//}
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [cameraDelegate setImage:[info objectForKey: UIImagePickerControllerOriginalImage]];
    
//    [picker dismissModalViewControllerAnimated:YES];
    
    [picker dismissViewControllerAnimated:NO completion:^{
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//	[picker dismissModalViewControllerAnimated:YES];
    
    [picker dismissViewControllerAnimated:NO completion:^{
    }];
}

@end
