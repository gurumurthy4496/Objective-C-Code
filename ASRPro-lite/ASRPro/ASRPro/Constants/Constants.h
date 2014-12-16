//
//  Constants.h
//  ASRPro
//
//  Created by GuruMurthy on 23/09/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#ifndef ASRPro_Constants_h
#define ASRPro_Constants_h

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define IOS_OLDER_THAN_6 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] < 6.0 )
#define IOS_NEWER_OR_EQUAL_TO_6 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 6.0 )
#define IOS_NEWER_OR_EQUAL_TO_7 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 7.0 )

#define Y_POS (IOS_NEWER_OR_EQUAL_TO_7 ? 20:0)
#define POPOVER_Y_POS (IOS_NEWER_OR_EQUAL_TO_7 ? 65:45)

#define HEIGHT [[UIScreen mainScreen]bounds].size.height
#define WIDTH [[UIScreen mainScreen]bounds].size.width

#pragma mark -
#pragma mark DLOG

#ifdef DEBUG
#define DLog(fmt, ...) NSLog(fmt, ## __VA_ARGS__)
#else
#define DLog(...)
#endif


#pragma mark -
#pragma mark RELEASE_NIL

#define RELEASE_NIL(object)  object=nil;
#define LogBool(BOOL) NSLog(@"%s: %@",#BOOL, BOOL ? @"YES" : @"NO" )

//----- APPLE PSLOG FILE -----
//---- MAKE SURE TO KNOW THE BELOW STATEMENTS WHILE IMPLEMENTING THEM.-----
// If we're not in a debug build, remove the PSLog statements. This
// makes calls to PSLog "compile out" of Release builds
#ifdef mShowLogs

#define PSLogDebug(...)		NSLog(@"[%@] DEBUG: %s %@", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), __func__, [NSString stringWithFormat:__VA_ARGS__])
#define PSLog(...)			NSLog(@"[%@] INFO: %s %@", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), __func__, [NSString stringWithFormat:__VA_ARGS__])
#define PSLogInfo(...)		NSLog(@"[%@] INFO: %s %@", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), __func__, [NSString stringWithFormat:__VA_ARGS__])

#else

#undef PSLogDebug
#undef PSLog
#undef PSLogInfo
#define PSLogDebug(...) do {} while(0)
#define PSLog(...) do {} while(0)
#define PSLogInfo(...) do {} while(0)

#endif


// If using PSLogReporter then enable these as well.
#ifdef PS_USE_LOG_REPORTER

#undef PSLog
#undef PSLogInfo
#define PSLog(...)			NSLog(@"[%@] INFO: %s %@", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), __func__, [NSString stringWithFormat:__VA_ARGS__])
#define PSLogInfo(...)		NSLog(@"[%@] INFO: %s %@", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), __func__, [NSString stringWithFormat:__VA_ARGS__])

#endif


// We always want these enabled.
#define PSLogWarning(...)				NSLog(@"[%@] WARNING: %s %@", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), __func__, [NSString stringWithFormat:__VA_ARGS__])
#define PSLogError(...)					NSLog(@"[%@] ERROR: %s %@", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), __func__, [NSString stringWithFormat:__VA_ARGS__])
#define PSLogException(...)				NSLog(@"[%@] EXCEPTION: %s %@", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), __func__, [NSString stringWithFormat:__VA_ARGS__])
#define PSLogRelease(...)				NSLog(@"[%@] INFO: %s %@", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), __func__, [NSString stringWithFormat:__VA_ARGS__])
#define PSLogIntervalSince(msg,since)	NSLog(@"[%@] TIMING: %@ took %fs", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), (msg), [[NSDate date] timeIntervalSinceDate:(since)])
#define PSLogElapsedTime(msg,elapsed)	NSLog(@"[%@] TIMING: %@ took %fs", ([[NSThread currentThread] isMainThread] ? @"Main Thread" : [NSString stringWithFormat:@"Thread %p", [NSThread currentThread]]), (msg), (elapsed))

//----- END OF APPLE PSLOG FILE -----

#define iPhone5PotraitExcessPixel ([[UIScreen mainScreen]bounds].size.height==568?88:0)



#pragma mark -
#pragma mark iPhone_US_API

//#define WEBSERVICEURL @"https://LaneApp:cE 97Ls5^4 #apq@staging.api.asrpro.com/api/" // this url is used for "US" version iPhone
//#define WEBSERVICEURL @"https://LaneApp:cE 97Ls5^4 #apq@staging-api.asrpro.com/api/"
#define WEBSERVICEURL @"https://LaneApp:cjd# 9f0rm5) dd90DM@staging-api.asrpro.com/api/"
//#define WEBSERVICEURL @"https://LaneApp:cjd# 9f0rm5) dd90DM@api.asrpro.com/api/"

#endif
