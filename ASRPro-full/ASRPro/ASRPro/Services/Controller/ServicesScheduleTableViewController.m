//
//  ServicesScheduleTableViewController.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ServicesScheduleTableViewController.h"
#import "ServicesScheduledCell.h"

@interface ServicesScheduleTableViewController () {
    
}

@end

@implementation ServicesScheduleTableViewController

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
    [self.tableView reloadData];
    [self.tableView .layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
    [self.tableView .layer setBorderWidth:2.0];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mAppDelegate_.mServiceDataGetter_.mScheduledServicesArray_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ServicesScheduledCell";
    ServicesScheduledCell* cell = [[ServicesScheduledCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    // }
    [cell.contentView setTag:indexPath.row];
    [cell setMServicesDict_:[mAppDelegate_.mServiceDataGetter_.mScheduledServicesArray_ objectAtIndex:indexPath.row]];
    
    [cell addViewToCell];
    // Configure the cell...
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)] ;
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, tableView.frame.size.width, 20)];
    //  [label setFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    //NSString *string =[NSString stringWithFormat:@"%@",[mHeaderTitleArray_ objectAtIndex:section]];
    /* Section header is in 0th index... */
    [label setText:@"Services Scheduled In Appointments"];
    [label setFont: [UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    [view addSubview:label];
    //RELEASE_NIL(label);
    
    [view setBackgroundColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0]]; //your background color...
    
    return view;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 35)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 550, 20)];
    //  [label setFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor whiteColor]];
    //NSString *string =[NSString stringWithFormat:@"%@",[mHeaderTitleArray_ objectAtIndex:section]];
    /* Section header is in 0th index... */
    [label setText:@"Sub - Total of Services from appointment"];
    [label setFont: [UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    
    [view addSubview:label];
    //RELEASE_NIL(label);
    
    UILabel *Pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(587, 7, 100, 20)];
    //  [label setFont:[UIFont regularFontOfSize:16 fontKey:kFontBoldKey]];
    [Pricelabel setBackgroundColor:[UIColor clearColor]];
    [Pricelabel setFont: [UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
    
    [Pricelabel setTextColor:[UIColor whiteColor]];
    //NSString *string =[NSString stringWithFormat:@"%@",[mHeaderTitleArray_ objectAtIndex:section]];
    /* Section header is in 0th index... */
    [Pricelabel setText:[NSString stringWithFormat:@"$%.2f",[mAppDelegate_.mServiceDataGetter_.mServicesScheduledTotal floatValue] ]];
    [view addSubview:Pricelabel];
    
    [view setBackgroundColor:[UIColor colorWithRed:(41.0/255.0) green:(174.0/255.0) blue:(97.0/255.0) alpha:1.0]]; //your background color...
    
    return view;
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 
 */

@end
