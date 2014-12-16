//
//  OpenROServicesTableViewController.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "OpenROServicesTableViewController.h"
#import "OpenROServiceCell.h"
#import "AddServicesViewController.h"


@interface OpenROServicesTableViewController ()
@property (nonatomic,retain) OpenROServiceCell* mSwipedCell_;

@end

@implementation OpenROServicesTableViewController

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
    [self addSwipeGesturesToView];
    [self.tableView addObserver:mAppDelegate_.mSearchViewController_ forKeyPath:@"contentSize" options:0 context:NULL];

    
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
    CGPoint swipeLocation = [recognizer locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
    if(mSwipedCell_.contentView.tag!=swipedIndexPath.row)
        [mSwipedCell_ resetCellView];
    OpenROServiceCell *lSwipedCell = (OpenROServiceCell*)[self.tableView cellForRowAtIndexPath:swipedIndexPath];
    [lSwipedCell isCellSwipedRight:YES];
    self.mSwipedCell_=lSwipedCell;
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer {
    CGPoint swipeLocation = [recognizer locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
    if(mSwipedCell_.contentView.tag!=swipedIndexPath.row)
        [mSwipedCell_ resetCellView];
    OpenROServiceCell *lSwipedCell = (OpenROServiceCell*)[self.tableView cellForRowAtIndexPath:swipedIndexPath];
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
        return [mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_ count]==0?1:[mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_ count];
    else
        return [mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ count]==0?1:[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"OpenROsServicesCell";
    
    OpenROServiceCell* cell = [[OpenROServiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    // }
    [cell.contentView setTag:indexPath.row];
    cell.isPrimary=(indexPath.section==0)?TRUE:FALSE;
    if(indexPath.section==0){
    if([mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_  count]>0){
        [cell setMServiceDictionary_:[mAppDelegate_.mOpenRoServiceDataGetter_.mScheduledServicesArray_ objectAtIndex:indexPath.row]];
    [cell addViewToCell];
    }
        else{
            [cell.textLabel setText:@"No Services have been added"];
            [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
            [cell.textLabel setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
            cell.userInteractionEnabled = NO;
            
        }
     }
    else{
            if([mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_  count]>0){
                [cell setMServiceDictionary_:[mAppDelegate_.mOpenRoServiceDataGetter_.mRecommendedServicesArray_ objectAtIndex:indexPath.row]];
                [cell addViewToCell];
            }
            else{
                [cell.textLabel setText:@"No Services have been added"];
                [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
                [cell.textLabel setFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey]];
                cell.userInteractionEnabled = NO;
                
            }
        }
    // Configure the cell...
    
    return cell;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray* lHeaderArray=(section==0)?[KPRIMARYSERVICESLABEL componentsSeparatedByString:@","]:[KRECOMMENDEDSERVICESLABEL componentsSeparatedByString:@","];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)] ;
    int xPos=5;
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xPos, 10,SERVICE_LABEL_WIDTH_OPENRO, 20)];
    //  [label setFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    //NSString *string =[NSString stringWithFormat:@"%@",[mHeaderTitleArray_ objectAtIndex:section]];
    /* Section header is in 0th index... */
    [label setText:[lHeaderArray objectAtIndex:0]];
    [view addSubview:label];
    //RELEASE_NIL(label);
    xPos+=SERVICE_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO+55;
    
    //PayType Label
    UILabel* lTempPayTypeLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, PAY_TYPE_LABEL_WIDTH_OPENRO, 40)];
    [lTempPayTypeLabel setText:[lHeaderArray objectAtIndex:1]];
    [lTempPayTypeLabel setBackgroundColor:[UIColor clearColor]];
    [lTempPayTypeLabel setTextColor:[UIColor whiteColor]];
    [view addSubview:lTempPayTypeLabel];
    xPos+=PAY_TYPE_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO;
    
    //Hrs Type Label
    UILabel* lTempHrsLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, HOURS_LABEL_WIDTH_OPENRO, 40)];
    [lTempHrsLabel setText:[lHeaderArray objectAtIndex:2]];
    [lTempHrsLabel setBackgroundColor:[UIColor clearColor]];
    [lTempHrsLabel setTextColor:[UIColor whiteColor]];
    [view addSubview:lTempHrsLabel];
    xPos+=HOURS_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO;
    
    
    //Labor Label
    UILabel* lTempLaborLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, LABOR_LABEL_WIDTH_OPENRO, 40)];
    [lTempLaborLabel setText:[lHeaderArray objectAtIndex:3]];
    [lTempLaborLabel setBackgroundColor:[UIColor clearColor]];
    [lTempLaborLabel setTextColor:[UIColor whiteColor]];
    [view addSubview:lTempLaborLabel];
    xPos+=LABOR_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO;
    
    
    //Parts Label
    UILabel* lTempPartsLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0, PARTS_LABEL_WIDTH_OPENRO, 40)];
    [lTempPartsLabel setText:[lHeaderArray objectAtIndex:4]];
    [lTempPartsLabel setBackgroundColor:[UIColor clearColor]];
    [lTempPartsLabel setTextColor:[UIColor whiteColor]];
    [view addSubview:lTempPartsLabel];
    xPos+=PARTS_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO;
    
    
    //Price Label
    UILabel* lTempPriceeLabel=[[UILabel alloc] initWithFrame:CGRectMake(xPos, 0,PRICE_LABEL_WIDTH_OPENRO,40)];
    [lTempPriceeLabel setText:[lHeaderArray objectAtIndex:5]];
    [lTempPriceeLabel setBackgroundColor:[UIColor clearColor]];
    [lTempPriceeLabel setTextColor:[UIColor whiteColor]];
    [view addSubview:lTempPriceeLabel];
    xPos+=PRICE_LABEL_WIDTH_OPENRO+SEPERATION_GAP_OPENRO;
    if(section==0){
    UIButton* lTempAddButton=[[UIButton alloc] initWithFrame:CGRectMake(xPos,5 , 30, 30)];
    [lTempAddButton setBackgroundImage:[UIImage imageNamed:@"iPad_icon_add.png"] forState:UIControlStateNormal];
    [lTempAddButton addTarget:self action:@selector(isAddButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [lTempAddButton setTag:section];
    [view addSubview:lTempAddButton];
    }
    [view setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]]; //your background color...
    
    return view;
}


-(void)isAddButtonClicked:(UIButton*)sender{
    if(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_!=7&&(mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_!=nil)){
      [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mModelForSelectedService_ resetAllValues];
    [self pushToAddServicesView];
}
}

-(void)pushToAddServicesView{
    mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ =[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPATH] ;
    if(mAppDelegate_.mServiceDataGetter_.mAllServicesArray_==nil)
    {
        mAppDelegate_.mModelForServiceRequestWebEngine_->isLoadingRequired=TRUE;
        mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_=OPENROSERVICESVIEWCONTROLLER;
        
        [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForAllServiceLines];
    }
    else{
        
        [self loadAddServicesView];
    }

  
}

-(void)loadAddServicesView{
    AddServicesViewController *lAddServicesViewController = [[AddServicesViewController alloc] initWithNibName:@"AddServicesViewController" bundle:nil];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_ setMAddServicesViewController_:lAddServicesViewController];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mAddServicesViewController_ setMGetServiceReference_:OPENROSERVICESVIEWCONTROLLER];
    lAddServicesViewController.modalPresentationStyle=UIModalPresentationFormSheet;
    lAddServicesViewController.modalTransitionStyle= UIModalTransitionStyleCoverVertical;
    [self presentViewController:lAddServicesViewController animated:YES completion:nil];

}

@end
