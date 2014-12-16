//
//  SearchCustomerInfoView.m
//  ASRPro
//
//  Created by Santosh Kvss on 2/13/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "SearchCustomerInfoView.h"

@interface SearchCustomerInfoView ()

@end

@implementation SearchCustomerInfoView
@synthesize mEditButton_;
@synthesize mCustomerInfoView_;

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
    [self setBorderColorForViews];
    [self setHeaderView];
    [self setLabelsForCustomerInfoView];
}

- (void)setBorderColorForViews {

    [self.view.layer setBorderColor:[[UIColor ASRProBlueColor] CGColor]];
    [self.view.layer setBorderWidth:2.0];
}

- (void)setHeaderView {

    UIView *lHeaderView = [UIView new];
    lHeaderView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 35);
    [self setMCustomerInfoView_:lHeaderView];
    [mCustomerInfoView_ setBackgroundColor:[UIColor ASRProBlueColor]];
    UILabel *lTitleLbl_ = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 35)];
    lTitleLbl_.textColor = [UIColor whiteColor];
    [lTitleLbl_ setText:NSLocalizedString(@"Customer_Information", nil)];
    [lTitleLbl_ setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [mCustomerInfoView_ addSubview:lTitleLbl_];
    UIImage *image = [UIImage imageNamed:@"Edit.png"];
    UIButton *lEditBtn_ = [UIButton buttonWithType:UIButtonTypeCustom];
    lEditBtn_.frame = CGRectMake(self.view.frame.size.width-image.size.width - 10, (lHeaderView.frame.size.height - image.size.height)/2, image.size.width, image.size.height);
    [self setMEditButton_:lEditBtn_];
    [mEditButton_ setImage:[UIImage imageNamed:@"Edit.png"] forState:UIControlStateNormal];
    [mEditButton_ addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [mCustomerInfoView_ addSubview:mEditButton_];
    [self.view addSubview:mCustomerInfoView_];
}

- (void)setLabelsForCustomerInfoView {
    
    CGFloat xPos = 15.0, yPos = 55; int lblTag = 50;
    CGFloat XPos = 130.0, YPos = 83;
    NSArray *lCustomerInfoArray = [[NSArray alloc] initWithObjects:@"Home",@"Work",@"Mobile",@"Email",@"Customer No",@"Address", nil];
    for (int i=0; i<=[lCustomerInfoArray count]; i++) {
        
        UILabel *lCustomerInfoLbl = [[UILabel alloc] init];
        lCustomerInfoLbl.tag = i+1;
        lCustomerInfoLbl.font = [UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey];
        [lCustomerInfoLbl setTextColor:[UIColor colorWithRed:26/255.0 green:24/255.0 blue:24/255.0 alpha:1.0]];
        UILabel *lCustomerDetailLbl = [[UILabel alloc] init];
        if (i==0) {
            lCustomerInfoLbl.frame = CGRectMake(xPos, yPos-10, 300, 18);
            lCustomerInfoLbl.text = @"";
        }else {
            lCustomerInfoLbl.frame = CGRectMake(xPos, yPos, 110, 18);
            lCustomerInfoLbl.text = [lCustomerInfoArray objectAtIndex:i-1];
            lCustomerDetailLbl.frame = CGRectMake(XPos, yPos, 400, 18);
            lCustomerDetailLbl.font = [UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey];
            [lCustomerDetailLbl setTextColor:[UIColor colorWithRed:26/255.0 green:24/255.0 blue:24/255.0 alpha:1.0]];
            lCustomerDetailLbl.text = @"";
            lCustomerDetailLbl.tag = lblTag + i;
        }
        yPos += 26;
        [self.view addSubview:lCustomerInfoLbl];
        [self.view addSubview:lCustomerDetailLbl];
        YPos += 26;
    }
}

- (void)setCustomerInfomationLabelsTextFromModel {
    [self enableOrdisableEditCustomerOrVehiclebtn];
    [self.view.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UILabel *lView = (UILabel *)object;
        if ([lView isKindOfClass:[UILabel class]]) {
            if(lView.tag==1) {
                [((UILabel*)lView) setText:[[[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_ returnString1:nil salutaion:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mSalutation_ firstName:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mFirstName_ middleName:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mMiddleName_ lastName:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mLastName_] ];
            }
            else if(lView.tag==51) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mHomePhone_] ];
            }
            else if(lView.tag==52) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mWorkPhone_]];
            }
            else if(lView.tag==53) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mMobilePhone_] ];
            }
            else if(lView.tag==54) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mEmail_] ];
            }
            else if(lView.tag==55) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mCustomerNumber_] ];
            }
            else if(lView.tag==56) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mAddress1_] ];
            }
            else if(lView.tag==57) {
                [((UILabel*)lView) setText:[NSString stringWithFormat:@" %@", [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mAddress2_] ];
            }
            
        }
    }];
}

- (void)enableOrdisableEditCustomerOrVehiclebtn {
    
    [self.mEditButton_ setSelected:NO];
    self.mEditButton_.enabled=([[[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.mSearchedListTableView_ indexPathForSelectedRow])?YES:NO;
}

- (IBAction)editBtnAction:(id)sender {
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchVehicleInfoView_].mVehiclesTableView_ reloadData];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] mContinueBtn_] setHidden:TRUE];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditCustomerScreen_.mIsBeginVehicle_ = FALSE;
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] displayEditCustomerPopup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
