//
//  AddServiceTableViewController.m
//  ASRPro
//
//  Created by Kalyani on 07/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "AddServiceTableViewController.h"
#import "ServicesPickerView.h"
#import "ServicesTextView.h"
#import "ServicesColorView.h"


@interface AddServiceTableViewController ()
@property(nonatomic,retain) ServicesTextView* mServiceDetailsView;
@property(nonatomic,retain) ServicesTextView* mServiceNotesView;
@property(nonatomic,retain) ServicesColorView* mServiceColorView;
@property(nonatomic,retain) ServicesPickerView* mServiceHoursView;
@property(nonatomic,retain) ServicesTextView* mServiceLaborView;
@property(nonatomic,retain) ServicesTextView* mServicePartsView;
@property(nonatomic,retain) ServicesTextView* mServicePriceView;
@property(nonatomic,retain) ServicesTextView* mServiceComplaintView;
@property(nonatomic,retain) ServicesTextView* mServiceCauseView;
@property(nonatomic,retain) ServicesTextView* mServiceCorrectionView;

@end

@implementation AddServiceTableViewController
@synthesize mServiceDetailsView;
@synthesize mServiceNotesView;
@synthesize mServiceColorView;
@synthesize mServiceHoursView;
@synthesize mServiceLaborView;
@synthesize mServicePartsView;
@synthesize mServicePriceView;
@synthesize mServiceComplaintView;
@synthesize mServiceCauseView;
@synthesize mServiceCorrectionView;
@synthesize mServiceImageView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self initTheViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view.superview.bounds = CGRectMake(0, 0, 600,530);
}

-(void)initTheViews{
   [ self setMServiceDetailsView:[self getTextViewWithText:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mDetails_  height:KSERVICEPOPUP_DETAILS_HEIGHT tag:KSERVICEPOPUP_DETAILS]];
    [mServiceDetailsView setKeyboardType:UIKeyboardTypeDefault];
    if([[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForSplashScreen_.mUserRole_  isEqualToString:@"Advisor"])
        [ self setMServiceNotesView:[self getTextViewWithText:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mAdvisorNotes_  height:KSERVICEPOPUP_NOTES_HEIGHT  tag:KSERVICEPOPUP_NOTES]];
    else   if([[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForSplashScreen_.mUserRole_  isEqualToString:@"Technician"])
        [ self setMServiceNotesView:[self getTextViewWithText:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mTechnicianNotes_  height:KSERVICEPOPUP_NOTES_HEIGHT  tag:KSERVICEPOPUP_NOTES]];
    else   if([[[SharedUtilities sharedUtilities]appDelegateInstance].mModelForSplashScreen_.mUserRole_  isEqualToString:@"Manager"])
        [ self setMServiceNotesView:[self getTextViewWithText:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mManagerNotes_  height:KSERVICEPOPUP_NOTES_HEIGHT  tag:KSERVICEPOPUP_NOTES]];

    [mServiceNotesView setKeyboardType:UIKeyboardTypeDefault];

    self.mServiceColorView=[[ServicesColorView alloc] initWithFrame:CGRectMake(0, 0, 600, KSERVICEPOPUP_COLOR_HEIGHT)];
    
    [mServiceColorView setValue:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mColor_];
    self.mServiceHoursView=[[ServicesPickerView alloc] initWithFrame:CGRectMake(0, 0, 600, KSERVICEPOPUP_HOURS_HEIGHT)];
     [self.mServiceHoursView setValue:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mHours_];
    [ self setMServiceLaborView:[self getTextViewWithText:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mPriceLabor_  height:KSERVICEPOPUP_LABOR_HEIGHT  tag:KSERVICEPOPUP_LABOR]];
    [mServiceLaborView setKeyboardType:UIKeyboardTypeNumberPad];

    [ self setMServicePartsView:[self getTextViewWithText:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mPriceParts_ height:KSERVICEPOPUP_PARTS_HEIGHT  tag:KSERVICEPOPUP_PARTS]];
    [mServicePartsView setKeyboardType:UIKeyboardTypeNumberPad];

      [ self setMServicePriceView:[self getTextViewWithText:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mPrice_ height:KSERVICEPOPUP_PRICE_HEIGHT  tag:KSERVICEPOPUP_PRICE]] ;
    [mServicePriceView setKeyboardType:UIKeyboardTypeNumberPad];

       [ self setMServiceComplaintView:[self getTextViewWithText:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mComplaint_ height:KSERVICEPOPUP_COMPLAINT_HEIGHT  tag:KSERVICEPOPUP_COMPLAINT]];
    [mServiceComplaintView setKeyboardType:UIKeyboardTypeDefault];

      [ self setMServiceCauseView:[self getTextViewWithText:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mCause_ height:KSERVICEPOPUP_CAUSE_HEIGHT  tag:KSERVICEPOPUP_CAUSE]];
    [mServiceCauseView setKeyboardType:UIKeyboardTypeDefault];

      [ self setMServiceCorrectionView:[self getTextViewWithText:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mCorrection_ height:KSERVICEPOPUP_CORRECTION_HEIGHT  tag:KSERVICEPOPUP_CORRECTION]];
    [mServiceCorrectionView setKeyboardType:UIKeyboardTypeDefault];
    ServiceImageView* lServiceImageView=[[ServiceImageView alloc] initWithFrame:CGRectMake(0, 0, 600, 0)];
    [self setMServiceImageView:lServiceImageView];
    [self.mServiceImageView addImagesArrayView:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mServiceImageArray_];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    if(mAppDelegate_.mServiceDataGetter_.mAddServicesViewController_.mGetServiceReference_==OPENROSERVICESVIEWCONTROLLER)
    return 12;
    else
        return 11;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if(((section==3)||(section==selectedsection)||(section==11))&&(section!=0))
    return 1;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    [self resetTableViews:cell cellForRowAtIndexPath:indexPath];
        switch(indexPath.section){
            case KSERVICEPOPUP_DETAILS:{
                [mServiceDetailsView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
                [cell.contentView addSubview:mServiceDetailsView];
                break;
            }
            case KSERVICEPOPUP_NOTES:{
                [mServiceNotesView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];

                [cell.contentView addSubview:mServiceNotesView];
                break;
            }
            case KSERVICEPOPUP_COLOR:{
                [cell.contentView addSubview:mServiceColorView];
                break;
            }

            case KSERVICEPOPUP_HOURS:{
                [cell.contentView addSubview:mServiceHoursView];
                break;
            }
            case KSERVICEPOPUP_LABOR:{
                [cell.contentView addSubview:mServiceLaborView];
                [mServiceLaborView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
                break;
            }
            case KSERVICEPOPUP_PARTS:{
                [cell.contentView addSubview:mServicePartsView];
                [mServicePartsView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
                break;
            }
            case KSERVICEPOPUP_PRICE:{
                [mServicePriceView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
                [cell.contentView addSubview:mServicePriceView];
                break;
                
            }
            case KSERVICEPOPUP_COMPLAINT:{
                [mServiceComplaintView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
                [cell.contentView addSubview:mServiceComplaintView];
                break;
                
            }
            case KSERVICEPOPUP_CAUSE:{
                [self.mServiceCauseView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
                [cell.contentView addSubview:mServiceCauseView];
                break;
                
            }
            case KSERVICEPOPUP_CORRECTION:{
                [self.mServiceCorrectionView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
                [cell.contentView addSubview:self.mServiceCorrectionView];
                break;
                
            }
            case KSERVICEPOPUP_IMAGEVIEW:{
              //  [self.mServiceImageView performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.0f];
                [cell.contentView addSubview:self.mServiceImageView];
                break;
                
            }

        }
    // Configure the cell...
    
    return cell;
}

- (void)resetTableViews:(UITableViewCell*)aTableViewCell cellForRowAtIndexPath:(NSIndexPath*)aindexPath {
    //   if(aindexPath.section!=selectedSection){
    
    
    for (UIView *subview in [aTableViewCell.contentView subviews])
    {
        [subview removeFromSuperview];
    }
    //  }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch(indexPath.section){
        case KSERVICEPOPUP_SERVICE:{
            return KSERVICEPOPUP_SERVICE_HEIGHT;
            break;
        }
        case KSERVICEPOPUP_DETAILS:{
            return KSERVICEPOPUP_DETAILS_HEIGHT;
            break;
        }
        case KSERVICEPOPUP_NOTES:{
            return KSERVICEPOPUP_NOTES_HEIGHT;
            break;
        }
        case KSERVICEPOPUP_COLOR:{
            return KSERVICEPOPUP_COLOR_HEIGHT;
            break;
        }
        case KSERVICEPOPUP_HOURS:{
            return KSERVICEPOPUP_HOURS_HEIGHT;
            break;
        }
            
        case KSERVICEPOPUP_LABOR:{
            return KSERVICEPOPUP_LABOR_HEIGHT;
            break;
        }
        case KSERVICEPOPUP_PARTS:{
            return KSERVICEPOPUP_PARTS_HEIGHT;
            break;
            
        }   case KSERVICEPOPUP_PRICE:{
            return KSERVICEPOPUP_PRICE_HEIGHT;
            break;
        }
        case KSERVICEPOPUP_COMPLAINT:{
            return KSERVICEPOPUP_COMPLAINT_HEIGHT;
            break;
        }
        case KSERVICEPOPUP_CAUSE:{
            return KSERVICEPOPUP_CAUSE_HEIGHT;
            break;
        }
        case  KSERVICEPOPUP_CORRECTION:{
            return KSERVICEPOPUP_CORRECTION_HEIGHT;
            break;
        }
        case  KSERVICEPOPUP_IMAGEVIEW:{
            return mServiceImageView.frame.size.height;
            break;
        }
        default:{
            return 0;
            break;
        }
            
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(((section!=selectedsection)||(section==0)||(section==KSERVICEPOPUP_HOURS))&&(section!=3)&&(section!=11))
        return 50.0;
    else
        return 0.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch(section){
        case KSERVICEPOPUP_SERVICE:{
            return [self getViewWithLabel:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mServiceName_ btnTag:section defaultText:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceHeadingArray_] objectAtIndex:section]];
            break;
        }
        case KSERVICEPOPUP_DETAILS:{
            return [self getViewWithLabel:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mDetails_ btnTag:section defaultText:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceHeadingArray_] objectAtIndex:section]];
            break;
        }
        case KSERVICEPOPUP_NOTES:{
            return [self getViewWithLabel:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mAdvisorNotes_ btnTag:section defaultText:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceHeadingArray_] objectAtIndex:section]];
            break;
        }
        case KSERVICEPOPUP_HOURS:{
            return [self getViewWithLabel:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mHours_ btnTag:section defaultText:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceHeadingArray_] objectAtIndex:section]];
            break;
        }
        case KSERVICEPOPUP_LABOR:{
            return [self getViewWithLabel:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mPriceLabor_ btnTag:section defaultText:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceHeadingArray_] objectAtIndex:section]];
            break;
        }
        case KSERVICEPOPUP_PARTS:{
            return [self getViewWithLabel:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mPriceParts_ btnTag:section defaultText:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceHeadingArray_] objectAtIndex:section]];
            break;
        }
        case KSERVICEPOPUP_PRICE:{
            return [self getViewWithLabel:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mPrice_ btnTag:section defaultText:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceHeadingArray_] objectAtIndex:section]];
            break;
        }
        case KSERVICEPOPUP_COMPLAINT:{
            return [self getViewWithLabel:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mComplaint_ btnTag:section defaultText:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceHeadingArray_] objectAtIndex:section]];
            break;
        }
        case KSERVICEPOPUP_CAUSE:{
            return [self getViewWithLabel:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mCause_ btnTag:section defaultText:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceHeadingArray_] objectAtIndex:section]];
            break;
        }
        case  KSERVICEPOPUP_CORRECTION:{
            return [self getViewWithLabel:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mCorrection_ btnTag:section defaultText:[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mModelForSelectedService_] mServiceHeadingArray_] objectAtIndex:section]];
            break;
        }
        default:{
            return nil;
            break;
        }
    }
    return nil;
}



-(UIView*)getViewWithLabel:(NSString*)aText
                    btnTag:(int)aBtnTag
               defaultText:(NSString*)aDefaultText{
    UIView *lview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)] ;
    if([aText isEqualToString: @""]){
        UILabel* lTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.tableView.frame.size.width-20, 50)];
        [[GenericFiles genericFiles] createUILabelWithInstance:lTempLabel labelTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] labelTitle:aDefaultText labelTextColor:[UIColor grayColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [lview addSubview:lTempLabel];
    }
    else{
        UILabel* lTempLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.tableView.frame.size.width-20, 20)];
        [[GenericFiles genericFiles] createUILabelWithInstance:lTempLabel labelTitleFont:[UIFont regularFontOfSize:12 fontKey:kFontBoldKey] labelTitle:aDefaultText labelTextColor:[UIColor grayColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [lview addSubview:lTempLabel];
        UILabel* lTextLabel=[[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.tableView.frame.size.width-20, 50)];
        [[GenericFiles genericFiles] createUILabelWithInstance:lTextLabel labelTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] labelTitle:aText labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
        [lview addSubview:lTextLabel];
    }
    /* Create custom view to display section header... */
    UIButton *lTempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempButton buttonTitle:@"" buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] controlState:UIControlStateNormal buttoncontentEdgeInsets: UIEdgeInsetsMake(0, 10, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]]];
    lTempButton.tag=aBtnTag;
    /* Section header is in 0th index... */
    [lTempButton addTarget:self action:@selector(isHeaderClicked:) forControlEvents:UIControlEventTouchUpInside];
    [lTempButton setSelected:[aText isEqualToString:@""]?TRUE:FALSE];
    [[lview layer] setBorderWidth:1.0f];
    [[lview layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    lview.clipsToBounds=YES;
    [lview addSubview:lTempButton];
    return lview;
}


-(ServicesTextView*)getTextViewWithText:(NSString*)aText  height:(int)aheight tag :(int)aTag{
    ServicesTextView* lTempTextview=[[ServicesTextView alloc] initWithFrame:CGRectMake(0, 0, 600, aheight)];
    [lTempTextview setText:aText];
    [lTempTextview setTag:aTag];
    lTempTextview->lAddServiceTableViewController=self;
    return lTempTextview;
}

-(UIView*)getViewWithRadioButton:(NSString*)aState{
    
    UIView *lview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, KSERVICEPOPUP_COLOR_HEIGHT)] ;
    [self getButtonwithTag:lview isSelected:[aState isEqualToString:@"Yellow"]?TRUE:FALSE pos:10 btnTag:0];
    [self getButtonwithTag:lview isSelected:[aState isEqualToString:@"Red"]?TRUE:FALSE pos:60 btnTag:1];

    [[lview layer] setBorderWidth:0.5f];
    [[lview layer] setBorderColor:[UIColor lightGrayColor].CGColor];
    lview.clipsToBounds=YES;
    
    return lview;
    
}
-(void)getButtonwithTag:(UIView*)aInstanceView isSelected:(BOOL)aState pos:(int)yPos btnTag:(int)aBtnTag
{
    UIButton *lTempButton = [[UIButton alloc] initWithFrame:CGRectMake(10, yPos,30, 30)];
    lTempButton.tag=aBtnTag;
    [[GenericFiles genericFiles] createUIButtonInstance:lTempButton buttonTitle:@"" buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] controlState:UIControlStateSelected buttoncontentEdgeInsets: UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:(aBtnTag==1)?[UIImage imageNamed:@"IMG_select-icon-red.png"]:[UIImage imageNamed:@"IMG_select-icon-yellow.png"]];
    [[GenericFiles genericFiles] createUIButtonInstance:lTempButton buttonTitle:@"" buttonTitleColor:[UIColor grayColor] buttonTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] controlState:UIControlStateNormal buttoncontentEdgeInsets: UIEdgeInsetsZero buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundImage:(aBtnTag==1)?[UIImage imageNamed:@"IMG_unselect-icon-red.png"]:[UIImage imageNamed:@"IMG_unselect-icon-yellow.png"]];
    [lTempButton addTarget:self action:@selector(isRadioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [lTempButton setSelected:aState];
    [aInstanceView addSubview:lTempButton];
    UILabel* lTempLabel= [[UILabel alloc] initWithFrame:CGRectMake(50, yPos+5,250 , 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempLabel labelTitleFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey] labelTitle:aBtnTag==1?@"Requires Immediate Attention":@"May Require Future Attention" labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [aInstanceView addSubview:lTempLabel];
}


-(void)isHeaderClicked:(UIButton*)sender{
    [self.tableView reloadData];
    if(sender.tag==0){
        if(mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_->isAdd_)
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mAddServicesViewController_ pushToServicesListTableViewController];
    }
    if(sender.tag==KSERVICEPOPUP_HOURS)
    {
        selectedsection=(selectedsection==0)?KSERVICEPOPUP_HOURS:0;
    }
    else
        selectedsection=sender.tag;
    [self.tableView reloadData];

}

-(void)isRadioButtonClicked:(UIButton*)sender{
    UIButton* btn=(UIButton*)sender;
    if([sender isSelected]){
        [sender setSelected:FALSE];
        mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mColor_=@"";
    } else{
        [sender setSelected:TRUE];
        if(btn.tag==1)
            mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mColor_=@"Red";
        else
            mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mColor_=@"Yellow";
        
    }
    [self.tableView reloadData];
}

-(void)saveData{
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ convertModelToDict];
    mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_=mAppDelegate_.mServiceDataGetter_.mAddServicesViewController_.mGetServiceReference_;
    if(mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_->isAdd_)
        [ mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForAddServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_  SGCID:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mSGCID_];
    else
        [ mAppDelegate_.mModelForServiceRequestWebEngine_ RequestToUpdateService:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_ ServiceDict:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mServiceDetailsDict_];

}

-(void)saveOpenROdata{
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ convertModelToDict];
    mAppDelegate_.mModelforOpenROSupportEngine_.mGetServiceReference_=mAppDelegate_.mServiceDataGetter_.mAddServicesViewController_.mGetServiceReference_;
    if(mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_->isAdd_)
        [ mAppDelegate_.mModelforOpenROSupportEngine_ RequestForAddServiceLine:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_  SGCID: mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mSGCID_];
    else
        [ mAppDelegate_.mModelforOpenROSupportEngine_ RequestForUpdateServiceLine:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_ LineID:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_ ServiceDict:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mServiceDetailsDict_];

}

@end
