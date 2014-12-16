//
//  BuildInspectionDetailsViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 10/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "BuildInspectionDetailsViewController.h"
#import "WalkAroundSupportWebEngine.h"

#define KImageViewHeight 140
#define KImageViewWidth 195

@interface BuildInspectionDetailsViewController () {
    AppDelegate *mAppDelegate_;
}

/**
 * Instance of UIImagePickerController which is used for UIImagePickerControllerSourceTypeCamera.
 */
@property (retain, nonatomic) UIImagePickerController *mUIImagePickerController_;

/**
 *Instance of UIPopoverController to display UIImagePickerController.
 */
@property (retain, nonatomic) UIPopoverController *mPopoverController_;

/**
 * Instance of NSMutableArray to store DamageTable items Array.
 */
@property (retain, nonatomic) NSMutableArray *mDamageTableArray_;

/**
 * Instance of NSMutableArray to store SeverityTable items Array.
 */
@property (retain, nonatomic) NSMutableArray *mSeverityTableArray_;

@end

@implementation BuildInspectionDetailsViewController
@synthesize mUIImagePickerController_;
@synthesize mPopoverController_;
@synthesize mDamageTableArray_;
@synthesize mSeverityTableArray_;
@synthesize mShowDeleteButtonOnImageView_;

@synthesize mBorderView_;
@synthesize mDamageTypesTableView_;
@synthesize mSeverityTypesTableView_;
@synthesize mTextView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];

    }
    return self;
}

#pragma mark --
#pragma mark ViewLifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Initialize the objects.
    [self initializationOfObjectsForBuildInspectionDetailsView];
    // Set fonts/text for Labels/TextFields...
    [self setFontsAndTextToBuildInspectionDetailsView];
    // Set Borders/Colors for view.
    [self setBorderAndColorsForBuildInspectionDetailsView];
}

// GeneralSettingsViewController
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.superview.bounds = CGRectMake(0, 0, 543, 334);
}

#pragma mark --
#pragma mark Memory Management Methods
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark Orientations Methods
/*- (BOOL)shouldAutorotate // iOS 6/7 autorotation fix
{
    if([[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeLeft ||[[UIDevice currentDevice] orientation] == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
    else {
        return NO;
    }
}

- (NSUInteger)supportedInterfaceOrientations // iOS 6/7 autorotation fix
{
    //	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
    return UIInterfaceOrientationMaskLandscape;
}*/

#pragma mark --
#pragma mark Public Methods
- (void)setBuildInspectionDetailsViewForPostRequestDamageID :(NSString *)ID VehicleDamageDetailTypeID :(NSString *)aVehicleDamageDetailTypeID VehicleDamageSeverityID :(NSString *)aVehicleDamageSeverityID Notes:(NSString *)aNotes ImageURL:(NSString *)aImageURL{
    [self.mDeleteButton_ setHidden:FALSE];
    [self.mTextView_ setTextColor:[UIColor blackColor]];
    mAppDelegate_.mModelForWalkAround_.mDamageTypeIndex_ = [aVehicleDamageDetailTypeID intValue];
    mAppDelegate_.mModelForWalkAround_.mSeverityTypeIndex_ = [aVehicleDamageSeverityID intValue];
    mAppDelegate_.mModelForWalkAround_.mNotesString_ = aNotes;
    [self.mTextView_ setText:aNotes];
    
    [self.mDamageTypesTableView_ selectRowAtIndexPath:[NSIndexPath indexPathForItem:mAppDelegate_.mModelForWalkAround_.mDamageTypeIndex_-1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.mSeverityTypesTableView_ selectRowAtIndexPath:[NSIndexPath indexPathForItem:(int)mAppDelegate_.mModelForWalkAround_.mSeverityTypeIndex_-1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    if ([aImageURL length] != 0) {
        [self.mAddPhotoButton_ setHidden:YES];
//        [self.mUpdateAddPhotoImageButton_ setHidden:FALSE];
        [self setMShowDeleteButtonOnImageView_:self];
        [self.mUpdateAddPhotoImageButton_ setTag:1];
        self.mImageView_.mUIImageViewDispatchLoader_ = IsBuildInspectionPopup;
        self.mImageView_.activityView = nil;
        [self.mImageView_ setCustomImageURL:[NSURL URLWithString:aImageURL]];
    }else {
        [self.mAddPhotoButton_ setHidden:NO];
        [self.mUpdateAddPhotoImageButton_ setHidden:TRUE];
    }
    
    
    
}

#pragma mark --
#pragma mark Private Methods
- (void)initializationOfObjectsForBuildInspectionDetailsView {
    //Initialize the singletom class (AppDelegate).
    [self.navigationController setNavigationBarHidden:YES];
    //static Damage types.
    mDamageTableArray_ = [[NSMutableArray alloc] initWithObjects:[NSLocalizedString(@"VEHICLE_DAMAGE_ARRAY", nil) componentsSeparatedByString:@","],nil];
    //static Severity types.
    mSeverityTableArray_ = [[NSMutableArray alloc] initWithObjects:[NSLocalizedString(@"VEHICLE_SEVERITY_ARRAY", @"") componentsSeparatedByString:@","],nil];
    //Hide the empty separaters for the Damage TableView.
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self.mDamageTypesTableView_];
    //Hide the empty separaters for the Severity TableView.
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self.mSeverityTypesTableView_];
    
    [self.mDamageTypesTableView_ setRowHeight:35];
    [self.mSeverityTypesTableView_ setRowHeight:54];
    [self.mSeverityTypesTableView_ setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mSeverityTypesTableView_ setScrollEnabled:FALSE];
    if (IOS_NEWER_OR_EQUAL_TO_7) {
        if ([self.mDamageTypesTableView_ respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.mDamageTypesTableView_ setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    if (IOS_NEWER_OR_EQUAL_TO_7) {
        if ([self.mSeverityTypesTableView_ respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.mSeverityTypesTableView_ setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    if (self.mImageView_.image != nil) {
        [self.mAddPhotoButton_ setHidden:TRUE];
        [self.mUpdateAddPhotoImageButton_ setHidden:FALSE];
    }else {
        [self.mAddPhotoButton_ setHidden:FALSE];
        [self.mUpdateAddPhotoImageButton_ setHidden:TRUE];
    }
}

- (void)setFontsAndTextToBuildInspectionDetailsView {
    [mAppDelegate_.mModelForWalkAround_ setMNotesString_:NSLocalizedString(@"VEHICLE_TAP_TO_INPUT_DETAILS", nil)];
    [self.mTextView_ setText:mAppDelegate_.mModelForWalkAround_.mNotesString_];
    [self.mTextView_ setTextColor:[UIColor grayColor]];
}

- (void)setBorderAndColorsForBuildInspectionDetailsView {
    
    [self.mBorderView_.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.mBorderView_.layer setBorderWidth:1];
    
    CALayer *bottomBorderForHeadingView = [CALayer layer];
    bottomBorderForHeadingView.borderColor = [UIColor lightGrayColor].CGColor;
    bottomBorderForHeadingView.borderWidth = 1;
    bottomBorderForHeadingView.frame = CGRectMake(self.view.frame.origin.x, 45, self.view.frame.size.width, 1);
    [self.view.layer addSublayer:bottomBorderForHeadingView];
    
    CALayer *rightBorderForDamageTableView = [CALayer layer];
    rightBorderForDamageTableView.borderColor = [UIColor lightGrayColor].CGColor;
    rightBorderForDamageTableView.borderWidth = 1;
    rightBorderForDamageTableView.frame = CGRectMake(self.mDamageTypesTableView_.frame.size.width+self.mBorderView_.frame.origin.x, self.mBorderView_.frame.origin.y, 1, self.mBorderView_.frame.size.height);
    [self.view.layer addSublayer:rightBorderForDamageTableView];
    
    CALayer *rightBorderForSeverityTableView = [CALayer layer];
    rightBorderForSeverityTableView.borderColor = [UIColor lightGrayColor].CGColor;
    rightBorderForSeverityTableView.borderWidth = 1;
    rightBorderForSeverityTableView.frame = CGRectMake(self.mSeverityTypesTableView_.frame.size.width+self.mSeverityTypesTableView_.frame.origin.x+20, self.mBorderView_.frame.origin.y, 1, self.mBorderView_.frame.size.height);
    [self.view.layer addSublayer:rightBorderForSeverityTableView];
    
    
    CALayer *bottomBorderForTextView = [CALayer layer];
    bottomBorderForTextView.borderColor = [UIColor lightGrayColor].CGColor;
    bottomBorderForTextView.borderWidth = 1;
    bottomBorderForTextView.frame = CGRectMake(self.mTextView_.frame.origin.x, self.mTextView_.frame.origin.y + self.mTextView_.frame.size.height, self.mTextView_.frame.size.width, 1.5);
    [self.view.layer addSublayer:bottomBorderForTextView];
    
}

-(void)showActionSheet {
    //    UIActionSheet *lActionSheet = [[UIActionSheet alloc] initWithFrame:CGRectMake(0, 500, 1024, 300)];
    UIActionSheet *lActionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                              delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
                                                     otherButtonTitles:NSLocalizedString(@"lTakePhoto_iPad", @"lTakePhoto_iPad"), NSLocalizedString(@"lChooseExistingPhoto_iPad", @"lChooseExistingPhoto_iPad"),NSLocalizedString(@"lCancelPhoto_iPad", @"lCancelPhoto_iPad"),nil];
    lActionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    [lActionSheet setTag:1001];
    [lActionSheet setFrame:CGRectMake(0, 500, 1024, 300)];
    //    [lActionSheet showInView:self];
    [lActionSheet showFromRect: self.mAddPhotoButton_.frame inView: self.mAddPhotoButton_.superview animated: YES];
}

#pragma mark --
#pragma mark Button Action Methods
- (IBAction)addphotoButtonAction:(id)sender {
    [self showActionSheet];
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self cleanup:@"Clean Up Data For BuildInspectionDetails"];
}

- (IBAction)saveButtonAction:(id)sender {
    [self.mTextView_ endEditing:YES];
    DLog(@"%d",mAppDelegate_.mModelForWalkAround_.mSeverityTypeIndex_);
    DLog(@"%d",mAppDelegate_.mModelForWalkAround_.mDamageTypeIndex_);
    //----- CHECKING IF DANAGE & SEVERITY TYPE ARE EMPTY, IF EMPTY SHOW ALERT -----
    if (mAppDelegate_.mModelForWalkAround_.mSeverityTypeIndex_ == NSNotFound || mAppDelegate_.mModelForWalkAround_.mDamageTypeIndex_ == NSNotFound) {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:@"Alert" message:@"Please select Damage and Severity details from list"];
        return;
    }
    
    if ([[WalkAroundSupportWebEngine walkAroundSharedInstance] mVehicleDiagramRequest_] == VehicleDiagramDELETEImageRequest) {
        [[WalkAroundSupportWebEngine walkAroundSharedInstance] setMVehicleDiagramRequest_:VehicleDiagramPUTRequest];
    }
    
    //----- POST REQUEST METHOD FOR WALK-AROUND DETIALS -----
    if ([[WalkAroundSupportWebEngine walkAroundSharedInstance] mVehicleDiagramRequest_] == VehicleDiagramPOSTRequest) {
        [[WalkAroundSupportWebEngine walkAroundSharedInstance] postRequestForDamageDetails];
    }else {
        [[WalkAroundSupportWebEngine walkAroundSharedInstance] putRequestForDamageDetails];
    }
    mAppDelegate_.mOnSuccessDelegate_ = self;
}

- (IBAction)deleteButtonAction:(id)sender {
    [[WalkAroundSupportWebEngine walkAroundSharedInstance] setMVehicleDiagramRequest_: 0];
    [[WalkAroundSupportWebEngine walkAroundSharedInstance] deleteRequestForDamageDetails];
    mAppDelegate_.mOnSuccessDelegate_ = self;
}

- (IBAction)updateAddPhotoButtonAction:(id)sender {
    if (self.mUpdateAddPhotoImageButton_.tag) {
        self.mImageView_.image = nil;
        [self.mAddPhotoButton_ setHidden:FALSE];
        [self.mUpdateAddPhotoImageButton_ setHidden:TRUE];
        [[WalkAroundSupportWebEngine walkAroundSharedInstance] setMVehicleDiagramRequest_:VehicleDiagramDELETEImageRequest];
        [[WalkAroundSupportWebEngine walkAroundSharedInstance] deleteRequestForDamageDetailsImage];
        mAppDelegate_.mOnSuccessDelegate_ = self;
    }else {
        mAppDelegate_.mModelForWalkAround_.mImageData_ = nil;
        self.mImageView_.image = nil;
        [self.mAddPhotoButton_ setHidden:FALSE];
        [self.mUpdateAddPhotoImageButton_ setHidden:TRUE];
    }
}

#pragma mark --
#pragma mark TextView Delegate Methods
-(void) textViewDidBeginEditing:(UITextView *)textView {
    if ([self.mTextView_.text isEqualToString:NSLocalizedString(@"VEHICLE_TAP_TO_INPUT_DETAILS", nil)]) {
        [self.mTextView_ setText:@""];
        [self.mTextView_ setTextColor:[UIColor blackColor]];
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    
    self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, 0);
    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    //----- SET NOTES TEXT -----
    [mAppDelegate_.mModelForWalkAround_ setMNotesString_:textView.text];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    
    self.view.transform = CGAffineTransformTranslate(self.view.transform, 0, 0);
    [UIView commitAnimations];
    [self.mTextView_ setContentOffset:CGPointZero];
    [self.mTextView_ resignFirstResponder];
}

-(BOOL)textView :(UITextView *)textView shouldChangeTextInRange :(NSRange)range
                                                replacementText :(NSString *)text {
    if ([self.mTextView_.text isEqualToString:NSLocalizedString(@"VEHICLE_TAP_TO_INPUT_DETAILS", nil)]) {
        [self.mTextView_ setText:@""];
        [self.mTextView_ setTextColor:[UIColor blackColor]];
    }else {
        DLog(@"TextView Text %@",textView.text);
        [mAppDelegate_.mModelForWalkAround_ setMNotesString_:textView.text];
    }
    return YES;
}

#pragma mark --
#pragma mark ActionSheet Delegate Methods
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
        self.mPopoverController_ = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self.mPopoverController_ presentPopoverFromRect:self.mAddPhotoButton_.frame
                                                     inView:self.mAddPhotoButton_.superview
                                   permittedArrowDirections:UIPopoverArrowDirectionUp
                                                   animated:YES];            }];
            
        }
        else{
            
            [mPopoverController_ presentPopoverFromRect:self.mAddPhotoButton_.frame
                                                 inView:self.mAddPhotoButton_.superview
                               permittedArrowDirections:UIPopoverArrowDirectionUp
                                               animated:YES];        }
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
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self presentViewController:self.mUIImagePickerController_ animated:YES completion:nil];
            }];
            
        }
        else{
            [self presentViewController:self.mUIImagePickerController_ animated:YES completion:nil];
        }
    }

        //This method inherit from UIView,show imagePicker with animation
//        [self presentViewController:self.mUIImagePickerController_ animated:YES completion:nil];
//    }
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
    [mPopoverController_ dismissPopoverAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [[picker parentViewController] dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *newImageWithLessResolution = [self imageWithImage:image scaledToSize:CGSizeMake(KImageViewWidth, KImageViewHeight)];
    NSData* pictureData = UIImageJPEGRepresentation(newImageWithLessResolution, 1.00f);
    mAppDelegate_.mModelForWalkAround_.mImageData_ = pictureData;
    if (image != nil) {
        [self.mImageView_ setImage:image];
        [self.mAddPhotoButton_ setHidden:TRUE];
        [self.mUpdateAddPhotoImageButton_ setHidden:FALSE];
        [self.mUpdateAddPhotoImageButton_ setTag:0];
    }else {
        [self.mAddPhotoButton_ setHidden:FALSE];
        [self.mUpdateAddPhotoImageButton_ setHidden:TRUE];
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

// ************ This  method is used to rescale the images to fit in the image view fixed to imageview height 150 ************ //
- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    
    if([image size].height > KImageViewHeight) {
        newSize.height = KImageViewHeight;
        newSize.width = KImageViewHeight * [image size].width/([image size].height);
    }else {
        newSize.width = image.size.width;
        newSize.height = image.size.height;
    }
    UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    NSData* pictureData = UIImageJPEGRepresentation(newImage, 1.00f);
    return newImage;
	
}

#pragma mark --
#pragma mark TableView Delegate and DataSource Methods

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.mDamageTypesTableView_) {
        NSMutableArray* lTempArray=[self.mDamageTableArray_ objectAtIndex:0];

        return [lTempArray count];
    } else if (tableView == self.mSeverityTypesTableView_){
        NSMutableArray* lTempArray=[[self mSeverityTableArray_] objectAtIndex:0];

        return [lTempArray count];
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
	
	if (nil==cell)
	{
		cell = [[UITableViewCell alloc]  initWithFrame:CGRectMake(0,0,0,0)];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
		//Configure cell format for the tableView,
 	    //Same format for all the three sections.
		int tagCount = 1;
        //		for (tagCount = 1; tagCount <= 1; tagCount++) {
        UILabel *lUILabel = [[UILabel alloc]init];
      
        lUILabel.backgroundColor = [UIColor clearColor];
        lUILabel.textColor = [UIColor blackColor];
        lUILabel.highlightedTextColor = [UIColor whiteColor];
        lUILabel.font = [UIFont fontWithName:kFontNameHelveticaNeueKey size:14];
        [cell.contentView addSubview:lUILabel];
        [lUILabel setTag:tagCount];
        
        UIImageView *lUIImageView = [[UIImageView alloc]init];
       
        [lUIImageView setTag:tagCount + 1];
        [cell.contentView addSubview:lUIImageView];
        //        cell.accessoryView=lUIImageView;
        
        RELEASE_NIL(lUIImageView);
        if (tableView == mDamageTypesTableView_) {
            UIView *lSelectedView_ = [[UIView alloc] init];
            lSelectedView_.backgroundColor = [UIColor ASRProBlueColor];
            cell.selectedBackgroundView = lSelectedView_;
        }else {
            UIView *lSelectedView_ = [[UIView alloc] init];
            lSelectedView_.backgroundColor = [UIColor whiteColor];
            cell.selectedBackgroundView = lSelectedView_;
        }
       
	}
	//cell.accessoryType=UITableViewCellAccessoryNone;
	[self resetTableViews:cell];
	[self populateFormsSectionWithIndexPath:indexPath cell:cell tableView:tableView];
	return cell;
}

- (void)resetTableViews:(UITableViewCell*)tableViewCell {
	int tagCount=1;
    //reset uilabels
	for (; tagCount<=2; tagCount++) {
        if (tagCount==2) {
            UIImageView *lUIImageView = (UIImageView *)[tableViewCell viewWithTag:tagCount];
            lUIImageView.image=nil;
        } else{
            UILabel *lUILabel=(UILabel*)[tableViewCell viewWithTag:tagCount];
            lUILabel.text=nil;
        }
	}
}

- (void)populateFormsSectionWithIndexPath:(NSIndexPath*)indexPath
									 cell:(UITableViewCell*)tableViewCell
								tableView:(UITableView*)tabelView {
    //getting instances and assign the text
    CGFloat lXCoord = 10,lYCoord = 7,lWidth = 100/*,lHeight = 18*/;
    
    if (tabelView == self.mDamageTypesTableView_) {
        UILabel *lDamageLabel_ = (UILabel*)[tableViewCell.contentView viewWithTag:1];
        lDamageLabel_.frame = CGRectMake(lXCoord+10, 0, lWidth, 34);
        lDamageLabel_.text= [NSString stringWithFormat:@"%@",[[mDamageTableArray_ objectAtIndex:0] objectAtIndex:indexPath.row]];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Default.png",[[mDamageTableArray_ objectAtIndex:0] objectAtIndex:indexPath.row]]];
        UIImageView *lImageView_ = (UIImageView*)[tableViewCell viewWithTag:2];
         lImageView_.frame = CGRectMake(lXCoord + 100, 2, image.size.width, image.size.height);
        [lImageView_ setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_Default.png",[[mDamageTableArray_ objectAtIndex:0] objectAtIndex:indexPath.row]]]];
        [lImageView_ setHighlightedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_active.png",[[mDamageTableArray_ objectAtIndex:0] objectAtIndex:indexPath.row]]]];
        DLog(@"Damage Name Default %@",[NSString stringWithFormat:@"%@_Default.png",[[mDamageTableArray_ objectAtIndex:0] objectAtIndex:indexPath.row]]);
        DLog(@"Damage Name active %@",[NSString stringWithFormat:@"%@_active.png",[[mDamageTableArray_ objectAtIndex:0] objectAtIndex:indexPath.row]]);

    } else if (tabelView == self.mSeverityTypesTableView_) {
        
        UILabel *lSeverityLabel_ = (UILabel*)[tableViewCell.contentView viewWithTag:1];
        lSeverityLabel_.text = [NSString stringWithFormat:@"%@",[[mSeverityTableArray_ objectAtIndex:0] objectAtIndex:indexPath.row]];
        lSeverityLabel_.frame = CGRectMake(20 + 20, 0, lWidth, 44);
        lSeverityLabel_.textColor = [UIColor blackColor];
        lSeverityLabel_.highlightedTextColor = [UIColor blackColor];
        
        UIImageView *lSeverityImageView_ = (UIImageView*)[tableViewCell viewWithTag:2];
        lSeverityImageView_.frame = CGRectMake(lXCoord , lYCoord + 5, 20, 20);
        [lSeverityImageView_ setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[[mSeverityTableArray_ objectAtIndex:0] objectAtIndex:indexPath.row]]]];
        [lSeverityImageView_ setHighlightedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@Selected.png",[[mSeverityTableArray_ objectAtIndex:0] objectAtIndex:indexPath.row]]]];

       
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.mDamageTypesTableView_) {
        mAppDelegate_.mModelForWalkAround_.mDamageTypeString_ = [NSString stringWithFormat:@"%@",[[mDamageTableArray_ objectAtIndex:0] objectAtIndex:[[self.mDamageTypesTableView_ indexPathForSelectedRow]row]]];
        mAppDelegate_.mModelForWalkAround_.mDamageTypeIndex_  = [[self.mDamageTypesTableView_ indexPathForSelectedRow]row] + 1;
    } else if (tableView == self.mSeverityTypesTableView_) {
        mAppDelegate_.mModelForWalkAround_.mSeverityString_ = [NSString stringWithFormat:@"%@",[[mSeverityTableArray_ objectAtIndex:0] objectAtIndex:[[self.mSeverityTypesTableView_ indexPathForSelectedRow]row]]];
        mAppDelegate_.mModelForWalkAround_.mSeverityTypeIndex_  = [[self.mSeverityTypesTableView_ indexPathForSelectedRow]row] + 1;
    }
}

#pragma mark --
#pragma mark Protocol Methods
-(void)OnsuccessResponseForRequest {
    if ([[WalkAroundSupportWebEngine walkAroundSharedInstance] mVehicleDiagramRequest_] == VehicleDiagramDELETEImageRequest) {
        [mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_ removeButtonFromImageView];
        [[[mAppDelegate_ mWalkAroundViewController_] mVehicleDiagramsImageView_] getVehicleDamagePointsOnTheImageViewIndex:mAppDelegate_.mModelForWalkAround_.mVehicleDiagramViewAngleID_ VehicleDiagramSetID:mAppDelegate_.mModelForWalkAround_.mVehicleDiagramForDamagesSetID_];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self cleanup:@"Clean Up Data For BuildInspectionDetails"];
        [mAppDelegate_.mWalkAroundViewController_.mVehicleDiagramsImageView_ removeButtonFromImageView];
        DLog(@"%@",[[mAppDelegate_ mWalkAroundViewController_] mVehicleDiagramsImageView_]);
        [[[mAppDelegate_ mWalkAroundViewController_] mVehicleDiagramsImageView_] getVehicleDamagePointsOnTheImageViewIndex:mAppDelegate_.mModelForWalkAround_.mVehicleDiagramViewAngleID_ VehicleDiagramSetID:mAppDelegate_.mModelForWalkAround_.mVehicleDiagramForDamagesSetID_];
    }
}

- (void)showDeleteButtonOnBuildInspectionDetailsImageView {
    [self.mUpdateAddPhotoImageButton_ setHidden:FALSE];
    
}

- (void) cleanup: (NSString *) output
{
	DLog(@"%@",output);
    mAppDelegate_.mModelForWalkAround_.mDamageTypeIndex_ = NSNotFound;
    mAppDelegate_.mModelForWalkAround_.mSeverityTypeIndex_ = NSNotFound;
    mAppDelegate_.mModelForWalkAround_.mNotesString_ = @"";
    mAppDelegate_.mModelForWalkAround_.mImageData_ = nil;
}

@end
