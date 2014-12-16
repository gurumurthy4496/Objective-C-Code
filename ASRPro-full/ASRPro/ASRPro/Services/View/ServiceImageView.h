//
//  ServiceImageView.h
//  ASRPro
//
//  Created by Kalyani on 11/6/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraHelper.h"

@interface ServiceImageView : UIView<UIPopoverControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    BOOL isImageDeleted;
       BOOL isImagePresent;
}

-(void)addImagesArrayView:(NSMutableArray*)anImageArray;

- (void)sendTheimagesToServer ;

- (NSMutableArray*)deleteTheimagesfromServer;


@end
