//
//  ServicesPackageTableViewController.m
//  ASRPro
//
//  Created by Kalyani on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicesPackageTableViewController.h"

@interface ServicesPackageTableViewController (){
    int selectedindex;
}

@end

@implementation ServicesPackageTableViewController
@synthesize tempTouch;
@synthesize srcData;

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
    if (![[[[touch.view superview] superview] superview] isKindOfClass:[ServicePackageCell class]]) {
        return NO;
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
    if(isSearching){
        [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ saveAddDictToModel:[srcData objectAtIndex:indexPath.row]];
    }
    else{
        [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ saveAddDictToModel:[[[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_ objectAtIndex:indexPath.section] objectForKey:@"ChildrenServices"] objectAtIndex:indexPath.row]];
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
        return [mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_ count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
  //  return [[[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_  objectAtIndex:section] objectForKey:@"ChildrenServices"] count];
    if(isSearching){
        return [srcData count];
    }
    else{
    if(section==0||section==[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_ count]-1||section==selectedindex){
        NSMutableArray* lTempArray=[[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_  objectAtIndex:section] objectForKey:@"ChildrenServices"];

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
        
    [cell addViewToCell:[[[[[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_  objectAtIndex:indexPath.section] objectForKey:@"ChildrenServices"] objectAtIndex:indexPath.row] objectForKey:@"IsFastMover"] boolValue] withText:[[[[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_  objectAtIndex:indexPath.section] objectForKey:@"ChildrenServices"] objectAtIndex:indexPath.row] objectForKey:@"ServiceName"] withPrice:[NSString stringWithFormat:@"%@",([[[[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_  objectAtIndex:indexPath.section] objectForKey:@"ChildrenServices"] objectAtIndex:indexPath.row] objectForKey:@"Price"]!=nil)?@"":[[[[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_  objectAtIndex:indexPath.section] objectForKey:@"ChildrenServices"] objectAtIndex:indexPath.row] objectForKey:@"Price"]]];    // Configure the cell...
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
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempButton buttonTitle:[[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_  objectAtIndex:section] objectForKey:@"ServiceName"] buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 40) buttonImage:kUNSELECT_HEADER_ICON_SERVICEPACKAGE buttonImageEdgeInsets:UIEdgeInsetsMake(5, 260, 5, 5) controlState:UIControlStateNormal buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter buttonBackgroundColor:[UIColor whiteColor]];
    [[GenericFiles genericFiles] createUIButtonInstancewithIcon:lTempButton buttonTitle:[[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_  objectAtIndex:section] objectForKey:@"ServiceName"] buttonTitleColor:[UIColor blackColor] buttonTitleFont:[UIFont regularFontOfSize:14 fontKey:kFontNameHelveticaNeueKey] buttonTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 40) buttonImage:kSELECT_HEADER_ICON_SERVICEPACKAGE buttonImageEdgeInsets:UIEdgeInsetsMake(5, 260, 5, 5) controlState:UIControlStateSelected buttoncontentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0) buttoncontentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft buttonBackgroundColor:[UIColor whiteColor]];
    [lTempButton addTarget:self action:@selector(isHeaderClicked:) forControlEvents:UIControlEventTouchUpInside];
    if(section==selectedindex)
      [lTempButton setSelected:TRUE];
    return lTempButton;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if((section!=0)&&(section!=[mAppDelegate_.mServiceDataGetter_.mServicePackagesArray_ count]-1))
        return 40.0;
    else
        return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}


@end
