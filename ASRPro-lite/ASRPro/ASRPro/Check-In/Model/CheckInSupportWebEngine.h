//
//  CheckInSupportWebEngine.h
//  ASRPro
//
//  Created by GuruMurthy on 21/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckInSupportWebEngine : NSObject {
    AppDelegate *mAppDelegate_;
}

+ (id)checkInSharedInstance;
- (void)getRequestForInspectionCautionedOrFailed;
- (void)putRequestForROToBeMovedToDispatchMode;
- (void)putRequestForChangingPromiseDateAndTime;
- (void)postRequestForSaveCustomerSignature;
@end
