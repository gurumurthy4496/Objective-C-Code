//
//  UIImage+DispatchLoad.m
//  DreamChannel
//
//  Created by Slava on 3/28/11.
//  Copyright 2011 Alterplay. All rights reserved.
//

#import "UIImageView+DispatchLoad.h"
#import "DataBaseUtilsClass.h"
@implementation UIImageView (DispatchLoad)

- (void) setImageFromUrl:(NSURL*)urlString {
    [self setImageFromUrl:urlString completion:NULL];
}

- (void) setImageFromUrl:(NSURL*)urlString 
              completion:(void (^)(void))completion {
    
    if(![self isImgFound:urlString]){

    dispatch_queue_t downloadQueue = dispatch_queue_create("image downloader", NULL);
    
	//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    dispatch_async(downloadQueue,^{
        NSLog(@"Starting: %@", urlString);
        UIImage *avatarImage = nil; 
        NSData *responseData = [NSData dataWithContentsOfURL:urlString];
        avatarImage = [UIImage imageWithData:responseData];
        NSLog(@"Finishing: %@", urlString);
        if (avatarImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = avatarImage;
              //  [self saveImageIntofile:urlString :avatarImage];
            });
            dispatch_async(dispatch_get_main_queue(), completion);
        }
        else {
            dispatch_async(dispatch_get_main_queue(), completion);
            NSLog(@"-- impossible download: %@", urlString);
        }
	});
        dispatch_release(downloadQueue);
    } else {
         UIImage *avatarImage = nil; 
        avatarImage = [self getImageIntofile:urlString];
        if (avatarImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = avatarImage;
            });
            dispatch_async(dispatch_get_main_queue(), completion);
        }
    }
}
-(BOOL)isImgFound:(NSURL *)imgName {
    NSString *limgName = [imgName absoluteString];
    limgName = ([limgName length]>9)?[limgName substringFromIndex:[limgName length]-31]:@"Error";
    NSData *pictureData = [[DataBaseUtilsClass instance] loadDataFromFile:@"CacheIMG" :limgName];
    if(pictureData!=nil){
        return NO;//yes
    } else {
        return NO;
    }
}
-(void)saveImageIntofile:(NSURL *)imgName : (UIImage *)limg {
     CGSize newSize;
     if([limg size].height>(150)){
     newSize.height=(150);
     newSize.width=(150)*[limg size].width/([limg size].height);
     }
     else{
     newSize.width=limg.size.width;
     newSize.height=limg.size.height;
     }
     UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
     [limg drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
     limg = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
    NSString *limgName = [imgName absoluteString];
    limgName = ([limgName length]>9)?[limgName substringFromIndex:[limgName length]-31]:@"Error";
    NSData* pictureData = UIImageJPEGRepresentation(limg, 1.0f);
     [[DataBaseUtilsClass instance] saveDataInToFile:pictureData :@"CacheIMG" :limgName];
  
}
-(UIImage *)getImageIntofile:(NSURL *)imgName {
    NSString *limgName = [imgName absoluteString];
    limgName = ([limgName length]>9)?[limgName substringFromIndex:[limgName length]-31]:@"Error";
  NSData *pictureData = [[DataBaseUtilsClass instance] loadDataFromFile:@"CacheIMG" :limgName];
   UIImage* avatarImage = [UIImage imageWithData:pictureData];
    return avatarImage;
}
@end


@implementation AsyncCustImageView
@synthesize activityView;
@synthesize mUIImageViewDispatchLoader_;

- (void)setCustomImageURL:(NSURL *)imageURL
{
    [self setImageFromUrl:imageURL
     completion:^(void) {
     
     [UIView animateWithDuration:0.0 animations:^(void) {
         CATransition *animation = [CATransition animation];
         animation.type = kCATransitionFade;
         animation.duration = 0.3;
         [self.layer addAnimation:animation forKey:nil];
     } completion:^(BOOL finished) {
         [self.activityView stopAnimating];
         [self.activityView removeFromSuperview];
         
         switch (self.mUIImageViewDispatchLoader_) {
             case 1: // IsVehicleTypeImage
                 [[[[SharedUtilities sharedUtilities] appDelegateInstance] mGetVehicleDamagepointOnImageView_] getVehicleDamagePointsOnTheImageViewIndex:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_].mVehicleDiagramViewAngleID_ VehicleDiagramSetID:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mVehicleDiagramForDamagesSetID_];                 break;
             case 2: // IsBuildInspectionPopup
                 [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mVehicleDiagramsImageView_.mDamagePopupViewController_.mBuildInspectionDetailsViewController_.mShowDeleteButtonOnImageView_ showDeleteButtonOnBuildInspectionDetailsImageView];
                 break;
             case 3: // IsCustomerSignature
                 break;
             default:
                 break;
         }
         
     }];
     }
     ]; // ********* new way *****
    
    if (self.activityView == nil)
    {
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityView.hidesWhenStopped = YES;
        switch (self.mUIImageViewDispatchLoader_) {
            case 1: // IsVehicleTypeImage
                self.activityView.center = CGPointMake((self.frame.size.width / 2.0f), (self.frame.size.width / 2.0f) - 280);
                break;
            case 2: // IsBuildInspectionPopup
                activityView.center = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.width / 2.0f);
                break;
            case 3: // IsCustomerSignature
                activityView.center = CGPointMake((self.frame.size.width / 2.0f), (self.frame.size.width / 2.0f) - 230);
                break;
            default:
                break;
        }
        self.activityView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:self.activityView];
    }
    [self.activityView startAnimating];
    
}



- (void)dealloc
{
    [activityView release];
    [super dealloc];
}

@end
