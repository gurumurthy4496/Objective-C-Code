//
//  SplashScreenSupportWebEngine.h
//  ASRPro
//
//  Created by GuruMurthy on 08/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OnsuccessProtocol.h"

@class AppDelegate;

@interface SplashScreenSupportWebEngine : NSObject<OnsuccessProtocol> {
    AppDelegate *mAppDelegate_;
}
@property (nonatomic, retain) NSString *mDeviceToken_;

+ (id)sharedInstance;
- (void)postRequestForLogin;
- (void)postRequestToAddDeviceToken:(NSString *)aDeviceToken;
@end
