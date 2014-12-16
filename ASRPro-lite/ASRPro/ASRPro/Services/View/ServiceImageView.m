//
//  ServiceImageView.m
//  ASRPro
//
//  Created by Kalyani on 11/6/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "ServiceImageView.h"
#import "AsyncImageView.h"
#define KImageViewHeight 155
@interface ServiceImageView(){
    int currentTag;
    int count;
    int AddedCount;
    int DeleteCount;
    int totalCount;
    BOOL isAnimating;
    UIButton*mTempButton;
}
@property(nonatomic,retain) NSMutableArray* mImagesArray_;
@property(nonatomic,retain) NSMutableArray* mNewImagesArray_;
@property(nonatomic,retain) NSMutableArray* mDeleteImagesArray_;
@property(nonatomic,retain) UIPopoverController* lUIPopoverController;
@property(nonatomic,retain) UIImagePickerController*mUIImagePickerController_;

@end

@implementation ServiceImageView
@synthesize mImagesArray_;
@synthesize mDeleteImagesArray_;
@synthesize mNewImagesArray_;
@synthesize lUIPopoverController;
@synthesize mUIImagePickerController_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        AddedCount=100;
        totalCount=0;
    }
    return self;
}


-(void)addImagesArrayView:(NSMutableArray*)anImageArray{
   mDeleteImagesArray_=[[NSMutableArray alloc] init];
   // NSMutableArray*lTempArray=[[NSMutableArray alloc] init];
    
    for(int i=0;i<[anImageArray count];i++){
        [self setMNewImagesArray_:anImageArray];
    UIButton*mAddPhotoButton=[[UIButton alloc] initWithFrame:CGRectMake(330, (10+i*130)+23, 65, 65)];
        [mAddPhotoButton setBackgroundImage:[UIImage imageNamed:@"IMG_add-photo"] forState:UIControlStateNormal];
        [mAddPhotoButton setBackgroundImage:[UIImage imageNamed:@"IMG_add-photo"] forState:UIControlStateSelected];
        [mAddPhotoButton setTitle:@"Add Photo" forState:UIControlStateNormal];
        [mAddPhotoButton setTitle:@"Delete Photo" forState:UIControlStateSelected];
        [mAddPhotoButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
        [mAddPhotoButton setTitleColor:[UIColor ASRProLoginErrorViewBackgroundColor] forState:UIControlStateSelected];

        [mAddPhotoButton.titleLabel setNumberOfLines:2];
        [mAddPhotoButton.titleLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey]];
       // mAddPhotoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [mAddPhotoButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [mAddPhotoButton setSelected:YES];
        [ mAddPhotoButton setTag:1000+i ];
        [mAddPhotoButton addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mAddPhotoButton];
        AsyncImageView* lTempImage=[[AsyncImageView alloc] initWithFrame:CGRectMake(90, (10+i*130), 192, 120)];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[anImageArray objectAtIndex:i] objectForKey:@"ImageUrl"]]];
        //load the image

        [lTempImage setImageURL:url];
       // [lTempImage setImage:[UIImage imageNamed:@"IMG_image-holder"]];
        [lTempImage setTag:i];
        [self addSubview:lTempImage];
    }
    count=[anImageArray count];
    totalCount=count;

    [self addEmptyPhoto];
    CGRect frame=self.frame;
frame.size.height=140*(totalCount+1);
[self setFrame:frame];
    [[FileUtils fileUtils] deleteAllFilesFromPath:kIMAGEPATH];
}

-(void)addEmptyPhoto{
    UIButton*mAddPhotoButton=[[UIButton alloc] initWithFrame:CGRectMake(330, (10+(totalCount)*130)+23, 65, 65)];
    [mAddPhotoButton setBackgroundImage:[UIImage imageNamed:@"IMG_add-photo"] forState:UIControlStateNormal];
    [mAddPhotoButton setBackgroundImage:[UIImage imageNamed:@"IMG_add-photo"] forState:UIControlStateSelected];
    [ mAddPhotoButton setTag:1000+AddedCount ];
    [mAddPhotoButton setTitle:@"Add Photo" forState:UIControlStateNormal];
    [mAddPhotoButton setTitle:@"Delete Photo" forState:UIControlStateSelected];
    //mAddPhotoButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    [mAddPhotoButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
    [mAddPhotoButton setTitleColor:[UIColor ASRProLoginErrorViewBackgroundColor] forState:UIControlStateSelected];

    [mAddPhotoButton.titleLabel setNumberOfLines:2];
    [mAddPhotoButton.titleLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey]];
    
    [mAddPhotoButton.titleLabel setTextAlignment:NSTextAlignmentCenter];

    [mAddPhotoButton addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mAddPhotoButton];
    AsyncImageView* lTempImage=[[AsyncImageView alloc] initWithFrame:CGRectMake(90, (10+(totalCount)*130), 192, 120)];
    [lTempImage setImage:[UIImage imageNamed:@"IMG_image-holder"]];
    [lTempImage setTag:AddedCount];
    [self addSubview:lTempImage];
}
- (void)setImage:(UIImage*)pickedImage {
    
    [self addImages:pickedImage imageName:[NSString stringWithFormat:@"%@-%d",kIMAGEPATH,AddedCount]];
     
     //if (pickedImage != nil) {
//
    // [[[SharedUtilities sharedUtilities] appDelegateInstance].mServicesDetailsViewController_.mServicesDetailTableViewController_.tableView reloadData];
    [self reloadServicesData];
   pickedImage=nil;

    
     
}
- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    
    if([image size].height>KImageViewHeight){
        newSize.height=KImageViewHeight;
        newSize.width=KImageViewHeight*[image size].width/([image size].height);
    }
    else{
        newSize.width=image.size.width;
        newSize.height=image.size.height;
    }
    UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
	
}


- (void)addImages:(UIImage *)image imageName:(NSString *)imageName{
    CGSize newSize;
    if([image size].height>(KImageViewHeight*2)){
        newSize.height=(KImageViewHeight*2);
        newSize.width=(KImageViewHeight*2)*[image size].width/([image size].height);
    }
    else{
        newSize.width=image.size.width;
        newSize.height=image.size.height;
    }
    UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData* pictureData = UIImageJPEGRepresentation(newImage, 1.00f);
    newImage=nil;
    [[FileUtils fileUtils] saveDataInToFile:pictureData FolderName:kIMAGEPATH Path:imageName ];
    
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[AsyncImageView class]]) {
            if(((AsyncImageView*)object).tag==currentTag)
//                [(UIImageView*)object setImage:[self imageWithImage:image scaledToSize:newSize]];
                [(AsyncImageView*)object setImage:[self scaleImage:image toSize:newSize]];
        }
        if ([object isKindOfClass:[UIButton class]]) {
            if(((UIButton*)object).tag==currentTag+1000)
                [(UIButton*)object setSelected:YES];
        }
        
    }];
    // }
   // pickedImage=nil;
    AddedCount++;
    totalCount++;
    [self addEmptyPhoto];
    CGRect frame=self.frame;
    frame.size.height=140*(totalCount+1);
    [self setFrame:frame];

}

//to scale images without changing aspect ratio
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
 
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = 320.0/480.0;
    
    if(imgRatio!=maxRatio){
        if(imgRatio < maxRatio){
            imgRatio = 480.0 / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = 480.0;
        }
        else{
            imgRatio = 320.0 / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = 320.0;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


-(void)deleteObject:(int)tag{
    [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[AsyncImageView class]]) {
            if(((AsyncImageView*)object).tag==currentTag)
                [(AsyncImageView*)object removeFromSuperview];
        }
        if ([object isKindOfClass:[UIButton class]]) {
            if(((UIButton*)object).tag==currentTag+1000)
                [(UIButton*)object removeFromSuperview];
        }

    }];
  //  totalCount--;
    if(currentTag<100)
        [mDeleteImagesArray_ addObject:[NSString stringWithFormat:@"%d",currentTag]];
    else
        [[FileUtils fileUtils] deleteFileFromFolder:kIMAGEPATH :[NSString stringWithFormat:@"%@-%d",kIMAGEPATH,currentTag]];
   [self.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[AsyncImageView class]]) {
            if(((AsyncImageView*)object).tag>currentTag){
            CGRect frame=((AsyncImageView*)object).frame;
            frame.origin.y-=130;
            [((AsyncImageView*)object) setFrame:frame];
            }
        }
        if ([object isKindOfClass:[UIButton class]]) {
            if(((UIButton*)object).tag>currentTag+1000){
                CGRect frame=((UIButton*)object).frame;
                frame.origin.y-=130;
                [((UIButton*)object) setFrame:frame];
            }
        }
        
    }];
    CGRect frame=self.frame;
    frame.size.height=140*totalCount;
    totalCount--;
    [self setFrame:frame];
    [self reloadServicesData];
}

-(void)reloadServicesData{
   [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mAddServicesViewController_.mAddServiceTableViewController_.tableView beginUpdates];
   [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mAddServicesViewController_.mAddServiceTableViewController_.tableView endUpdates];
}


-(void)addPhoto:(UIButton*)sender{
    currentTag=sender.tag-1000;

    if(![sender isSelected]){
        mTempButton=sender;
   [self showActionSheet];
    }else
    [self deleteObject:currentTag];
}

-(void)showActionSheet {
    UIActionSheet *lActionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                              delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Take Photo", @"Choose Existing Photo",@"Cancel",nil];
 lActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [lActionSheet setTag:1001];
    [lActionSheet setFrame:CGRectMake(0, 0, 300, 300)];
    [lActionSheet showFromRect: mTempButton.frame inView:  mTempButton.superview animated: YES];


    
}
#pragma mark ***************** Action Sheet Delegate methods ******************
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (actionSheet.tag) {
        case 1001:
        {
            if (buttonIndex == 0 || buttonIndex==1) {
                switch (buttonIndex) {
                    case 0:
                        [self showCamera];
                        break;
                    case 1:
                        [self showPhotoLibrary];
                        break;
                    default:
                        break;
                }
            }else {
                if(buttonIndex==2) {
                    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
                }
            }
        }
            break;
        default:
            break;
    }
}

-(void)showPhotoLibrary {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = NO;
      lUIPopoverController = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        
        [lUIPopoverController presentPopoverFromRect:mTempButton.frame
                                             inView:mTempButton.superview
                           permittedArrowDirections:UIPopoverArrowDirectionDown
                                           animated:YES];
        
    }
}

-(void)showCamera {
    UIImagePickerController *imagePickController = [[UIImagePickerController alloc]init];
  [self setMUIImagePickerController_:imagePickController];
 if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
    mUIImagePickerController_.sourceType=UIImagePickerControllerSourceTypeCamera;
   mUIImagePickerController_.delegate=self;
   mUIImagePickerController_.allowsEditing=NO;
    mUIImagePickerController_.showsCameraControls=YES;
//        //This method inherit from UIView,show imagePicker with animation
      [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] presentViewController:self.mUIImagePickerController_ animated:YES completion:nil];
   }
    else{
        [[SharedUtilities sharedUtilities] showAlertWithTitle:@"Camera" message:@"Camera is not available on your device."];
   }
    
    //    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //    picker.delegate = self;
    //    picker.allowsEditing = YES;
    //    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    [self presentViewController:picker animated:YES completion:NULL];
    
}


#pragma mark --
#pragma mark UIImagePickerController Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [lUIPopoverController dismissPopoverAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image != nil) {
        [self setImage:image];
    }
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendTheimagesToServer {
    NSMutableArray*lTempImageArray=[NSMutableArray new];

    for(int i=0;i<(AddedCount-100);i++){
        NSData *pictureData = [[FileUtils fileUtils] loadDataFromFile:kIMAGEPATH Path:[NSString stringWithFormat:@"%@-%d",kIMAGEPATH,100+i]];
        if(pictureData!=nil){
            
            [lTempImageArray addObject:pictureData];
        }
    }
    
    
    if(([[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mAddServicesViewController_.mGetServiceReference_==OPENROSERVICESVIEWCONTROLLER)||([[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mAddServicesViewController_.mGetServiceReference_==FINISHINSPECTIONVIEWCONTROLLER))
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelforOpenROSupportEngine_] RequestToAddImages:[[[SharedUtilities sharedUtilities]appDelegateInstance] mModelForVehicleHistoryTableView_ ].mOpenROString_ LineId:[[[SharedUtilities sharedUtilities] appDelegateInstance ] mServiceDataGetter_].mModelForSelectedService_.mLineID_ ImageArray:lTempImageArray DeleteImagesArray:[self deleteTheimagesfromServer]];
 
}

- (NSMutableArray*)deleteTheimagesfromServer {
    NSArray *sortedArray = [mDeleteImagesArray_ sortedArrayUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue]< [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] >[obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];

    NSMutableArray* lTempArray=[NSMutableArray new];
    for(int i=0;i<[mDeleteImagesArray_ count];i++){
        [lTempArray addObject:[mNewImagesArray_ objectAtIndex:[[sortedArray objectAtIndex:i] intValue]]];
    }
    
   // if(([[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mAddServicesViewController_.mGetServiceReference_==OPENROSERVICESVIEWCONTROLLER)||([[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mAddServicesViewController_.mGetServiceReference_==FINISHINSPECTIONVIEWCONTROLLER))
    //    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelforOpenROSupportEngine_] RequestToDeleteImages:[[[SharedUtilities sharedUtilities]appDelegateInstance] mModelForVehicleHistoryTableView_ ].mOpenROString_ LineId:[[[SharedUtilities sharedUtilities] appDelegateInstance ] mServiceDataGetter_].mModelForSelectedService_.mLineID_ ImageArray:lTempArray];
    return lTempArray;
}

@end
