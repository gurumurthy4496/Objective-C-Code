//
//  UIImage+DispatchLoad.h
//  DreamChannel
//
//  Created by Slava on 3/28/11.
//  Copyright 2011 Alterplay. All rights reserved.
//

@interface UIImageView (DispatchLoad)

- (void) setImageFromUrl:(NSURL*)urlString;
- (void) setImageFromUrl:(NSURL*)urlString 
              completion:(void (^)(void))completion;
-(BOOL)isImgFound:(NSURL *)imgName;
-(void)saveImageIntofile:(NSURL *)imgName : (UIImage *)limg;
-(UIImage *)getImageIntofile:(NSURL *)imgName;

@end

typedef enum {
    
    IsVehicleTypeImage = 1,
    
    IsBuildInspectionPopup,
    
    ISCustomerSignature,
    
} UIImageViewDispatchLoader;

@interface AsyncCustImageView : UIImageView
@property (nonatomic, assign) UIImageViewDispatchLoader mUIImageViewDispatchLoader_;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
- (void)setCustomImageURL:(NSURL *)imageURL;
@end