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
        DLog(@"Starting: %@", urlString);
        UIImage *avatarImage = nil; 
        NSData *responseData = [NSData dataWithContentsOfURL:urlString];
        avatarImage = [UIImage imageWithData:responseData];
        DLog(@"Finishing: %@", urlString);
        if (avatarImage) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self isKindOfClass:[VehicleDiagramsImageView class]]) {
                    if (avatarImage.size.height > self.frame.size.height) {
                        [self setFrame:CGRectMake((self.frame.size.width - avatarImage.size.width)/2 + self.frame.origin.x, 0, avatarImage.size.width,  self.frame.size.height)];
                    }else {
                        [self setFrame:CGRectMake((self.frame.size.width - avatarImage.size.width)/2 + self.frame.origin.x, (self.frame.size.height - avatarImage.size.height)/2, avatarImage.size.width,  avatarImage.size.height)];
                    }
//                    [self setBackgroundColor:[UIColor redColor]];
                }
                self.image = avatarImage;
//                [self.layer setBorderWidth:1.0f];
//                [self.layer setBorderColor:[UIColor redColor].CGColor];
              //  [self saveImageIntofile:urlString :avatarImage];
            });
            dispatch_async(dispatch_get_main_queue(), completion);
        }
        else {
            dispatch_async(dispatch_get_main_queue(), completion);
            DLog(@"-- impossible download: %@", urlString);
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
                 if ([[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_].mDamageDetailsArray_ count] > 0 || [[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForWalkAround_].mDamageDetailsArray_ != nil) {
                     [[[[SharedUtilities sharedUtilities] appDelegateInstance] mGetVehicleDamagepointOnImageView_] getVehicleDamagePointsOnTheImageViewIndex:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_].mVehicleDiagramViewAngleID_ VehicleDiagramSetID:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mVehicleDiagramForDamagesSetID_];
                 }
                 break;
             case 2: // IsBuildInspectionPopup
                 [[[SharedUtilities sharedUtilities] appDelegateInstance].buildInspectionDetailsViewController.mShowDeleteButtonOnImageView_ showDeleteButtonOnBuildInspectionDetailsImageView];
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
                self.activityView.center = CGPointMake((self.frame.size.width / 2.0f), (self.frame.size.height / 2.0f));
                break;
            case 2: // IsBuildInspectionPopup
                activityView.center = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
                break;
            case 3: // IsCustomerSignature
                activityView.center = CGPointMake((self.frame.size.width / 2.0f), (self.frame.size.height / 2.0f));
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
