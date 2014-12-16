//
//  LogoutSupportEngine.h
//  ASRPro
//
//  Created by GuruMurthy on 04/07/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogoutSupportEngine : NSObject
+ (id)sharedInstance;

- (void)postRequestToLogOut;
@end
