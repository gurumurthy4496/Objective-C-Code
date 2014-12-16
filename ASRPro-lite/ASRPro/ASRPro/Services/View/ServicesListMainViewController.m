//
//  ServicesListViewController.m
//  ASRPro
//
//  Created by Kalyani on 10/11/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "ServicesListMainViewController.h"

@interface ServicesListMainViewController ()

@end

@implementation ServicesListMainViewController
@synthesize mSearchedDataArray;
@synthesize mNoServicesListtextLbl;

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
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
   // mAppDelegate_.mServicesDataGetter_.mAllServicesArray_ = [[mAppDelegate_.mServicesDataGetter_.mServicesArray_ mutableCopy] autorelease];
    [self.mTableView setContentSize:CGSizeMake(self.mTableView.frame.size.width, self.mTableView.frame.size.height+200)];
    [self initializationOfObjects];
}
- (void)viewWillAppear:(BOOL)animated {
}

// ----------------------------;
// This method is called after succes response for Service List Request;
// ----------------------------;
- (void)initDataInTableView :(NSMutableArray *)aServicesListArray {
    mSearchedDataArray = aServicesListArray;
    // Allocation for Service List Search data array;
    [self.mTableView reloadData];
    
    // Hiding empty seperatores in Services List TableView;
    [[SharedUtilities sharedUtilities] hideEmptySeparators:self.mTableView];
    
    [self.mNoServicesListtextLbl setHidden:[ mSearchedDataArray count]];
    if (![ mSearchedDataArray count]) {
        [self.mNoServicesListtextLbl setText:[NSString stringWithFormat:@"No Service list found"]];
    }
    
}

// ----------------------------;
// Initializing the objects;
// ----------------------------;
- (void)initializationOfObjects {
    
    self.navigationItem.title = @"Services List ";
    // [self.navigationItem.backBarButtonItem setTitle:@"Back"];
    //self.navigationController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonSystemItemAction target:self action:nil];
    
    self.navigationController.navigationBarHidden = NO;
    // ----------------------------;
    // ADD LeftView to ECS_Sliding -> RepairOrderModesLeftSliderViewController;
    // ----------------------------;
    UISearchBar *lSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    CGRect frame = lSearchBar.frame;
    [lSearchBar CustomSearchBar:frame];
    self.mSearhBar_ = lSearchBar;
    // Get the instance of the UITextField of the search bar
    self.mSearhBar_.tag = 2;
    UITextField *searchField = [self.mSearhBar_ valueForKey:@"_searchField"];
    [searchField setBackgroundColor:[UIColor whiteColor]];
    [self.mSearhBar_ setImage:[UIImage imageNamed:@""] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.mSearhBar_ setBackgroundImage:nil];
    [self.mSearhBar_ setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.mSearhBar_];
    mSearchedDataArray = [mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ mutableCopy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableViewf
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [mSearchedDataArray count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *sectionedArray = [[NSMutableArray alloc]init];
    for(char c ='A' ; c <= 'Z' ;  c++)
    {
        [sectionedArray addObject:[NSString stringWithFormat:@"%c",c]];
    }
    //    for(UIView *lView in self.view.subviews) {
    //        if ([lView isKindOfClass:[UISearchBar class]]) {
    //            UISearchBar *lSearchBar = (UISearchBar*)lView;
    if (_isSearching) {
        return nil;
        //            }
        //        }
    }
    if ([mSearchedDataArray count]>0) {
        return 0;
    }else
        return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    // Find the correct index of cell should scroll to.
    int foundIndex = 0;
    for (NSMutableDictionary *obj in mSearchedDataArray) {
        if ([[[[obj objectForKey:@"ServiceName"] substringToIndex:1] uppercaseString] compare: title] == NSOrderedAscending)
            foundIndex++;
    }
    if(foundIndex >= mSearchedDataArray.count)
        foundIndex = mSearchedDataArray.count-1;
    
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:foundIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    [cell.contentView setTag:indexPath.row];
    [cell.textLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey]];
    cell.textLabel.text = [[mSearchedDataArray objectAtIndex:indexPath.row] objectForKey:@"ServiceName"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ saveAddDictToModel:[mSearchedDataArray objectAtIndex:indexPath.row]];
    [mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_ convertModelToDict];

    [mAppDelegate_.mServiceDataGetter_.mAddServicesViewController_.mAddServiceTableViewController_.tableView reloadData];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mServiceDataGetter_.mAddServicesViewController_ pushtoAddServicesTable];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end