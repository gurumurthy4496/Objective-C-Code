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
//#define DLog(fmt, ...) NSLog(fmt, ## __VA_ARGS__)
#define DLog(__FORMAT__, ...) NSLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif


#pragma mark -
#pragma mark RELEASE_NIL

#define RELEASE_NIL(object)  object=nil;
#define LogBool(BOOL) DLog(@"%s: %@",#BOOL, BOOL ? @"YES" : @"NO" )



#define iPhone5PotraitExcessPixel ([[UIScreen mainScreen]bounds].size.height==568?88:0)



#pragma mark -
#pragma mark iPad_US_API

//#define WEBSERVICEURL @"https://LaneApp:cE 97Ls5^4 #apq@staging.api.asrpro.com/api/" // this url is used for "US" version iPhone
//#define WEBSERVICEURL @"https://LaneApp:cE 97Ls5^4 #apq@staging-api.asrpro.com/api/"
//#define WEBSERVICEURL @"https://LaneApp:cjd# 9f0rm5) dd90DM@staging-api.asrpro.com/api/"
//#define WEBSERVICEURL @"https://LaneApp:cjd# 9f0rm5) dd90DM@api.asrpro.com/api/"

#endif
