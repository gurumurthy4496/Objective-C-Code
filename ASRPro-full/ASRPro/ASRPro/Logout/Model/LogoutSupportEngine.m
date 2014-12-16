//
//  LogoutSupportEngine.m
//  ASRPro
//
//  Created by GuruMurthy on 04/07/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "LogoutSupportEngine.h"

@implementation LogoutSupportEngine


static LogoutSupportEngine *logoutSupportEngine = nil;


+ (id)sharedInstance {
    @synchronized(self) {
        if(logoutSupportEngine == nil)
            logoutSupportEngine = [[super allocWithZone:NULL] init];
    }
    return logoutSupportEngine;
}

#pragma mark --
#pragma mark Singleton Methods


+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (id)init {
    if (self = [super init]) {
        //        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark --
#pragma mark POST_REQUEST_FOR_DEVICE_TOKEN
- (void)postRequestToLogOut {
    
    if ([[NetworkMonitor instance] isNetworkAvailable]) {
        NSString *mRequestStr=[NSString stringWithFormat:@"%@Stores/%@/Employees/%@/LogOut",WEBSERVICEURL,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mStoreID_,[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSplashScreen_.mEmployeeID_];
        mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        DLog(@" LogOut REQUEST :-%@",mRequestStr);
        [NSThread detachNewThreadSelector:@selector(threadForpostRequestToLogOut:) toTarget:self withObject: mRequestStr];
        
    }else {
        [[NetworkMonitor instance]displayNetworkMonitorAlert];
        // return;
    }
}

// ----------------------------;
// Method for sendong device token;
// ----------------------------;
- (void)threadForpostRequestToLogOut: (NSObject *) myObject {
    
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPOST];
    
    NSString *data = [NSString stringWithFormat:@"{\"DeviceID\":\"%@\"}",[[SplashScreenSupportWebEngine sharedInstance] mDeviceToken_]];
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"LogOut REQUEST :-%@",Projrequest);
    DLog(@"LogOut DATA :-%@",data);
    DLog(@"LogOut RESPONSE :-%@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForLogOut:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)onSuccessForLogOut:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue] == ASRProOKStatusCode){
        
    }
}

@end
