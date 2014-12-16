//
//  CameraHelper.h
//  ASR Pro
//
//  Created by GuruMurthy on 07/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CameraDelegate.h"


@class CameraHelper;
@interface CameraHelper : NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
	UIViewController *mParentController_;
}
@property (nonatomic,assign)id<CameraDelegate> cameraDelegate;
@property (nonatomic,retain)UIViewController *mParentController_;

//Method to be called when either photo album or camera action is to be active
- (void)invokeImgPickerController:(UIImagePickerControllerSourceType)sourceType
                 parentController:(id)controller;
@end
