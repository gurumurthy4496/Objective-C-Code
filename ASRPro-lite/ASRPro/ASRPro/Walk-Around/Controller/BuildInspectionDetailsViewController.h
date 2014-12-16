//
//  BuildInspectionDetailsViewController.h
//  ASRPro
//
//  Created by GuruMurthy on 10/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowDeleteButtonOnImageView.h"

@interface BuildInspectionDetailsViewController : UIViewController<UIPopoverControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,OnsuccessProtocol,ShowDeleteButtonOnImageView>

@property (weak, nonatomic) IBOutlet UIView *mBorderView_;
@property (weak, nonatomic) IBOutlet UIButton *mAddPhotoButton_;
@property (weak, nonatomic) IBOutlet UILabel *mHeadingLabel_;
@property (weak, nonatomic) IBOutlet UITableView *mDamageTypesTableView_;
@property (weak, nonatomic) IBOutlet UITableView *mSeverityTypesTableView_;
@property (weak, nonatomic) IBOutlet AsyncCustImageView *mImageView_;
@property (weak, nonatomic) IBOutlet UITextView *mTextView_;
@property (weak, nonatomic) IBOutlet UIButton *mDeleteButton_;
@property (strong, nonatomic) IBOutlet UIButton *mUpdateAddPhotoImageButton_;
@property (nonatomic, assign) id<ShowDeleteButtonOnImageView> mShowDeleteButtonOnImageView_;

- (void)setBuildInspectionDetailsViewForPostRequestDamageID :(NSString *)ID VehicleDamageDetailTypeID :(NSString *)aVehicleDamageDetailTypeID VehicleDamageSeverityID :(NSString *)aVehicleDamageSeverityID Notes:(NSString *)aNotes ImageURL:(NSString *)aImageURL;

- (IBAction)addphotoButtonAction:(id)sender;

- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)saveButtonAction:(id)sender;

- (IBAction)deleteButtonAction:(id)sender;
- (IBAction)updateAddPhotoButtonAction:(id)sender;

@end
