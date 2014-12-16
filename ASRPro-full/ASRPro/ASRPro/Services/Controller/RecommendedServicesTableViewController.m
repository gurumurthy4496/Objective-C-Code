//
//  RecommendedServicesTableViewController.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "RecommendedServicesTableViewController.h"



@interface RecommendedServicesTableViewController ()
@property (nonatomic,retain) RecommendedServicesCell* mSwipedCell_;

@end

@implementation RecommendedServicesTableViewController
@synthesize mSwipedCell_;

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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView .layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
    [self.tableView .layer setBorderWidth:2.0];
    [self.tableView addObserver:mAppDelegate_.mServicesViewController_ forKeyPath:@"contentSize" options:0 context:NULL];

    [self addSwipeGesturesToView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// swipe code
-(void)addSwipeGesturesToView{
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc]
                                                  initWithTarget:self
                                                  action:@selector(handleSwipeLeft:)];
    [swipeLeftGesture setDirection: UISwipeGestureRecognizerDirectionLeft];
    [swipeLeftGesture setDelegate:self];
    
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc]
                                                   initWithTarget:self
                                                   action:@selector(handleSwipeRight:)];
    
    [swipeRightGesture setDirection: UISwipeGestureRecognizerDirectionRight];
    [swipeRightGesture setDelegate:self];
    
    [self.tableView addGestureRecognizer:swipeLeftGesture];
    [self.tableView addGestureRecognizer:swipeRightGesture];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)recognizer {
    //   if(!isEditable){
    [mSwipedCell_ resetCellView];
    
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer {
    CGPoint swipeLocation = [recognizer locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
    RecommendedServicesCell *lSwipedCell = (RecommendedServicesCell*)[self.tableView cellForRowAtIndexPath:swipedIndexPath];
    if(mSwipedCell_.contentView.tag!=swipedIndexPath.row)
        [mSwipedCell_ resetCellView];
    [lSwipedCell isCellSwipedLeft:YES];
    self.mSwipedCell_=lSwipedCell;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section==0)
        return [mAppDelegate_.mServiceDataGetter_.mScheduledServicesArray_ count]>0?[mAppDelegate_.mServiceDataGetter_.mScheduledServicesArray_ count]:1;
    else
        return  [mAppDelegate_.mServiceDataGetter_.mRecommendedServicesArray_ count]>0?[mAppDelegate_.mServiceDataGetter_.mRecommendedServicesArray_ count]:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RecommendedServicesCell";
    RecommendedServicesCell* cell = [[RecommendedServicesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    // }
    [cell.contentView setTag:indexPath.row];
    if(indexPath.section==0){
        if([mAppDelegate_.mServiceDataGetter_.mScheduledServicesArray_ count]>0){
    [cell setMServicesDict:[mAppDelegate_.mServiceDataGetter_.mScheduledServicesArray_ objectAtIndex:indexPath.row]];
            [cell addViewToCell];
        }
        else
            [cell addNoServicesLabel];

    }
    else{
        if([mAppDelegate_.mServiceDataGetter_.mRecommendedServicesArray_ count]>0){
        [cell setMServicesDict:[mAppDelegate_.mServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:indexPath.row]];
    [cell addViewToCell];
        }
        else
            [cell addNoServicesLabel];

    }
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0)
    return 60;
    else
        return 25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==0)
        return 0;
    else
        return 105;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0){
        UIView * headerview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 60)];
    NSArray* lHeaderArray=[KRECOMMENDEDSERVICESLABEL componentsSeparatedByString:@","];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)] ;
    int xPos=10;
    /* Create custom view to display section header... */
    UILabel *lTempServiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 7,SERVICE_LABEL_WIDTH_RECOMMENDED+30-5, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempServiceLabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:@"Service Name" labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempServiceLabel];
    xPos+=SERVICE_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED+30;
    
    //PayType Label
    UILabel* lTempPayTypeLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, PAY_TYPE_LABEL_WIDTH_RECOMMENDED, 35)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPayTypeLabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[lHeaderArray objectAtIndex:1] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempPayTypeLabel];
    xPos+=PAY_TYPE_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED;
    
    //Hrs Type Label
    UILabel* lTempHrsLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, HOURS_LABEL_WIDTH_RECOMMENDED, 35)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempHrsLabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[lHeaderArray objectAtIndex:2] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempHrsLabel];
    xPos+=HOURS_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED;
    
    
    //Labor Label
    UILabel* lTempLaborLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, LABOR_LABEL_WIDTH_RECOMMENDED, 35)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempLaborLabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[lHeaderArray objectAtIndex:3] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempLaborLabel];
    xPos+=LABOR_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED;
    
    
    //Parts Label
    UILabel* lTempPartsLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, PARTS_LABEL_WIDTH_RECOMMENDED, 35)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPartsLabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[lHeaderArray objectAtIndex:4] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempPartsLabel];
    xPos+=PARTS_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED;
    
    
    //Price Label
    UILabel* lTempPriceLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0,PRICE_LABEL_WIDTH_RECOMMENDED,35)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTempPriceLabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[lHeaderArray objectAtIndex:5] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentCenter labelBackgroundColor:[UIColor clearColor]];
    [view addSubview:lTempPriceLabel];
    [view setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]]; //your background color...
    //  xPos+=PRICE_LABEL_WIDTH_RECOMMENDED+SEPERATION_GAP_RECOMMENDED+5;
    //
    //    UIButton* lTempAddButton=[[UIButton alloc] initWithFrame:CGRectMake(xPos,5 , 30, 30)];
    //
    //    [[GenericFiles genericFiles] createUIButtonInstance:lTempAddButton buttonTitle:@"" buttonTitleColor:[UIColor clearColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)  buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundImage:kADDBUTTON_IMAGE_RECOMMENDED];
    //    [lTempAddButton addTarget:self action:@selector(isAddButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //    [lTempAddButton setTag:section];
    //    [view addSubview:lTempAddButton];
    
    [view setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]]; //your background color...
        [headerview addSubview:view];

        UIView *mLabelView=[[UIView alloc] initWithFrame:CGRectMake(0, 35, tableView.frame.size.width, 25)];
//        UIView* lDividerView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,1)];
//        [lDividerView1 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
//        [mLabelView addSubview:lDividerView1];
        [mLabelView.layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
        [mLabelView.layer setBorderWidth:1.0];
        
        UILabel* mLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 350, 25)];
        
        [mLabel setFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey]];
        [mLabel setText:@"Appointments"];
        [mLabel setTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
        [mLabel setBackgroundColor:[UIColor clearColor]];
        [mLabelView addSubview:mLabel];
        [mLabelView setBackgroundColor:[UIColor whiteColor]];
        [headerview addSubview:mLabelView];
//        UIView* lDividerView2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,1)];
//        [lDividerView1 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
//        [mLabelView addSubview:lDividerView1];

        return headerview;
    }
    else{
        UIView *mLabelView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 25)];
        [mLabelView.layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
        [mLabelView.layer setBorderWidth:1.0];

        UILabel* mLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 350, 25)];
        [mLabel setFont:[UIFont regularFontOfSize:13 fontKey:kFontNameHelveticaNeueKey]];
        [mLabel setText:@"Recommendations"];
        [mLabel setTextColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
        [mLabel setBackgroundColor:[UIColor clearColor]];
        [mLabelView addSubview:mLabel];
        [mLabelView setBackgroundColor:[UIColor whiteColor]];
        return mLabelView;
  
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *lFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 105)];
    UIView* lDividerView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,1)];
    [lDividerView1 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lFooterView addSubview:lDividerView1];
    UIView *lServicesScheduledView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, tableView.frame.size.width, 34)] ;
    /* Create custom view to display section header... */
    UILabel *lServicesScheduleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 550, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lServicesScheduleLabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:KRECOMMENDEDSERVICESTOTALAPPOINMENTLABEL labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [lServicesScheduledView addSubview:lServicesScheduleLabel];
    
    UILabel *lServicesSchedulePricelabel = [[UILabel alloc] initWithFrame:CGRectMake(537, 7, 100, 20)];
    //  [label setFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey]];
    [[GenericFiles genericFiles] createUILabelWithInstance:lServicesSchedulePricelabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[mAppDelegate_.mServiceDataGetter_.mServicesScheduledTotal floatValue] ]labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [lServicesScheduledView addSubview:lServicesSchedulePricelabel];
    [lServicesScheduledView setBackgroundColor:[UIColor whiteColor]]; //your background color...
    
    UIView* lDividerView2=[[UIView alloc]initWithFrame:CGRectMake(0, 35, tableView.frame.size.width,1)];
    [lDividerView2 setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]];
    [lFooterView addSubview:lDividerView2];
    UIView *lRecommendedServicesView = [[UIView alloc] initWithFrame:CGRectMake(0, 36, tableView.frame.size.width, 34)] ;
    /* Create custom view to display section header... */
    UILabel *lRecommendedServiceslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 550, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lRecommendedServiceslabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:KRECOMMENDEDSERVICESTOTALLABEL labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [lRecommendedServicesView addSubview:lRecommendedServiceslabel];
    
    UILabel *lRecommendedServicesPricelabel = [[UILabel alloc] initWithFrame:CGRectMake(537, 7, 100, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lRecommendedServicesPricelabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[mAppDelegate_.mServiceDataGetter_.mRecommendedServicesTotal floatValue] ]  labelTextColor:[UIColor blackColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];    [lRecommendedServicesView addSubview:lRecommendedServicesPricelabel];
    
    [lRecommendedServicesView setBackgroundColor:[UIColor whiteColor]]; //your background color...
    UIView *lTotalServicesView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, tableView.frame.size.width, 34)] ;
    
    UILabel *lTotalServiceslabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 200, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTotalServiceslabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:KTOTALSERVICESLABEL labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [lTotalServicesView addSubview:lTotalServiceslabel];
    
    UILabel *lShopChargeslabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 7, 200, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lShopChargeslabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@ : $%.2f",KSHOPCHARGESLABEL,[mAppDelegate_.mServiceDataGetter_.mShopCharges floatValue]] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];

    [lTotalServicesView addSubview:lShopChargeslabel];
    UILabel *lTotalTaxlabel = [[UILabel alloc] initWithFrame:CGRectMake(450, 7, 100, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTotalTaxlabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"%@ : $%.2f",KTAXLABEL,[mAppDelegate_.mServiceDataGetter_.mTax floatValue] ] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentLeft labelBackgroundColor:[UIColor clearColor]];
    [lTotalServicesView addSubview:lTotalTaxlabel];
    
    UILabel *lTotalServicesPricelabel = [[UILabel alloc] initWithFrame:CGRectMake(537, 7, 100, 20)];
    [[GenericFiles genericFiles] createUILabelWithInstance:lTotalServicesPricelabel  labelTitleFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey] labelTitle:[NSString stringWithFormat:@"$%.2f",[mAppDelegate_.mServiceDataGetter_.mFinalServicesTotall floatValue] ] labelTextColor:[UIColor whiteColor] labelTextAlignment:NSTextAlignmentRight labelBackgroundColor:[UIColor clearColor]];
    [lTotalServicesView addSubview:lTotalServicesPricelabel];
    [lTotalServicesView setBackgroundColor:[UIColor colorWithRed:(41.0/255.0) green:(174.0/255.0) blue:(97.0/255.0) alpha:1.0]];
    
    
    [lFooterView setBackgroundColor:[UIColor clearColor]];
    [lFooterView addSubview:lServicesScheduledView];
    [lFooterView addSubview:lRecommendedServicesView];
    [lFooterView addSubview:lTotalServicesView];
    
    return lFooterView;
    
}



-(void)isAddButtonClicked:(UIButton*)sender{
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ resetAllValues];
    [mAppDelegate_.mServicesViewController_ showAddServicePopup];
    
}

@end
