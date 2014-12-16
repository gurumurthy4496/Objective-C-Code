//
//  UISearchBar+CustomSearchBar.m
//  ASRPro
//
//  Created by Santosh Kvss on 2/13/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "UISearchBar+CustomSearchBar.h"

@implementation UISearchBar (CustomSearchBar)

 UIView *mOverLayView_;

- (void)CustomSearchBar:(CGRect)frame {
    NSArray *searchBarSubViews;
    if (IOS_NEWER_OR_EQUAL_TO_7)
        searchBarSubViews = [[self.subviews objectAtIndex:0] subviews];
    else
        searchBarSubViews =  self.subviews;
    for(int i =0; i<[searchBarSubViews count]; i++) {
        if([[searchBarSubViews objectAtIndex:i] isKindOfClass:[UITextField class]])
        {
            UITextField* search = (UITextField*)[searchBarSubViews objectAtIndex:i];
            if (IOS_NEWER_OR_EQUAL_TO_7) {
                [self setFrame:frame];
                [self setTintColor:[UIColor lightTextColor]];
                [search setBackgroundColor:[UIColor clearColor]];
                UIImageView *lImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
                lImageview.image = [UIImage imageNamed:@"Search.png"];
                    search.leftView = lImageview;
                    search.leftViewMode = UITextFieldViewModeAlways;
                    [self setBackgroundColor:[UIColor clearColor]];
                    [self setBackgroundImage:[UIImage imageNamed:@"searchwithouticon.png"]];
            }
            else {
            }
//            [search setBackground:[UIImage imageNamed:@"iPad_searchbg"]];
        }
    }
    [self reloadInputViews];
    if (self.tag == 1) {
        [self setPlaceholder:@"Search"];
    }else if(self.tag == 2) {
        [self setPlaceholder:@"Search"];
        [self setBackgroundImage:[UIImage imageNamed:@""]];
    }else if(self.tag == 3) {
        [self setPlaceholder:@"Services & Categories"];
    }else {
        [self setPlaceholder:@"Search"];
    }
    if (self.tag!=2) {
        [self setImage:[UIImage imageNamed:@"Search.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    }
    self.tintColor = [UIColor ASRProBlueColor];
    [self setHidden:NO];
    [self setKeyboardType:UIKeyboardTypeDefault];
    self.delegate = self;
}

#pragma mark --
#pragma mark Method for showing OverLay view.

- (void)showOverLayView {
    if (mOverLayView_ == nil) {
        UIView *lOverlayController = [[UIView alloc] init];
        
        UITapGestureRecognizer *lTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
        lTapGestureRecognizer.delegate = self;
        [lOverlayController addGestureRecognizer:lTapGestureRecognizer];
        mOverLayView_ = lOverlayController;
    }
    __block CGFloat yaxis;
	CGFloat width = 302.0f;
	__block CGFloat height = self.superview.frame.size.height;
    CGRect frame;
    
    [self.superview.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UITableView class]]) {
            UITableView *lTempTableView = object;
            yaxis = lTempTableView.frame.origin.y;
        }
    }];
    if (self.tag !=2) {
        frame = CGRectMake(0, 80, width, height);
        mOverLayView_.frame = frame;
    }else {
        frame = CGRectMake(0, self.frame.origin.y+self.frame.size.height, self.superview.frame.size.width, height);
        mOverLayView_.frame = frame;
    }
	mOverLayView_.backgroundColor = [UIColor grayColor];
	mOverLayView_.alpha = 0.5;
    
    if (self.tag == 1) {
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] view] addSubview:mOverLayView_];
        if ([[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_].mSearchCategory_ == SearchOpenRO) {
            
        }else {
            
        }
    }else if (self.tag == 2) {
        [[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] view] addSubview:mOverLayView_];
    }else if (self.tag == 3) {
        frame= [[[[SharedUtilities sharedUtilities] appDelegateInstance] mServicesViewController_] mServicesPackageTableViewController_].view.frame;
        frame.origin.y=0;
        mOverLayView_.frame = frame;

        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServicesViewController_] mServicesPackageTableViewController_].view addSubview:mOverLayView_];

    }else {
    }
}

- (void)removeOverLayView {
    if(mOverLayView_ != nil) {
        [mOverLayView_ removeFromSuperview];
        mOverLayView_ = nil;
    }
    
    if (self.tag == 1) {
        
        if ([[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_].mSearchCategory_ == SearchOpenRO ) {
            if ([self.text length] != 0) {
                
            }else {
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] setMOpenROListDisplayData_:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_ ] mOpenROListData_]];
                [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_] reloadData];
            }
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] resetAllData];

            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_].scrollEnabled = YES;
            
        }else {
            
        }
    }else if(self.tag == 2) {
        [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] setMSearchedDataArray:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_ ] mAllServicesArray_]];
        
        [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] mTableView].scrollEnabled = YES;
        
        [[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] mTableView] reloadData];
    }else if(self.tag == 3) {
    }else {
    }

}

#pragma mark --
#pragma mark Method for Resign key board.
// ----------------------------;
// Method to resign the key board and OverlayView;
// ----------------------------;
- (void)resignKeyboard {
    [self endEditing:TRUE];
    [mOverLayView_ removeFromSuperview];
    if (self.tag == 1) {
        
        if ([[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_].mSearchCategory_ == SearchOpenRO) {
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] setMOpenROListDisplayData_:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_ ] mOpenROListData_]];
            
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_].scrollEnabled = YES;
            
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_] reloadData];
        }else {
            
        }
    }else if(self.tag == 2) {
        
        [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] setMSearchedDataArray:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_ ] mAllServicesArray_]];
        
        [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] mTableView].scrollEnabled = YES;
        
        [[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] mTableView] reloadData];
    }else if(self.tag == 3) {
    }else {
    }
}

#pragma mark --
#pragma mark Search Bar Delegates

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    //    self.showsCancelButton = FALSE;
    // ----------------------------;
    // Method for resigning the key board;
    // ----------------------------;
    [self resignKeyboard];
    if (self.tag == 1) {

    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] showSearchlistViewOrHide:0 searchText:searchBar.text];
    }  if (self.tag == 3) {
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mServicesViewController_] mServicesPackageTableViewController_]->isSearching=FALSE;
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServicesViewController_] mServicesPackageTableViewController_].tableView reloadData];


    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    if (self.tag == 1) {
        
        if ([[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_].mSearchCategory_ == SearchOpenRO) {
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_].scrollEnabled = NO;
            [self searchTableView];
            
        }else {
            /*if([self findSearchedCustomerInAppointment:searchBar.text]) {
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_].mAppointmentAndInprocessTableView_ reloadData];
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] showSearchlistViewOrHide:0 searchText:searchBar.text];
            } else {*/
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] showSearchlistViewOrHide:1 searchText:@""];
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] requestForCustomerSearch:searchBar.text];
//            }
        }
    }else if (self.tag == 2) {
        [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] mTableView].scrollEnabled = NO;
        [self searchTableView];
    }
    
    [self removeOverLayView];
    [self resignFirstResponder];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //This method is called again when the user clicks back from the detail view.
	//So the overlay is displayed on the results, which is something we do not want to happen.
	
    //Add the overlay view.
    [self showOverLayView];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mBarCodeBtn_] setHidden:YES];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mBeginVehicleCheckInBtn_] setEnabled:NO];
	if (self.tag == 1) {
        if ([[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_].mSearchCategory_ == SearchOpenRO) {
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_].scrollEnabled = NO;

        }else {
            
        }
    }else if (self.tag == 2) {
        [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] mTableView].scrollEnabled = NO;
    }else if (self.tag == 3) {
        
    
        
    }else {
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mServicesViewController_] mServicesPackageTableViewController_]->isSearching=TRUE;
    }
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    
    
    if (self.tag == 1) {
        if ([[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_].mSearchCategory_ == SearchOpenRO) {
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_].scrollEnabled = NO;
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] resetAllData];

            [self searchTableView];
        }else {
            if([theSearchBar.text length]==0){
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] showSearchlistViewOrHide:0 searchText:searchText];
                
            } else if([theSearchBar.text length]==1){
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] showSearchlistViewOrHide:1 searchText:@""];
            }
        }
    }else if (self.tag == 2) {
        if ([[self text] length] == 0) {
            [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] setMSearchedDataArray:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_ ] mAllServicesArray_]];
        }
            [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] mTableView].scrollEnabled = NO;
            [self searchTableView];
    }
      if (self.tag == 3) {
          [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServicesViewController_] mServicesPackageTableViewController_] searchServicesWithText:searchText];
          [self searchTableView];

      }
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//    [self setText:@""];
    [self removeOverLayView];
    if (![[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mSearhBar_].text.length>0 && !([[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_]->mselectedSegment_==3)) {
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mBeginVehicleCheckInBtn_] setEnabled:YES];
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mBarCodeBtn_] setHidden:NO];
    }
}

#pragma mark --
#pragma mark PrivateMethods

// ----------------------------;
// Method which filter the table based on search text data;
// ----------------------------;
- (void) searchTableView {
    
    NSString *searchText = self.text;
    if(self.tag!=3){
    if ([searchText length]>0) {
        [self removeOverLayView];
        [self.superview.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            if ([object isKindOfClass:[UITableView class]]) {
                UITableView *lTempTableView = object;
                lTempTableView. scrollEnabled = YES;
            }
        }];
    }else {
        [self showOverLayView];
        [self.superview.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            if ([object isKindOfClass:[UITableView class]]) {
                UITableView *lTempTableView = object;
                lTempTableView. scrollEnabled = NO;
            }
        }];
    }
    }
    
    if (self.tag == 1) {
        
        if ([[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_].mSearchCategory_ == SearchOpenRO) {
            // ----------------------------;
            // NSMutableArray filtered data will be in -> mSearchedDataArray;
            // ----------------------------;
            
            NSMutableArray* lTempArray = [[NSMutableArray alloc] init];
            [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] setMOpenROListDisplayData_:lTempArray];
            // ----------------------------;
            // Filtering the data using search text looking if the search text is in [RONumber,FirstName,LastName,Year,Make,Model];
            // ----------------------------;
            
            for (int i = 0; i < [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] count]; i++)
            {
                NSString *searchString = [[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] objectAtIndex:i] valueForKey:@"RONumber"] stringByAppendingString:[self returnStringWithFirstName:[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] objectAtIndex:i] valueForKey:@"Customer"] valueForKey:@"FirstName"] Lastname:[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] objectAtIndex:i] valueForKey:@"Customer"] valueForKey:@"LastName"] VehicleYear:[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] objectAtIndex:i] valueForKey:@"Vehicle"] valueForKey:@"Year"] Vehiclemake:[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] objectAtIndex:i] valueForKey:@"Vehicle"] valueForKey:@"Make"] VehicleModel:[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] objectAtIndex:i] valueForKey:@"Vehicle"] valueForKey:@"Model"]]];
                
                NSString *tagnumber = ([[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] objectAtIndex:i] valueForKey:@"TagNumber"]) != nil ?[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] objectAtIndex:i] valueForKey:@"TagNumber"] :@"";
                
                searchString = [searchString stringByAppendingString:tagnumber];
                
                NSRange titleResultsRange = [searchString rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if (titleResultsRange.length > 0) {
                    [lTempArray addObject:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] objectAtIndex:i]];
                }
            }
            
            // ----------------------------;
            // If the search text is empty then show the list based on the Current mode;
            // ----------------------------;
            
            if ([self.text length] == 0) {
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] setMOpenROListDisplayData_:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] mOpenROListData_] mutableCopy]];
            }else {
                //            [[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForRepairOrderModes_].mIsSearchingShowAllRos_ = TRUE;
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] setMOpenROListDisplayData_:lTempArray];
            }
            
            // ----------------------------;
            // Reload the TableView based in the search text;
            // ----------------------------;
            [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_] reloadData];
        }
        
    }else if (self.tag == 2) {
        
            // ----------------------------;
            // NSMutableArray filtered data will be in -> mSearchedDataArray;
            // ----------------------------;
            
            NSMutableArray* lTempArray = [[NSMutableArray alloc] init];
            [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] setMSearchedDataArray:lTempArray];
            // ----------------------------;
            // Filtering the data using search text looking if the search text is in [RONumber,FirstName,LastName,Year,Make,Model];
            // ----------------------------;
            
            for (int i = 0; i < [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAllServicesArray_] count]; i++)
            {
                NSString *searchString = [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAllServicesArray_] objectAtIndex:i] valueForKey:@"ServiceName"];
                
                NSRange titleResultsRange = [searchString rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if (titleResultsRange.length > 0) {
                    [lTempArray addObject:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAllServicesArray_] objectAtIndex:i]];
                }
            }
            
            // ----------------------------;
            // If the search text is empty then show the list based on the Current mode;
            // ----------------------------;
            
            if ([self.text length] == 0) {
                [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] setMSearchedDataArray:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAllServicesArray_] mutableCopy]];
            }else {
                [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] setMSearchedDataArray:lTempArray];
            }
            
            // ----------------------------;
            // Reload the TableView based in the search text;
            // ----------------------------;
        
            [[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAddServicesViewController_] mServicesListTableViewController_] mTableView] reloadData];
        
    }else if (self.tag == 3) {
        
        // ----------------------------;
        // NSMutableArray filtered data will be in -> mSearchedDataArray;
        // ----------------------------;
        
        NSMutableArray* lTempArray = [[NSMutableArray alloc] init];
        // ----------------------------;
        // Filtering the data using search text looking if the search text is in [RONumber,FirstName,LastName,Year,Make,Model];
        // ----------------------------;
        
        for (int i = 0; i < [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAllServicesArray_] count]; i++)
        {
            
            
            NSRange titleResultsRange = [[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAllServicesArray_] objectAtIndex:i] objectForKey:@"ServiceName"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (titleResultsRange.length > 0) {
                [lTempArray addObject:[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServiceDataGetter_] mAllServicesArray_] objectAtIndex:i]];
            }
        }
        
        // ----------------------------;
        // If the search text is empty then show the list based on the Current mode;
        // ----------------------------;
        
        // ----------------------------;
        // Reload the TableView based in the search text;
        // ----------------------------;
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServicesViewController_] mServicesPackageTableViewController_] setSrcData:lTempArray];
        
        [[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mServicesViewController_] mServicesPackageTableViewController_] tableView] reloadData];

        
    }else {
        
    }
    
}

//--------------------------------------------------- ************** ------------------------------------------------------
//             *** This method is used to find the wheather searched customer in the appointment or not ***
//--------------------------------------------------- ************** ------------------------------------------------------
- (BOOL)findSearchedCustomerInAppointment:(NSString *)searchValue {
    NSString *predFormat=[NSString stringWithFormat:@"SELF.Customer.FirstName LIKE[c] '%@' OR SELF.Customer.MiddleName LIKE[c] '%@' OR SELF.Customer.LastName LIKE[c] '%@' OR SELF.Customer.CellPhone LIKE[c] '%@' OR SELF.Customer.HomePhone LIKE[c] '%@' OR SELF.Customer.WorkPhone LIKE[c] '%@' OR SELF.Vehicle.License LIKE[c] '%@' OR SELF.Vehicle.VIN LIKE[c] '%@'",searchValue,searchValue,searchValue,searchValue,searchValue,searchValue,searchValue,searchValue]; //LIKE // OR SELF.CustomerName CONTAINS[c] '%@'
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predFormat];
    NSArray *tempData = [[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mAppointmentListData_ filteredArrayUsingPredicate:predicate];
    if([tempData count]>0) {
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mAppointmentsData_] removeAllObjects];
        [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mAppointmentsData_] addObjectsFromArray:tempData];
        return YES;
    } else {
        return NO;
    }
}

- (NSString *)returnStringWithFirstName:(NSString *)aFirstName Lastname:(NSString *)aLastName VehicleYear:(NSString *)aVehileYear Vehiclemake:(NSString *)aVehileMake VehicleModel:(NSString *)aVehileModel {
    
     aFirstName = (aFirstName!=nil)?aFirstName:@"";
     aLastName = (aLastName!=nil)?aLastName:@"";
    aVehileYear = (aVehileYear != nil) ?aVehileYear :@"";
    aVehileMake = (aVehileMake != nil) ?aVehileMake :@"";
    aVehileModel = (aVehileModel != nil) ?aVehileModel :@"";
    aVehileModel = [aVehileModel stringByReplacingOccurrencesOfString:@"amp;" withString:@""];
    NSString *returnStr=@"";
    returnStr = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",aFirstName,aLastName,aVehileYear,aVehileMake,aVehileModel];
    
    return returnStr;
}

@end
