//
//  CameraDelegate.h
//  ASR Pro
//
//  Created by GuruMurthy on 07/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CameraDelegate <NSObject>
- (void)setImage:(UIImage*)pickedImage;
@end
