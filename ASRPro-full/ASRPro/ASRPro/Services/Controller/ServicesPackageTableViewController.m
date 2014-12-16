//
//  ServicesPackageTableViewController.m
//  ASRPro
//
//  Created by Kalyani on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicesPackageTableViewController.h"
#define REFRESH_HEADER_HEIGHT 52.0f

@interface ServicesPackageTableViewController (){
    int selectedindex;
}

@end

@implementation ServicesPackageTableViewController
@synthesize tempTouch;
@synthesize srcData;

@synthesize textPull, textRelease, textLoading, refreshHeaderView, refreshLabel, refreshArrow, refreshSpinner;

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
    // [self.tableView setTableFooterView:[self setFooterView]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    isSearching=FALSE;
    
    [self setupStrings];
    [self addPullToRefreshHeader];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


-(void)isHeaderClicked:(UIButton*)sender{
    if(![sender isSelected]){
        [sender setSelected:TRUE];
        selectedindex=sender.tag;
    }
    else{
        [sender setSelected:FALSE];
        selectedindex=0;
    }
    [self.tableView reloadData];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    self.tempTouch=touch;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        if (![[[touch.view superview] superview] isKindOfClass:[ServicePackageCell class]]) {
            return NO;
        }
    }else {
        if (![[[[touch.view superview] superview] superview] isKindOfClass:[ServicePackageCell class]]) {
            return NO;
        }
    }
    return YES;
}
-(void)searchServicesWithText:(NSString*)aText{
    if([[aText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ] isEqualToString:@""]){
        isSearching=FALSE;
        [self.tableView reloadData];
    }
    else{
        isSearching=TRUE;
        mSearchText=aText;
        [self.tableView reloadData];
        
    }
    
}


- (void)handlePanning:(UIPanGestureRecognizer *)gestureRecognizer
{
    switch ([gestureRecognizer state]) {
        case UIGestureRecognizerStateBegan:
            [self startDragging:gestureRecognizer];
            break;
        case UIGestureRecognizerStateChanged:
            [self doDrag:gestureRecognizer];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            if(gestureRecognizer)
                [self stopDragging:gestureRecognizer];
            break;
        default:
            break;
    }
}

- (void)startDragging:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint pointInSrc = [gestureRecognizer locationInView:self.tableView];
    
    draggedCell = nil;
    if([self.tableView pointInside:pointInSrc withEvent:nil])
    {
        [self startDraggingFromSrcAtPoint:pointInSrc];
        dragFromSource = YES;
    }
    
}

- (void)startDraggingFromSrcAtPoint:(CGPoint)point
{
    NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:point];
    ServicePackageCell* cell =(ServicePackageCell*) [self.tableView cellForRowAtIndexPath:indexPath];
    if(cell != nil)
    {
        CGPoint origin=[[self.tableView superview]convertPoint:cell.frame.origin fromView:self.tableView];
        origin.x += self.tableView.frame.origin.x;
        origin.y += [self.tableView superview].frame.origin.y;
        origin.y -= 20;// to be on top of fingure
        
        [self initDraggedCellWithCell:cell AtPoint:origin];
        cell.highlighted = NO;
    }
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ resetAllValues];
    if(isSearching){
        [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ saveAddDictToModel:[srcData objectAtIndex:indexPath.row]];
    }
    else{
        [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ saveAddDictToModel:[[[mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_ objectAtIndex:indexPath.section] objectForKey:@"ChildrenServices"] objectAtIndex:indexPath.row]];
    }
}

- (void)initDraggedCellWithCell:(ServicePackageCell*)cell AtPoint:(CGPoint)point
{
    // get rid of old cell, if it wasn't disposed already
    if(draggedCell != nil)
    {
        [draggedCell removeFromSuperview];
    }
    
    CGRect frame = CGRectMake(point.x, point.y, cell.frame.size.width, cell.frame.size.height);
    
    draggedCell = [[ServicePackageCell alloc] init];
    draggedCell.selectionStyle = UITableViewCellSelectionStyleGray;
    [draggedCell addViewToCell:cell->section withText:cell.mLabel withPrice:cell.mPrice];
    draggedCell.frame=frame;
    [ mAppDelegate_.mServicesViewController_.view addSubview:draggedCell];
    
}

- (void)doDrag:(UIPanGestureRecognizer *)gestureRecognizer
{
    if(draggedCell != nil )
    {
        CGPoint translation = [gestureRecognizer translationInView:[draggedCell superview]];
        [draggedCell setCenter:CGPointMake([draggedCell center].x + translation.x,
                                           [draggedCell center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[draggedCell superview]];
    }
}

- (void)stopDragging:(UIPanGestureRecognizer *)gestureRecognizer
{
    
    if(draggedCell != nil )
    {
        if(([gestureRecognizer state] == UIGestureRecognizerStateEnded)&&( [mAppDelegate_.mServicesViewController_.mRecommendedServicesTableViewController_.tableView   pointInside:[gestureRecognizer locationInView:mAppDelegate_.mServicesViewController_.mRecommendedServicesTableViewController_.tableView] withEvent:nil])){
            [mAppDelegate_.mServicesViewController_ showAddServicePopup];
        }
        [draggedCell removeFromSuperview];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if(isSearching)
        return 1;
    else
        return [mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_ count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //  return [[[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_  objectAtIndex:section] objectForKey:@"ChildrenServices"] count];
    if(isSearching){
        return [srcData count];
    }
    else{
        if(section==0||section==[mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_ count]-1||section==selectedindex){
            NSMutableArray* lTempArray=[[mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_  objectAtIndex:section] objectForKey:@"ChildrenServices"];
            
            return [lTempArray count];
        }
        else
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ServicePackageCell";
    
    ServicePackageCell* cell = [[ServicePackageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    // }
    [cell.contentView setTag:indexPath.row];
    if(isSearching){
        [cell addViewToCell:[[[srcData objectAtIndex:indexPath.row] objectForKey:@"IsFastMover"] boolValue] withText:[[srcData objectAtIndex:indexPath.row] objectForKey:@"ServiceName"] withPrice:[NSString stringWithFormat:@"%@",([[srcData objectAtIndex:indexPath.row] objectForKey:@"Price"]!=nil)?@"":[[srcData objectAtIndex:indexPath.row] objectForKey:@"Price"]]];    // Configure the cell...
        
    }
    else {
        
        [cell addViewToCell:[[[[[mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_  objectAtIndex:indexPath.section] objectForKey:@"ChildrenServices"] objectAtIndex:indexPath.row] objectForKey:@"IsFastMover"] boolValue] withText:[[[[mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_  objectAtIndex:indexPath.section] objectForKey:@"ChildrenServices"] objectAtIndex:indexPath.row] objectForKey:@"ServiceName"] withPrice:[NSString stringWithFormat:@"%@",([[[[mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_  objectAtIndex:indexPath.section] objectForKey:@"ChildrenServices"] objectAtIndex:indexPath.row] objectForKey:@"Price"]!=nil)?@"":[[[[mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_  objectAtIndex:indexPath.section] objectForKey:@"ChildrenServices"] objectAtIndex:indexPath.row] objectForKey:@"Price"]]];    // Configure the cell...
    }
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *lTempButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)] ;
    [lTempButton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [lTempButton.layer setBorderWidth:0.5];
    /* Create custom view to display section header... */
    // [lTempButton setBackgroundColor:[UIColor whiteColor]]; //your background color...
    [lTempButton setTag:section];
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempButton buttonTitle:[[mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_  objectAtIndex:section] objectForKey:@"ServiceName"] buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 40) buttonImage:kUNSELECT_HEADER_ICON_SERVICEPACKAGE buttonImageEdgeInsets:UIEdgeInsetsMake(5, 260, 5, 5) controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundColor:[UIColor whiteColor]];
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempButton buttonTitle:[[mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_  objectAtIndex:section] objectForKey:@"ServiceName"] buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 40) buttonImage:kSELECT_HEADER_ICON_SERVICEPACKAGE buttonImageEdgeInsets:UIEdgeInsetsMake(5, 260, 5, 5) controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor whiteColor]];
    [lTempButton addTarget:self action:@selector(isHeaderClicked:) forControlEvents:UIControlEventTouchUpInside];
    if(section==selectedindex)
        [lTempButton setSelected:TRUE];
    return lTempButton;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if((section!=0)&&(section!=[mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_ count]-1))
        return 40.0;
    else
        return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

-(void)reloadServicesData{
    mAppDelegate_.mServiceDataGetter_.mTempServicePackagesArray_= [[FileUtils fileUtils]loadArrayFromFile:kALLSERVICESPACKAGE ];
    [mAppDelegate_.mServicesViewController_.mServicesPackageTableViewController_.tableView reloadData];
    
}

- (void)setupStrings {
    textPull = @"Pull down to update...";
    textRelease = @"Release to update...";
    textLoading = @"Updating...";
}

- (void)addPullToRefreshHeader {
    refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 - REFRESH_HEADER_HEIGHT, 320, REFRESH_HEADER_HEIGHT)];
    refreshHeaderView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, REFRESH_HEADER_HEIGHT)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = NSTextAlignmentCenter;
    //refreshLabel.textColor=ASR_ORANGE_COLOR;
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_pullarrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                    (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                    27, 44);
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshHeaderView addSubview:refreshLabel];
    [refreshHeaderView addSubview:refreshArrow];
    [refreshHeaderView addSubview:refreshSpinner];
    [self.tableView addSubview:refreshHeaderView];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self.tableView.contentInset = UIEdgeInsetsZero;
        
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT){
            
            self.tableView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
        }
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView animateWithDuration:0.25 animations:^{
            if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
                // User is scrolling above the header
                refreshLabel.text = self.textRelease;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            } else {
                // User is scrolling somewhere within the header
                refreshLabel.text = self.textPull;
                [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
            }
        }];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
        // Released above the header
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
        refreshLabel.text = self.textLoading;
        refreshArrow.hidden = YES;
        [refreshSpinner startAnimating];
    }];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.contentInset = UIEdgeInsetsZero;
        [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    }
                     completion:^(BOOL finished) {
                         [self performSelector:@selector(stopLoadingComplete)];
                     }];
}

- (void)stopLoadingComplete {
    // Reset the header
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    [refreshSpinner stopAnimating];
}

- (void)refresh {
    // This is just a demo. Override this method with your custom reload action.
    // Don't forget to call stopLoading at the end.
    if(!isPulltorefresh){
        if ([[NetworkMonitor instance] isNetworkAvailable]) {
            //        [[SearchSupportWebEngine sharedInstance] threadRequestToGetRepairOrdersForPullToRefresh];
            isPulltorefresh=TRUE;
            [mAppDelegate_.mServicesViewController_ updateDateAndTime];
            
            [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForServiceLinesForPullToRefresh];
        }else {
            [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
            [[NetworkMonitor instance]displayNetworkMonitorAlert];
            return;
        }
    }
    
}

@end
