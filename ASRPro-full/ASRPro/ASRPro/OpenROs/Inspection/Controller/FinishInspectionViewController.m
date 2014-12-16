//
//  FinishInspectionViewController.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "FinishInspectionViewController.h"

#import "ModelForFinishInspectionFromView.h"
#import "AddServicePopupViewController.h"

@interface FinishInspectionViewController ()
@property(nonatomic,retain)AddServicePopupViewController* mAddServicePopupViewController_;
@property(nonatomic,retain)NSMutableArray* mSGIDsArray;

@end

@implementation FinishInspectionViewController
@synthesize mButonItemsScrollView_;
@synthesize mFinishInspectionButton_;
@synthesize mFormView_;
@synthesize mRODetailsView_;
@synthesize mSliderItemsScrollView_;
@synthesize mInspectionFormPopupViewController_;
@synthesize mSaveFormButton_;
@synthesize mAddServicePopupViewController_;
@synthesize mSGIDsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  [self initheViews];
   [self setFontToViews];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [mAppDelegate_.mModelForNotifications_ checkTheNotifiationBadgeCount:self.view];
    // ----------------------------;
    // ADD LeftView to ECS_Sliding -> WalkAroundLeftSlider;
    // ----------------------------;
    [self.view addGestureRecognizer:mAppDelegate_.mECSlidingViewController_.panGesture];
    [mAppDelegate_.mECSlidingViewController_ setAnchorRightRevealAmount:340.0f];
    if (mAppDelegate_.mWalkAroundLeftViewController_ == nil) {
        WalkAroundLeftViewController *lViewControler = [[WalkAroundLeftViewController alloc] init];
        [mAppDelegate_ setMWalkAroundLeftViewController_:lViewControler];
        [mAppDelegate_.mWalkAroundLeftViewController_.view setBackgroundColor:[UIColor ASRProRGBColor:66 Green:66 Blue:68]];
    }
    if (![mAppDelegate_.mECSlidingViewController_.underLeftViewController isKindOfClass:[WalkAroundLeftViewController class]]) {
        mAppDelegate_.mECSlidingViewController_.underLeftViewController  = mAppDelegate_.mWalkAroundLeftViewController_;
    }
}

-(void)initheViews{
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self.view customHeaderViewFull:self SelectedButton:@"Services"];
    [mAppDelegate_.mOpenROInspectionDataGetter_ setTopNavigationBarHiddenForOpenROScreen:self.view Hidden:YES Button:nil];

}

-(void)setFontToViews{
    [[GenericFiles genericFiles] createUIButtonInstance:mFinishInspectionButton_ buttonTitle:@"Finish Inspection" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(6.0/255.0) green:(160.0/255.0) blue:(74.0/255.0) alpha:1.0]]];
    [[GenericFiles genericFiles] createUIButtonInstance:mSaveFormButton_ buttonTitle:@"Save Form" buttonTitleColor:[UIColor whiteColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:(231.0/255.0) green:(126.0/255.0) blue:(34.0/255.0) alpha:1.0]]];

    [self.mFormView_.layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
    [self.mFormView_ .layer setBorderWidth:2.0];
    [self.mRODetailsView_.layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
    [self.mRODetailsView_ .layer setBorderWidth:2.0];

    [self.mSliderItemsScrollView_.layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
    [self.mSliderItemsScrollView_ .layer setBorderWidth:2.0];

    [self.mButonItemsScrollView_.layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
    [self.mButonItemsScrollView_.layer setBorderWidth:2.0];
    
      mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormsArray_=[[FileUtils fileUtils] loadArrayFromFile:kINSPECTIONFORMSLISTPATH];
    
    mInspectionFormPopupViewController_=[[InspectionFormPopupViewController alloc]initWithNibName:@"InspectionFormPopupViewController" bundle:nil ];
    [mInspectionFormPopupViewController_.view setFrame:CGRectMake(5, 98, 300, 31)];
    [self.view addSubview:mInspectionFormPopupViewController_.view];
    [self.view bringSubviewToFront:mInspectionFormPopupViewController_.view];
  //  [self.view bringSubviewToFront:mFormView_];


    [self setTextToLabels];
    [self loadInspectionItems];
    
    
        if (([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"])||([[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_] !=3)) {
            [mFinishInspectionButton_ setEnabled:NO];
        }
    if (([[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_] ==7)||([[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_]  ==6)||([[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_]  ==4)) {
        
        [self.mInspectionFormPopupViewController_.mDropDown_ setEnabled:NO];
    }
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    gestureRecognizer.cancelsTouchesInView = NO;
}
-(void)hideKeyboard:(UIGestureRecognizer*)tapGestureRecognizer
{
    if (!CGRectContainsPoint([self.mInspectionFormPopupViewController_.mDropDownTable_ cellForRowAtIndexPath:[self.mInspectionFormPopupViewController_.mDropDownTable_ indexPathForSelectedRow]].frame, [tapGestureRecognizer locationInView:self.mInspectionFormPopupViewController_.mDropDownTable_]))
    {
    [mInspectionFormPopupViewController_ hideInspectionForm];
    }
}

-(void)setTextToLabels{
    NSArray *ltempCustHeadingArr = [KINSPECTIONHEADINGS componentsSeparatedByString:@","];
    [self.mRODetailsView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UILabel class]]) {
            UILabel *lLabel = (UILabel*)object;
            switch (lLabel.tag) {
                case 0:{
                    [[GenericFiles genericFiles] createUILabelWithInstance:lLabel labelTitleFont:[UIFont regularFontOfSize:18 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@ #%@",[ltempCustHeadingArr objectAtIndex:0], mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_] labelTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor whiteColor ]];
                    break;
                }
                case 1:{
                    [[GenericFiles genericFiles] createUILabelWithInstance:lLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@ #%@",[ltempCustHeadingArr objectAtIndex:1], mAppDelegate_.mModelForEditVehicleScreen_.mRegistrationNo_] labelTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor whiteColor ]];
                    break;
                }

                case 2:{
                    [[GenericFiles genericFiles] createUILabelWithInstance:lLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@: %@",[ltempCustHeadingArr objectAtIndex:2], mAppDelegate_.mModelForEditVehicleScreen_.mVIN_] labelTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor whiteColor ]];
                    break;
                }

                case 3:{
                    [[GenericFiles genericFiles] createUILabelWithInstance:lLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@: %@ %@",[ltempCustHeadingArr objectAtIndex:3], mAppDelegate_.mModelForEditCustomerScreen_.mFirstName_,mAppDelegate_.mModelForEditCustomerScreen_.mLastName_] labelTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor whiteColor ]];
                    break;
                }

                case 4:{
                    [[GenericFiles genericFiles] createUILabelWithInstance:lLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@: %@",[ltempCustHeadingArr objectAtIndex:4], mAppDelegate_.mModelForEditVehicleScreen_.mYear_] labelTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor whiteColor ]];
                    break;
                }

                case 5:{
                    [[GenericFiles genericFiles] createUILabelWithInstance:lLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@: %@",[ltempCustHeadingArr objectAtIndex:5], mAppDelegate_.mModelForEditVehicleScreen_.mMake_] labelTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor whiteColor ]];
                    break;
                }

                case 6:{
                    [[GenericFiles genericFiles] createUILabelWithInstance:lLabel labelTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@: %@",[ltempCustHeadingArr objectAtIndex:6], mAppDelegate_.mModelForEditVehicleScreen_.mModel_] labelTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor whiteColor ]];
                    break;
                }


                default:
                    break;
            }
        }
        }];
}


-(void)loadInspectionItems{
    int m=0;
    int n=0;
    [mInspectionFormPopupViewController_.mDropDown_ setTitle:[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_ objectForKey:@"Name"] forState:UIControlStateNormal];
    [mAppDelegate_.mModelForCheckIn_.mInspectionAllItemsArray_ removeAllObjects];
    DLog(@"%@",mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_ );
    
    ModelForFinishInspectionFromView* lModelForFinishInspectionFromView=[[ModelForFinishInspectionFromView alloc] init];
    NSMutableArray* lTempArray=[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_ objectForKey:@"Categories"];
    for(int i=0;i<[lTempArray count];i++){
        if([[[lTempArray objectAtIndex:i] objectForKey:@"Active"] boolValue]){
        //adding category to view
        m=0;
        n=0;
        NSMutableArray* lTempArray1=[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_  objectForKey:@"Categories"] objectAtIndex:i] objectForKey:@"Items"];
        for(int j=0;j<[lTempArray1 count];j++){
                NSMutableDictionary* lItemDict=[[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_  objectForKey:@"Categories"] objectAtIndex:i] objectForKey:@"Items"] objectAtIndex:j];
                [mAppDelegate_.mModelForCheckIn_.mInspectionAllItemsArray_ addObject:lItemDict];
                if(([[lItemDict objectForKey:@"ItemTypeID"] intValue]==0)&&(m==0)){
                    [self.mButonItemsScrollView_ addSubview:[lModelForFinishInspectionFromView addCategoryView:[NSString  stringWithFormat:@"%@",[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_ objectForKey:@"Categories"] objectAtIndex:i] objectForKey:@"Name"]] isTires:FALSE]];
                    m=1;
                }
                if(([[lItemDict objectForKey:@"ItemTypeID"] intValue]!=0)&&(n==0)){
                    [self.mSliderItemsScrollView_ addSubview:[lModelForFinishInspectionFromView addCategoryView:[NSString  stringWithFormat:@"%@",[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_ objectForKey:@"Categories"] objectAtIndex:i] objectForKey:@"Name"]] isTires:TRUE]];
                    n=1;
                }
                
                int i=[self returnIndexFromItemArray:[lItemDict objectForKey:@"IIID"]];
                NSMutableDictionary* lTempDict=nil;
                if(i!=-1)
                    lTempDict=[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionItemsArray_ objectAtIndex:i];
                if([[lItemDict objectForKey:@"Active"] boolValue]){
                // adding items to view
                switch ([[lItemDict objectForKey:@"ItemTypeID"] intValue]) {
                    case 0:
                    {
                        [self.mButonItemsScrollView_ addSubview:[lModelForFinishInspectionFromView addInspectionButtonView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 1:
                    {
                        [self.mSliderItemsScrollView_ addSubview:[lModelForFinishInspectionFromView addInspectionCheckButtonView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 2:
                    {
                        [self.mSliderItemsScrollView_ addSubview:[lModelForFinishInspectionFromView addInspectionRadioButtonView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 3:
                    {
                        [self.mSliderItemsScrollView_ addSubview:[lModelForFinishInspectionFromView addInspectionSliderView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 4:
                    {
                        [self.mSliderItemsScrollView_ addSubview:[lModelForFinishInspectionFromView addInspectionPickerView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 5:
                    {
                        [self.mSliderItemsScrollView_ addSubview:[lModelForFinishInspectionFromView addInspectionTextView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 6:
                    {
                        [self.mSliderItemsScrollView_ addSubview:[lModelForFinishInspectionFromView addInspectionTextFieldView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    default:
                    {
                        [self.mButonItemsScrollView_ addSubview:[lModelForFinishInspectionFromView addInspectionButtonView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                }
                }
            }
    }
    }
    [mSliderItemsScrollView_ setContentSize:CGSizeMake(684, lModelForFinishInspectionFromView->yTiresPos+30)];
    [mButonItemsScrollView_ setContentSize:CGSizeMake(320, lModelForFinishInspectionFromView->yItemsPos+30)];

    [self setCompleteInspectionButton];

}

-(int)returnIndexFromItemArray:(NSString *)IIID  { // this method is to return the matching index to IIID
    for(int i=0;i<[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionItemsArray_ count];i++){
        if([IIID intValue]==[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionItemsArray_ objectAtIndex:i]objectForKey:@"IIID"] intValue])
            return i;
    }
    return -1;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)FinishInspectionButtonAction_:(id)sender {
    
    [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForCompleteInspection:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_];
}

- (IBAction)SaveFormButtonAction:(id)sender {
    
    if([mInspectionFormPopupViewController_.mDropDown_.mFormDict_ objectForKey:@"ID"]!=nil){
    [mAppDelegate_.mOpenROInspectionDataGetter_ setMInspectionFormID_:[mInspectionFormPopupViewController_.mDropDown_.mFormDict_ objectForKey:@"ID"]];
    [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForchangeInspectionForm:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ requestDict:[[NSDictionary dictionaryWithObjectsAndKeys:[mInspectionFormPopupViewController_.mDropDown_.mFormDict_ objectForKey:@"ID"],@"FormID", nil] mutableCopy]];
    }
}
-(void)reloadInspectionItems{
    for (UIView *subview in [self.mSliderItemsScrollView_ subviews])
    {
        [subview removeFromSuperview];
    }
    for (UIView *subview in [self.mButonItemsScrollView_ subviews])
    {
        [subview removeFromSuperview];
    }
    [self loadInspectionItems];
}

-(void)addServicePopupView:(int)xPos :(int)yPos :(NSMutableArray*)aArray :(int)tag :(int)type{
    [self removeAddServicePopupView];
    AddServicePopupViewController* lAddServicePopupViewController_=[[AddServicePopupViewController alloc] initWithNibName:@"AddServicePopupViewController" bundle:nil];
    [self setMAddServicePopupViewController_:lAddServicePopupViewController_];
    
    [mAddServicePopupViewController_ setMFormtype:MAININSPECTION];
    [mAddServicePopupViewController_.view setFrame:CGRectMake(xPos-39, yPos-47, 108, 47)];
    [self setMSGIDsArray:aArray];
    if(type==0)
        [self.mButonItemsScrollView_ addSubview:mAddServicePopupViewController_.view];
    else
        [self.mSliderItemsScrollView_ addSubview:mAddServicePopupViewController_.view];
    isRequireAttention =(tag==3)?TRUE:FALSE;
}

-(void)removeAddServicePopupView{
    [self.mAddServicePopupViewController_.view removeFromSuperview];
}


-(void)loadServices{
    mAppDelegate_.mServiceDataGetter_.mPayTypesArray_=[[FileUtils fileUtils] loadArrayFromFile:kPAYTYPESPATH];
    if(mAppDelegate_.mServiceDataGetter_.mPayTypesArray_==nil){
        [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForGetPayTypes];
    }
    

    mAppDelegate_.mServiceDataGetter_.mAllServicesArray_=[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPATH];
    if(  mAppDelegate_.mServiceDataGetter_.mAllServicesArray_==nil)
    {
        mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_=FINISHINSPECTIONVIEWCONTROLLER;
        [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForAllServiceLines];
        
    }
    else{
        [[SharedUtilities sharedUtilities] createLoadView];
        [self performSelector:@selector(pushToServicesList) withObject:self afterDelay:0.5];

    }
}

-(NSMutableArray*)getServiceLines{
    NSMutableArray* lServicesArray=[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPATH];
    NSMutableArray* lCurrentArray=[NSMutableArray new] ;
    for(int i=0;i<[mSGIDsArray count];i++)
    {
        for (int j=0; j<[lServicesArray count]; j++) {
            if([[NSString stringWithFormat:@"%@",[[lServicesArray objectAtIndex:j] objectForKey:@"SGID"]] isEqualToString:[NSString stringWithFormat:@"%@",[mSGIDsArray objectAtIndex:i]]])
                [lCurrentArray addObject:[lServicesArray objectAtIndex:j]];
        }
    }
    return lCurrentArray;
}

-(void)pushToServicesList{
    mAppDelegate_.mServiceDataGetter_.mAllServicesArray_=[self getServiceLines];
    AddServicesViewController *lAddServicesViewController = [[AddServicesViewController alloc] initWithNibName:@"AddServicesViewController" bundle:nil];
    [mAppDelegate_.mServiceDataGetter_ setMAddServicesViewController_:lAddServicesViewController];
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ resetAllValues];
    mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mColor_=isRequireAttention?@"Red":@"Yellow";

    [mAppDelegate_.mServiceDataGetter_.mAddServicesViewController_ setMGetServiceReference_:FINISHINSPECTIONVIEWCONTROLLER];
    lAddServicesViewController.modalPresentationStyle=UIModalPresentationFormSheet;
    lAddServicesViewController.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lAddServicesViewController animated:YES completion:nil];
    [[SharedUtilities sharedUtilities] removeLoadView];

}

-(void)setCompleteInspectionButton{
    if ((![[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Advisor"])&&([[[[SharedUtilities sharedUtilities] appDelegateInstance]mModelForVehicleHistoryTableView_]mCurrentMode_] ==3)) {
        isMandatory=TRUE;
    }
    else
        isMandatory=FALSE;
    
    [self.mSliderItemsScrollView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[InspectionFormCheckButtonView class]]) {
            InspectionFormCheckButtonView* lInspectionFormCheckButtonView=(InspectionFormCheckButtonView*)object;
            if((lInspectionFormCheckButtonView->isMandatory)&&!(lInspectionFormCheckButtonView->isAdded))
                isMandatory=FALSE;
            
        }
        else if ([object isKindOfClass:[InspectionFormPickerView class]]) {
            InspectionFormPickerView* lInspectionFormCheckButtonView=(InspectionFormPickerView*)object;
            if((lInspectionFormCheckButtonView->isMandatory)&&!(lInspectionFormCheckButtonView->isAdded))
                isMandatory=FALSE;
            
        }
        else if ([object isKindOfClass:[InspectionFormRadioButtonView class]]) {
            InspectionFormRadioButtonView* lInspectionFormCheckButtonView=(InspectionFormRadioButtonView*)object;
            if((lInspectionFormCheckButtonView->isMandatory)&&!(lInspectionFormCheckButtonView->isAdded))
                isMandatory=FALSE;
            
        }
        else if ([object isKindOfClass:[InspectionFormSliderView class]]) {
            InspectionFormSliderView* lInspectionFormCheckButtonView=(InspectionFormSliderView*)object;
            if((lInspectionFormCheckButtonView->isMandatory)&&!(lInspectionFormCheckButtonView->isAdded))
                isMandatory=FALSE;
            
        }
        else if ([object isKindOfClass:[InspectionFormTextView class]]) {
            InspectionFormTextView* lInspectionFormCheckButtonView=(InspectionFormTextView*)object;
            if((lInspectionFormCheckButtonView->isMandatory)&&!(lInspectionFormCheckButtonView->isAdded))
                isMandatory=FALSE;
            
        }
        else if ([object isKindOfClass:[InspectionFormTextField class]]) {
            InspectionFormTextField* lInspectionFormCheckButtonView=(InspectionFormTextField*)object;
            if((lInspectionFormCheckButtonView->isMandatory)&&!(lInspectionFormCheckButtonView->isAdded))
                isMandatory=FALSE;
            
        }
        else if ([object isKindOfClass:[InspectionFormButtonView class]]) {
            InspectionFormButtonView* lInspectionFormCheckButtonView=(InspectionFormButtonView*)object;
            if((lInspectionFormCheckButtonView->isMandatory)&&!(lInspectionFormCheckButtonView->isAdded))
                isMandatory=FALSE;
            
        }
    }];
    [self.mFinishInspectionButton_ setEnabled:isMandatory];
}

@end
