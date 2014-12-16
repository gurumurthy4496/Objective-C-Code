//
//  ResponseMethods.h
//  ASRPro
//
//  Created by Value Labs on 17/09/12.
//  Copyright (c) 2012 ValueLabs. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface ResponseMethods : NSObject{
    
    /**
     * ASRProAppDelegate object creating
     */   
    AppDelegate *mAppDelegate_;

}

/**
 * Method used to initialize class
 */
- (id)init;

/**
 * Method used to perform success response operation from server
 */
- (void)successResponse;

@end
