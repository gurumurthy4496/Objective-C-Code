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

@end
