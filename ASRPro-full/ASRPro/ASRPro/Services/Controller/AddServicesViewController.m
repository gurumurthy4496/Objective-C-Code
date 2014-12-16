//
//  AddServicesViewController.m
//  ASRPro
//
//  Created by Kalyani on 07/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "AddServicesViewController.h"

#define kADDLABEL @"Add Service"
#define kEDITLABEL @"Edit Service"
#define kSAVEBUTTON @"Save"
#define kCANCELBUTTON @"Cancel"

@interface AddServicesViewController ()

@end

@implementation AddServicesViewController
@synthesize mCancelButton;
@synthesize mHeadingLabel_;
@synthesize mSaveButton_;
@synthesize mAddServiceTableViewController_;
@synthesize mGetServiceReference_;

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
    // Do any additional setup after loading the view from its nib.
  //  self.title =@"Add Services";
    [self initTheViews];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    self.view.superview.bounds = CGRectMake(0, 0, 600,530);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTheViews{
//    self.navigationController.navigationBar.topItem.title = kADDLABEL;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kCANCELBUTTON style:UIBarButtonItemStyleBordered target:self action:@selector(CancelButtonAction:)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kSAVEBUTTON style:UIBarButtonItemStyleDone target:self action:@selector(saveButtonAction:)];
  //  self.navigationController.navigationBarHidden = NO;
    [self.mHeadingLabel_ setText:[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mModelForSelectedService_->isAdd_? kADDLABEL:@"Edit Service"];
   [self.mSaveButton_ setTitle:kSAVEBUTTON forState:UIControlStateNormal];
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:self.mSaveButton_ buttonTitle:kSAVEBUTTON buttonTitleColor:[UIColor colorWithRed:(11.0/255.0) green:(95.0/255.0) blue:(225.0/255.0) alpha:1.0] buttonTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey ] buttonTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttonImage:nil buttonImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10) controlState:UIControlStateDisabled buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundColor:[UIColor colorWithRed:(210.0/255.0) green:(210.0/255.0) blue:(210.0/255.0) alpha:1.0]];

//    [self.mCancelButton setTitle:kCANCELBUTTON forState:UIControlStateNormal];
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:mCancelButton buttonTitle:kCANCELBUTTON buttonTitleColor:[UIColor colorWithRed:(11.0/255.0) green:(95.0/255.0) blue:(252.0/255.0) alpha:1.0] buttonTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey ] buttonTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttonImage:nil buttonImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10) controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:mCancelButton buttonTitle:@"Back" buttonTitleColor:[UIColor colorWithRed:(11.0/255.0) green:(95.0/255.0) blue:(252.0/255.0) alpha:1.0] buttonTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey ] buttonTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)  buttonImage:[UIImage imageNamed:@"back-arrow.png"] buttonImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0) controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0,0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor clearColor]];

    AddServiceTableViewController* lAddServiceTableViewController=[AddServiceTableViewController new];
    [lAddServiceTableViewController.view setFrame:CGRectMake(0, 45, 600, 486)];
    [self setMAddServiceTableViewController_:lAddServiceTableViewController];
    [self.view addSubview:mAddServiceTableViewController_.view];
    
    ServicesListMainViewController* lServicesListTableViewController_=[ServicesListMainViewController new];
    [lServicesListTableViewController_.view setFrame:CGRectMake(0, 45, 600, 486)];
    [self setMServicesListTableViewController_:lServicesListTableViewController_];
    [self.view addSubview:self.mServicesListTableViewController_.view];
    [self.mServicesListTableViewController_.view setHidden:TRUE];
    [self.mAddServiceTableViewController_.view setHidden:FALSE];
    [mCancelButton setSelected:FALSE];
    [self.mSaveButton_ setEnabled:![[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mModelForSelectedService_->isAdd_];
    if([[[[[[SharedUtilities sharedUtilities]appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceName_] isEqualToString:@""]){
        [self pushToServicesListTableViewController];
    }
}

- (IBAction)CancelButtonAction:(id)sender {
    if(mCancelButton.isSelected)
       [self pushtoAddServicesTable];
    else
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonAction:(id)sender {
    if((mGetServiceReference_==OPENROSERVICESVIEWCONTROLLER)||(mGetServiceReference_==FINISHINSPECTIONVIEWCONTROLLER))
    [self.mAddServiceTableViewController_ saveOpenROdata];
    else
        [self.mAddServiceTableViewController_ saveData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)pushToServicesListTableViewController{
    
    [self.mServicesListTableViewController_.view setHidden:FALSE];
    [self.mAddServiceTableViewController_.view setHidden:TRUE];
    [mSaveButton_ setHidden:TRUE];
    [mCancelButton setSelected:TRUE];

    [self.mServicesListTableViewController_.mSearhBar_ setText:@""];
    self.mServicesListTableViewController_.mSearchedDataArray=[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mAllServicesArray_;
    [self.mServicesListTableViewController_.mTableView reloadData];

}

-(void)pushtoAddServicesTable{
    [self.mServicesListTableViewController_.view setHidden:TRUE];
    [self.mAddServiceTableViewController_.view setHidden:FALSE];
    [mSaveButton_ setHidden:FALSE];

    [mCancelButton setSelected:FALSE];
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

@end
