//
//  NetworkMonitor.h
//  Castrol
//
//  Created by SanthoshKumarGundu on 12/13/10.
//  Copyright 2010 valuelabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@class Reachability;


@interface NetworkMonitor : NSObject{
	//Reachability
	Reachability	*m_InternetReach;
	Reachability *m_WifiReach;
	BOOL _bIsOnlineMode;
	BOOL blnInternetUnReachable;
	BOOL blnWifiUnReachable;
}

+(NetworkMonitor*)instance;
+(void)deallocInstance;
-(void)displayNetworkMonitorAlert;
-(BOOL)isNetworkAvailable;
-(void)initNetworkInstance;
- (void) SetReachibilityStates:(BOOL)isInternetUnReachable :(BOOL)isWiFiUnReachable;
- (void) reachabilityChanged: (NSNotification* )note;
@end
