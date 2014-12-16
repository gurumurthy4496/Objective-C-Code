//
//  ParserMethods.m
//  Medifast
//
//  Created by Value Labs on 14/09/12.
//  Copyright (c) 2012 ValueLabs. All rights reserved.
//

#import "ParserMethods.h"
#import "WebEngine.h"
#import "ResponseMethods.h"

@implementation ParserMethods

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    }
    
    return self;
    
}

- (void)parseLogin {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                              encoding:NSUTF8StringEncoding];
    DLog(@"Login response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mModelForSplashScreen_.mLoginDataArray_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                          options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPRION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"Login Array :-%@", mAppDelegate_.mModelForSplashScreen_.mLoginDataArray_);

    }
    
}

- (void)parseAppointmentList {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"Appointment List response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                            options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPTION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
        mAppDelegate_.mSearchDataGetter_.mAppointmentListData_ = [jsonArray mutableCopy];
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"Appointments List Array :-%@", mAppDelegate_.mSearchDataGetter_.mAppointmentListData_);
    }
}

- (void)parseRepairOrders {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"Repair Orders response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mSearchDataGetter_.mRepairOrdersData_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                             options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPTION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"Repair Orders Array :-%@", mAppDelegate_.mSearchDataGetter_.mRepairOrdersData_);
    }
}

- (void)parseSearchCustomerData {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"Search Customer response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                          options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPTION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"Search Customer Array :-%@", mAppDelegate_.mSearchDataGetter_.mSearchedCustomerListData_);
    }
}

- (void)parseCustomerDetails {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"Customer Details response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mSearchDataGetter_.mCustomerDetailsData_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                          options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPTION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"Customer Details Array :-%@", mAppDelegate_.mSearchDataGetter_.mCustomerDetailsData_);
    }
}

- (void)parseAddCustomerDetails {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"Customer Details response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mSearchDataGetter_.mCustomerDetailsData_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                             options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPTION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"Customer Details Array :-%@", mAppDelegate_.mSearchDataGetter_.mCustomerDetailsData_);
    }
    [mAppDelegate_.mModelForEditCustomerScreen_ setMCustomerID_:[mAppDelegate_.mSearchDataGetter_.mCustomerDetailsData_ valueForKey:@"ID"]];
    [mAppDelegate_.mModelForSearchScreen_ setMTempCustomerID_:[mAppDelegate_.mSearchDataGetter_.mCustomerDetailsData_ valueForKey:@"ID"]];
    [mAppDelegate_.mModelForEditCustomerScreen_.mCustomerID_ stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [mAppDelegate_.mModelForSearchScreen_.mTempCustomerID_ stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

- (void)parseAddVehicleDetails {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"Vehicle Details response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mSearchDataGetter_.mVehicleDetailsData_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                             options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPTION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"Vehicle Details Array :-%@", mAppDelegate_.mSearchDataGetter_.mVehicleDetailsData_);
    }
    [mAppDelegate_.mModelForEditVehicleScreen_ setMVehicleID_:[mAppDelegate_.mSearchDataGetter_.mVehicleDetailsData_ valueForKey:@"VehicleID"]];
    [mAppDelegate_.mModelForSearchScreen_ setMVehicleID_:[mAppDelegate_.mSearchDataGetter_.mVehicleDetailsData_ valueForKey:@"VehicleID"]];
}

- (void)parseVehicleDetails {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"Vehicle Details response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mSearchDataGetter_.mVehicleDetailsData_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                             options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPTION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"Vehicle Details Array :-%@", mAppDelegate_.mSearchDataGetter_.mVehicleDetailsData_);
    }
}

- (void)parseVehicleCheckIn {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    // Convert to JSON object:
    mAppDelegate_.mSearchDataGetter_.mVehicleCheckInData_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                          options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPTION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
    }
    else {
    }
    [mAppDelegate_.mModelForWalkAround_ setTempararyPRERONumber:[mAppDelegate_.mSearchDataGetter_.mVehicleCheckInData_ valueForKey:@"RONumber"]];
}

- (void)parseAppointmentsVehicleHistory {

    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    
    // Convert to JSON object:
    mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                        options:kNilOptions error:&jsonError];
//    if(mAppDelegate_.mWebEngine_->webData && jsonError)
//        [NSException raise:NSInvalidArgumentException format:@"EXCEPRION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
    }
    else {
        DLog(@"Vehicle History Array :-%@", mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_);
    }
}

- (void)parseGetServiceLines {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"GetServicelines response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ = [[NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                        options:kNilOptions error:&jsonError] mutableCopy];
    mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_ =[[mAppDelegate_.mModelForWalkAround_.mRepairOrderDetailsArray_ valueForKey:@"RepairOrderLines"] mutableCopy];
    [mAppDelegate_.mServiceDataGetter_ filterLines: mAppDelegate_.mServiceDataGetter_.mSelectedServicesArray_];
    
//    if(mAppDelegate_.mWebEngine_->webData && jsonError)
//        [NSException raise:NSInvalidArgumentException format:@"EXCEPRION :Request parameters couldn't be serialized into JSON."];
//    
//    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
//    
//    if ([jsonObject isKindOfClass:[NSArray class]]) {
//        DLog(@"CAUTION :-PLEASE LOOK its an array!");
//        NSArray *jsonArray = (NSArray *)jsonObject;
//        DLog(@"JSON Array - %@",jsonArray);
//    }
//    else {
//        DLog(@"PLEASE LOOK its probably a dictionary");
//        DLog(@"GetServicelines Array :-%@", mAppDelegate_.mServiceDataGetter_.mRecommendedServicesArray_);
//        
//    }

}

- (void)parseOpenROGetServiceLines {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"GetServicelines response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mOpenRoServiceDataGetter_.mSelectedServicesArray_ = [[NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                options:kNilOptions error:&jsonError] mutableCopy];
    [mAppDelegate_.mOpenRoServiceDataGetter_ filterLines: mAppDelegate_.mOpenRoServiceDataGetter_.mSelectedServicesArray_];
    
    //    if(mAppDelegate_.mWebEngine_->webData && jsonError)
    //        [NSException raise:NSInvalidArgumentException format:@"EXCEPRION :Request parameters couldn't be serialized into JSON."];
    //
    //    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    //
    //    if ([jsonObject isKindOfClass:[NSArray class]]) {
    //        DLog(@"CAUTION :-PLEASE LOOK its an array!");
    //        NSArray *jsonArray = (NSArray *)jsonObject;
    //        DLog(@"JSON Array - %@",jsonArray);
    //    }
    //    else {
    //        DLog(@"PLEASE LOOK its probably a dictionary");
    //        DLog(@"GetServicelines Array :-%@", mAppDelegate_.mServiceDataGetter_.mRecommendedServicesArray_);
    //        
    //    }
    
}

- (void)parseInspectionItems {
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"GetServicelines response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionItemsArray_ = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                   options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPRION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"GetServicelines Array :-%@",  mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionItemsArray_);
        
    }
    
}
-(void)parseAddService{
    
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"GetServicelines response :-%@",response);
    
    // Convert to JSON object:
       NSMutableDictionary* ldict = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                   options:kNilOptions error:&jsonError];
    mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_ =[NSString stringWithFormat:@"%@",[ldict objectForKey:@"ASRLID"]];

    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPRION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"GetServicelines Array :-%@", mAppDelegate_.mServiceDataGetter_.mRecommendedServicesArray_);
        
    }
    
}

-(void)parseCompleteInspectionDetails{
    NSError *jsonError;
    
    NSString *response = [[NSString alloc] initWithBytes: [mAppDelegate_.mWebEngine_->webData mutableBytes]
                                                  length:[ mAppDelegate_.mWebEngine_->webData length]
                                                encoding:NSUTF8StringEncoding];
    DLog(@"GetServicelines response :-%@",response);
    
    // Convert to JSON object:
    mAppDelegate_.mOpenROInspectionDataGetter_.mCompleteInspectionDetailsDict_  = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding]   options:kNilOptions error:&jsonError];
    if(mAppDelegate_.mWebEngine_->webData && jsonError)
        [NSException raise:NSInvalidArgumentException format:@"EXCEPRION :Request parameters couldn't be serialized into JSON."];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:mAppDelegate_.mWebEngine_->webData options:kNilOptions error:&jsonError];
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        DLog(@"CAUTION :-PLEASE LOOK its an array!");
        NSArray *jsonArray = (NSArray *)jsonObject;
        DLog(@"JSON Array - %@",jsonArray);
    }
    else {
        DLog(@"PLEASE LOOK its probably a dictionary");
        DLog(@"GetServicelines Array :-%@",  mAppDelegate_.mOpenROInspectionDataGetter_.mCompleteInspectionDetailsDict_);
        
    }
    
    
}


@end
