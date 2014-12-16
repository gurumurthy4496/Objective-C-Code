//
//  ModelForSearchScreen.m
//  ASRPro
//
//  Created by Santosh Kvss on 2/10/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForSearchScreen.h"

@implementation ModelForSearchScreen

- (void)getInprocessListFromRepairOrders {

    int CurrentMode = 9;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.CurrentMode = %d",CurrentMode];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mInprocessListData_ = (NSMutableArray*)[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mRepairOrdersData_ filteredArrayUsingPredicate:predicate];
    DLog(@"Inprocess List : %@",[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mInprocessListData_);
    predicate = [NSPredicate predicateWithFormat:@"NOT SELF.CurrentMode = %d",CurrentMode];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListData_ = (NSMutableArray*)[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mRepairOrdersData_ filteredArrayUsingPredicate:predicate];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ = [self filterArrayForTechnician];
}

- (NSString*)getAdvisorForOpenRO:(int)advisorID {
    NSString *lAdvisorStr;
        for (int j=0; j<[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] count]; j++) {
            if (advisorID == [[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] objectAtIndex:j] objectForKey:@"ID"] intValue]) {
                    lAdvisorStr = [NSString stringWithFormat:@"%@%@",[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] objectAtIndex:j] objectForKey:@"FirstName"],[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] objectAtIndex:j] objectForKey:@"LastName"] substringToIndex:1]];
                
                
            }
    }
    DLog(@"Advisors name %@",lAdvisorStr);
    lAdvisorStr = lAdvisorStr!=nil?lAdvisorStr:@"";
    return lAdvisorStr;
}

- (NSString*)getTechnicianForOpenRO:(int)technicianID {
    NSString *lTechnicianStr;
        for (int j=0; j<[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] count]; j++) {
            if (technicianID == [[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] objectAtIndex:j] objectForKey:@"ID"] intValue]) {
                lTechnicianStr = [NSString stringWithFormat:@"%@%@",[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] objectAtIndex:j] objectForKey:@"FirstName"],[[[[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeesDataArray_] objectAtIndex:j] objectForKey:@"LastName"] substringToIndex:1]];
            }
    }
    DLog(@"Technician name %@",lTechnicianStr);
    lTechnicianStr = lTechnicianStr!=nil?lTechnicianStr:@"";
    return lTechnicianStr;
}

- (void)setTopNavigationBarHiddenForOpenROScreen :(UIView *)aView Hidden:(BOOL)aHidden Button:(UIButton *)aButton {
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] setTempararyPRERONumber:@""];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] setPRERONumber:@""];
    [aView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        UIView *view = (UIView *)object;
        if (view.tag == 1) {
            __block UIImageView *imageView;
            [view.subviews enumerateObjectsUsingBlock:^(id object1, NSUInteger index1, BOOL *stop1) {
                
                
                
                UIButton *button = (UIButton *)object1;
                imageView = (UIImageView *)object1;
//                if (button.hidden && aHidden ) {
//                    *stop = YES;
//                    *stop1 = YES;
//                    return ;
//                }
                
                if (button.tag == 1 || button.tag == 2 || button.tag == 3 || button.tag == 4 ) {
                    [button setHidden:aHidden];
                }else if(imageView.tag == 9){
                    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeType_ isEqualToString:@"Technician"]) {
                        [imageView setHidden:!aHidden];
                       
                    }else {
                        if (aHidden) {//Add TempButton(<Search) on the headerview
                            
                            [view.subviews enumerateObjectsUsingBlock:^(id object2, NSUInteger index2, BOOL *stop2) {
                                UIButton *button = object2;
                                UILabel *label = object2;
                                if (button.tag == 101 && [button superview]) {
                                    [button removeFromSuperview];
                                }
                                if (label.tag == 102 && [label superview]) {
                                    [label removeFromSuperview];
                                }
                            }];

                            
                            UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
                            CGRect frame = imageView.frame;
//                            frame.size.width -= 30;
//                            frame.origin.x -= 20;
                            [searchButton setFrame:frame];
                            [searchButton setTitle:@" Search" forState:UIControlStateNormal];
                            [searchButton setTitle:@" Search" forState:UIControlStateSelected];
                            [searchButton setImage:imageView.image forState:UIControlStateNormal];
                            [searchButton setImage:imageView.image forState:UIControlStateSelected];
                            [searchButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateNormal];
                            [searchButton setTitleColor:[UIColor ASRProBlueColor] forState:UIControlStateSelected];
                            [searchButton.titleLabel setFont:[UIFont regularFontOfSize:17 fontKey:kFontNameOpenSansKey]];
                            [searchButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 2)];
                            [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                            [searchButton setTag:101];
                            [view addSubview:searchButton];
                            
                            /*CGRect RoLabelFrame = view.frame;
                            RoLabelFrame.origin.x = (view.frame.size.width- 200)/2;
                            RoLabelFrame.origin.y = (view.frame.size.height - 30)/2;
                            RoLabelFrame.size.width = 200;
                            RoLabelFrame.size.height = 30;
        
                            UILabel *RONumberLabel = [[UILabel alloc] init];
                            [RONumberLabel setFrame:RoLabelFrame];
                            [RONumberLabel setText:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForVehicleHistoryTableView_].mOpenROString_];
                            [RONumberLabel setTextColor:[UIColor ASRProBlueColor]];
                            [RONumberLabel setTextAlignment:NSTextAlignmentCenter];
                            [RONumberLabel setTag:102];
                            [RONumberLabel setHidden:YES];
                            [view addSubview:RONumberLabel];*/
                            
                            [view.subviews enumerateObjectsUsingBlock:^(id object3, NSUInteger index3, BOOL *stop3) {
                                DLog(@"%@",object3);
                            }];
                        }else {
                            [aButton setHidden:YES];
                            [aButton removeFromSuperview];
                        }
                    }
                    CGRect RoLabelFrame = view.frame;
                    RoLabelFrame.origin.x = (view.frame.size.width- 200)/2;
                    RoLabelFrame.origin.y = (view.frame.size.height - 30)/2;
                    RoLabelFrame.size.width = 200;
                    RoLabelFrame.size.height = 30;
                    UILabel *RONumberLabel = [[UILabel alloc] init];
                    [RONumberLabel setFrame:RoLabelFrame];
                    [RONumberLabel setText:[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForVehicleHistoryTableView_].mOpenROString_];
                    [RONumberLabel setTextColor:[UIColor ASRProBlueColor]];
                    [RONumberLabel setTextAlignment:NSTextAlignmentCenter];
                    [RONumberLabel setTag:102];
                    [RONumberLabel setHidden:YES];
                    [view addSubview:RONumberLabel];
                  
                }
            }];
        }
    }];
}

- (IBAction)searchButtonAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    [self setTopNavigationBarHiddenForOpenROScreen:button.superview.superview Hidden:NO Button:button];
    for (UIView *lview in [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.view.subviews) {
        if([lview isKindOfClass:[UIButton class]]) {
            if(((UIButton *)lview).tag==2){
                [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_->mselectedSegment_ = lview.tag;
                [(UIButton *)lview setSelected:YES];
                [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] segmentBtnAction:(UIButton *)lview];
                [(UIButton *)lview setBackgroundColor:[UIColor ASRProBlueColor]];
            } else {
                [(UIButton *)lview setSelected:NO];
                [(UIButton *)lview setBackgroundColor:[UIColor whiteColor]];
            }
            [(UIButton *)lview setEnabled:YES];
        }
    }
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_] setHidden:TRUE];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROFilterButton_] setHidden:TRUE];

    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mAppointmentAndInprocessTableView_] setHidden:FALSE];
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mAppointmentAndInprocessTableView_] reloadData];
}

- (void)filterTheDataBasedOnmode :(int)aSelectedMode {
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mSearhBar_] setText:@""];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] resetAllData];
    if (aSelectedMode == 0) {
        
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchDataGetter_] setMOpenROListDisplayData_:[self filterArrayForTechnician]];
         [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_] reloadData];
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] enableOrdisableEditCustomerOrVehiclebtn];
        return;
    }
    NSMutableArray *mRepairOrderCurrentModeListArray_ = [[NSMutableArray alloc] init];
    
    NSMutableArray * mRepairOrderListMutableCopy_ = [self filterArrayForTechnician];
    
    NSPredicate *lCurrentModePredicate = [NSPredicate predicateWithFormat:@"CurrentMode=%d",aSelectedMode];
    
    NSArray *lTempArray = [mRepairOrderListMutableCopy_ filteredArrayUsingPredicate:lCurrentModePredicate];
    
    [mRepairOrderCurrentModeListArray_ addObjectsFromArray:lTempArray];
    
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ = mRepairOrderCurrentModeListArray_;
    [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mMasterViewController_] mOpenROTableView_] reloadData];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.mOpenROTableView_.mselectedCustomerindex_ = 0;
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mSearchViewController_] enableOrdisableEditCustomerOrVehiclebtn];
}

- (void)getSelectedModeName:(NSString *)aModename {
    int selectedMode;
   if ([aModename isEqualToString:@"Dispatch"]) {
        selectedMode = 2;
    }else if ([aModename isEqualToString:@"Inspection"]) {
        selectedMode = 3;
    }else if ([aModename isEqualToString:@"Approval"]) {
        selectedMode = 4;
    }else if ([aModename isEqualToString:@"Repair"]) {
        selectedMode = 6;
    }else if ([aModename isEqualToString:@"Review"]) {
        selectedMode = 7;
    }else {
        selectedMode = 0;
    }
    [self filterTheDataBasedOnmode:selectedMode];
}

- (NSMutableArray*)filterArrayForTechnician {
    NSPredicate *predicate;
    NSMutableArray *lFilteredArray = [[NSMutableArray alloc] init];
    if ([[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeeType_] isEqualToString:@"Technician"]) {
        predicate = [NSPredicate predicateWithFormat:@"SELF.TechnicianID = %d OR SELF.TechnicianID == nil",[[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeID_ intValue]];
        lFilteredArray = (NSMutableArray*)[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListData_ filteredArrayUsingPredicate:predicate];
    }else if ([[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_] mEmployeeType_] isEqualToString:@"Advisor"]) {
        predicate = [NSPredicate predicateWithFormat:@"SELF.AdvisorID = %d OR SELF.AdvisorID == nil",[[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeID_ intValue]];
        lFilteredArray = (NSMutableArray*)[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListData_ filteredArrayUsingPredicate:predicate];
    }else
        lFilteredArray = [[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListData_ mutableCopy];
    return lFilteredArray;
}

// ----------------------------;
// thread request for VINDecoder;
// ----------------------------;

- (void)threadRequestForVINDecoderForAddVehicle:(NSString *)aVIN {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr=[NSString stringWithFormat:@"%@/VinDecoder/%@",WEBSERVICEURL,aVIN];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestForVINDecoderForAddVehicle:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

// ----------------------------;
// thread request for Advanced Customer Search;
// ----------------------------;

- (void)threadRequestForAdvancedCustomerSearchInfo:(NSString *)searchString {
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        if ([[[SharedUtilities sharedUtilities] appDelegateInstance].mViewReference_ isKindOfClass:[BeginVehicleCheckInViewViewController class]] || [[[SharedUtilities sharedUtilities] appDelegateInstance].mViewReference_ isKindOfClass:[EditCustomerViewController class]]) {
        }else
            [[SharedUtilities sharedUtilities] createLoadView];
        NSString *mRequestStr=[NSString stringWithFormat:@"%@%@%@/Search?%@",WEBSERVICEURL,@"Stores/",[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mStoreID_,searchString];
        
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [NSThread detachNewThreadSelector:@selector(requestForAdvancedSearchCustomerInfo:) toTarget:self withObject: mRequestStr];
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        return;
    }
}

#pragma mark --
#pragma mark backGround Thread Request Methods

// ----------------------------;
// Method to get make, model and year based on VIN;
// ----------------------------;
- (void)requestForVINDecoderForAddVehicle:(NSObject *)myObject {
    
    NSError *jsonError;
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kGET];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"VIN Decoder RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    if (responseCode == ASRProNotFoundStatusCode) {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:@"Error" message:json_string];
    }
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mVINDecoderResponseData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                options:kNilOptions error:&jsonError];
    DLog(@"VIN Decoder Data Array :-%@",[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mVINDecoderResponseData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForVINDecoderForAddVehicle:) withObject:responseCodeStr waitUntilDone:NO];
}

// ----------------------------;
// Method to get advanced search customer info;
// ----------------------------;
- (void)requestForAdvancedSearchCustomerInfo: (NSObject *) myObject {
    
    NSError *jsonError;
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kGET];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"Advanced Search Customer RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mAdvancedSearchData_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&jsonError];
        DLog(@"Advanced Search Customer Data Array :-%@",[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mAdvancedSearchData_);
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForAdvancedSearchCustomer:) withObject:responseCodeStr waitUntilDone:NO];
}

#pragma mark --
#pragma mark backGround Thread Succes Methods

- (void)onSuccessForVINDecoderForAddVehicle:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditVehicleScreen_ setMMake_:[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mVINDecoderResponseData_ valueForKey:@"MAKE"]];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditVehicleScreen_ setMModel_:[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mVINDecoderResponseData_ valueForKey:@"MODEL"]];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForEditVehicleScreen_ setMYear_:[NSString stringWithFormat:@"%@",[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mVINDecoderResponseData_ valueForKey:@"YEAR"]]];
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mEditVehicleViewController_ setValuesToViews];
    }
}

- (void)onSuccessForAdvancedSearchCustomer:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
            [[[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_ reloadAdvancedSearchTableData];
     /*       if ([[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mAdvancedSearchData_ valueForKey:@"Customers"] count] != 0) {
                for (int i=0; i<[[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mAdvancedSearchData_ valueForKey:@"Customers"] count]; i++) {
                    if ([[[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_.mFirstName_ isEqualToString:[[[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mAdvancedSearchData_ valueForKey:@"Customers"] objectAtIndex:i] objectForKey:@"FirstName"]] && [[[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_.mLastName_ isEqualToString:[[[[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mAdvancedSearchData_ valueForKey:@"Customers"] objectAtIndex:i] objectForKey:@"LastName"]]) {
                        [[[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_.mAdvancedSearchTableView_  selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
                        [[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_.mAdvancedSearchTableView_.mselectedCustomerindex_ = i;
                        [[[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_.mAdvancedSearchTableView_ onSelectionOfAdvancedSearchCustomer];
                    }
                }
        }*/
    }else
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mBeginVehicleCheckInView_ errorResponseForCustomerSearch];
}

@end
