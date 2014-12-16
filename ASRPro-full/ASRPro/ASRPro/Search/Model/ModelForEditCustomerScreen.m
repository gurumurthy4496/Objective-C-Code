//
//  ModelForEditCustomerScreen.m
//  ASRPro
//
//  Created by Santosh Kvss on 1/31/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "ModelForEditCustomerScreen.h"

@implementation ModelForEditCustomerScreen

- (void)setValues:(NSMutableDictionary*)aCustomerDictionary {
    DLog(@"%@",aCustomerDictionary);
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    /**----------------------------- Customer Details ----------------------------------*/
    self.mCustomerID_=[aCustomerDictionary objectForKey:@"ID"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"ID"]]:@"";
    [mAppDelegate_.mModelForSearchScreen_ setMCustomerID_:[aCustomerDictionary objectForKey:@"ID"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"ID"]]:@""];
    self.mSalutation_ = [aCustomerDictionary objectForKey:@"Salutation"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"Salutation"]]:@"";
    self.mFirstName_=[aCustomerDictionary objectForKey:@"FirstName"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"FirstName"]]:@"";
    self.mMiddleName_=[aCustomerDictionary objectForKey:@"MiddleName"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"MiddleName"]]:@"";
    self.mLastName_=[aCustomerDictionary objectForKey:@"LastName"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"LastName"]]:@"";
    NSDate* lDate  =[mAppDelegate_.mMasterViewController_ mfDateFromDotNetJSONString:[aCustomerDictionary objectForKey:@"DOB"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"DOB"]]:@""];
    
    NSDateFormatter *lDateFormat_ = [[NSDateFormatter alloc] init];
    
    [lDateFormat_ setDateFormat:@"dd/MM/yyyy"];
    
    self.mDOB_=(([lDateFormat_ stringFromDate:lDate]==nil)||([[lDateFormat_ stringFromDate:lDate] isEqualToString:@"01/01/1900"]))?@"":[lDateFormat_ stringFromDate:lDate];
    
    self.mEmail_=[aCustomerDictionary objectForKey:@"Email"]!=nil?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"Email"]]:@"";
    self.mHomePhone_=[aCustomerDictionary objectForKey:@"HomePhone"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"HomePhone"]]:@"";
    self.mWorkPhone_=[aCustomerDictionary objectForKey:@"WorkPhone"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"WorkPhone"]]:@"";
    self.mMobilePhone_=[aCustomerDictionary objectForKey:@"CellPhone"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"CellPhone"]]:@"";
    self.mAddress1_=[aCustomerDictionary objectForKey:@"Address1"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"Address1"]]:@"";
    self.mAddress2_=[aCustomerDictionary objectForKey:@"Address2"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"Address2"]]:@"";
    self.mCountry_=[aCustomerDictionary objectForKey:@"Country"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"Country"]]:@"";
    self.mState_=[aCustomerDictionary objectForKey:@"State"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"State"]]:@"";
    self.mCity_=[aCustomerDictionary objectForKey:@"City"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"City"]]:@"";
    self.mZipCode_=[aCustomerDictionary objectForKey:@"Zip"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"Zip"]]:@"";
    self.mCustomerNumber_ = [aCustomerDictionary objectForKey:@"Number"]!=nil ?[NSString stringWithFormat:@"%@",[aCustomerDictionary objectForKey:@"Number"]]:@"";
    self.mSMS_ = [aCustomerDictionary objectForKey:@"CanContactSMS"]!=nil?[[aCustomerDictionary objectForKey:@"CanContactSMS"] boolValue]:FALSE;
    self.mContactEmail_ = [aCustomerDictionary objectForKey:@"CanContactEmail"]!=nil?[[aCustomerDictionary objectForKey:@"CanContactEmail"] boolValue]:FALSE;
    self.mPhone_ = [aCustomerDictionary objectForKey:@"CanContactPhone"]!=nil?[[aCustomerDictionary objectForKey:@"CanContactPhone"] boolValue]:FALSE;
}

-(void)resetallData {
    
    // pass parameters in all cases
    self.mSalutation_=@"";
    self.mFirstName_=@"";
    self.mLastName_=@"";
    self.mMiddleName_=@"";
    self.mDOB_=@"";
    self.mAnniversaryDate_=@"";
    self.mWorkPhone_=@"";
    self.mHomePhone_ = @"";
    self.mMobilePhone_=@"";
    self.mEmail_=@"";
    self.mAddress1_=@"";
    self.mAddress2_=@"";
    self.mCountry_=@"";
    self.mState_=@"";
    self.mCity_=@"";
    self.mZipCode_=@"";
    self.mCustomerNumber_=@"";
    self.mCustomerID_ = @"";
    self.mSMS_ = FALSE;
    self.mContactEmail_ = FALSE;
    self.mPhone_ = FALSE;
}

@end
