//
//  ModelForSplashScreen.m
//  ASRPro
//
//  Created by GuruMurthy on 23/09/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//


#import "ModelForSplashScreen.h"


@interface ModelForSplashScreen () {
    
}
- (void)resetDataValues;
- (void)setDataValues;
@end


@implementation ModelForSplashScreen
@synthesize mUserName_;
@synthesize mPassword_;
@synthesize mStoreID_;
@synthesize mStoreIDWithContext_;
@synthesize mEmployeeName_;
@synthesize mEmployeeType_;
@synthesize mEmployeeID_;
@synthesize mLoginDataArray_;
@synthesize mEmployeesDataArray_;
@synthesize mUserRole_;

- (void)setDataValues {
    
}

- (void)resetDataValues {
    [self setMUserName_:@""];
    [self setMPassword_:@""];
    [self setMStoreID_:@""];
    [self setMStoreIDWithContext_:@""];
    [self setMEmployeeName_:@""];
    [self setMEmployeeType_:@""];
    [self setMEmployeeID_:@""];
    [self setMUserRole_:@""];
    [self setMLoginDataArray_:nil];
    [self setMEmployeesDataArray_:nil];
}

// ----------------------------;
// Method to store EmployeeID,StoreID,EmployeeType of LoginUser;
// ----------------------------;
- (void)StoreUserDetailsEmployeeID:(NSString*)aEmpID
                           StoreID:(NSString*)aStoreID
                      EmployeeType:(NSString *)aEmpType {
    [self setMEmployeeID_:aEmpID];
    [self setMStoreID_:aStoreID];
    [self setMEmployeeType_:aEmpType];
}

// ----------------------------;
// Method to find role of LoginUser;
// ----------------------------;
- (void)toFindRoleOfLoginUser {
    
    NSString *userNameSTR = [[[self.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"EmployeeType"] objectForKey:@"Acronym"];
    self.mEmployeeName_ = [[self.mLoginDataArray_ objectForKey:@"Employee"] objectForKey:@"FirstName"];
    
    userNameSTR = [userNameSTR substringFromIndex: [userNameSTR length] - 1];
    
 	NSRange titleResultsRange = [userNameSTR rangeOfString:@"a" options:NSCaseInsensitiveSearch];
    
    if (titleResultsRange.length > 0)//CurrentMode
    {
        self.mUserRole_ = @"Advisor";
    }
    titleResultsRange = [userNameSTR rangeOfString:@"t" options:NSCaseInsensitiveSearch];
    
    if (titleResultsRange.length > 0)
    {
        self.mUserRole_ = @"Technician";
    }
    titleResultsRange = [userNameSTR rangeOfString:@"p" options:NSCaseInsensitiveSearch];
    
    if (titleResultsRange.length > 0)
    {
        self.mUserRole_ = @"Parts";
    }
    titleResultsRange = [userNameSTR rangeOfString:@"m" options:NSCaseInsensitiveSearch];
    
    if (titleResultsRange.length > 0)
    {
        self.mUserRole_ = @"Manager";
    }
    
    if([self.mUserRole_ isEqualToString:@"Manager"])
    {
        
    } else if([self.mUserRole_ isEqualToString:@"Advisor"]) {
        
    } else if([self.mUserRole_ isEqualToString:@"Technician"]) { // this is the case for the advisor and technician
        
    } else { // nothing to do display whole data (this case for the future )
        
    }
    DLog(@"EMP. ROLE :-%@",self.mUserRole_);
}

//0 = Disabled, 1 = Full Version, 2 = Lite Version
- (NSString *)returnAppSettingsISFullOrLiteVersion :(int)aIPADVwesion {
    NSString *isFullOrLite;
    switch (aIPADVwesion) {
        case 1:
            isFullOrLite = @"FULL";
            break;
        case 2:
            isFullOrLite = @"LITE";
            break;
        default:
            isFullOrLite = @"FULL";//Disable
            break;
    }
    return isFullOrLite;
}

- (void)clearData {
    mUserName_ = nil;
    mPassword_ = nil;
    mStoreID_ = nil;
    mStoreIDWithContext_ = nil;
    mEmployeeName_ = nil;
    mEmployeeType_ = nil;
    mEmployeeID_ = nil;
    mLoginDataArray_ = nil;
    mEmployeesDataArray_ = nil;
    mUserRole_ = nil;
    [[SharedUtilities sharedUtilities] writeObjectToUserDefaults:nil forKey:kUserDefaults_TokenAndUserID_Key];
}

- (void)changingProductionAPIForSpecificStore {
    if (self.mLoginDataArray_ != nil) {
        int storeID = [[[self.mLoginDataArray_ objectForKey:@"Employee"] valueForKey:@"StoreID"] integerValue];
        switch (storeID) {
            case 396:
                WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@api.asrpro.com/api/";
                break;
            case 323:
                WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@api.asrpro.com/api/";
                break;
            case 437:
                WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@api.asrpro.com/api/";
                break;
            default:
                //                WEBSERVICEURL = @"https://LaneApp:cjd# 9f0rm5) dd90DM@staging-api.asrpro.com/api/";//Staging
                WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@test10-api.asrpro.com/api/";
                //WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@api.asrpro.com/api/";
                
                break;
        }
    }else {
        int storeID = [self.mStoreID_ intValue];
        switch (storeID) {
            case 396:
                WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@api.asrpro.com/api/";
                break;
            case 323:
                WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@api.asrpro.com/api/";
                break;
            case 437:
                WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@api.asrpro.com/api/";
                break;
            default:
                WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@test10-api.asrpro.com/api/";
                //WEBSERVICEURL = @"https://CheckInApp:03a5bE8068dC9c 8de247@api.asrpro.com/api/";

                break;
        }
    }
    DLog(@"%@",WEBSERVICEURL);
}

- (void)setPreviousDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    NSTimeZone *gmtZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:gmtZone];
    NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
    formatter.locale = enLocale;
    
    NSString *time2 = [formatter stringFromDate:[NSDate date]];
    
    NSDate *date1 = [formatter dateFromString:time2];
    self.mPreviousDate_ = date1;
    DLog(@"Previous Date :- %@",self.mPreviousDate_);
    
}

- (void)checkWhetherDateIsChanged {

    if (self.mPreviousDate_ != nil) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MM/yyyy"];
        
        NSTimeZone *gmtZone = [NSTimeZone systemTimeZone];
        [formatter setTimeZone:gmtZone];
        NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
        formatter.locale = enLocale;
        
        NSString *time2 = [formatter stringFromDate:[NSDate date]];
        NSDate *date1 = self.mPreviousDate_;
        NSDate *date2 = [formatter dateFromString:time2];
        
        NSComparisonResult result = [date1 compare:date2];
        if(result == NSOrderedDescending)
        {
            DLog(@"date1 is later than date2");
        }
        else if(result == NSOrderedAscending)
        {
            self.mPreviousDate_ = date2;
            [[SplashScreenSupportWebEngine sharedInstance] BGthreadRequestToGetAppointments];
            DLog(@"date2 is later than date1");
        }
        else
        {
            DLog(@"date1 is equal to date2");
        }
    }else {
    }
}

- (NSDate*) dateFormat : (NSString*)date currentFormat:(NSString*) currentFormat newFormat : (NSString*) newFormat
{
    NSString *dateStr = date;
    NSDateFormatter *dtF = [[NSDateFormatter alloc] init];
    [dtF setDateFormat:currentFormat];
    NSDate *d = [dtF dateFromString:dateStr];
    DLog(@"%@",d);
    return d;
}

@end
