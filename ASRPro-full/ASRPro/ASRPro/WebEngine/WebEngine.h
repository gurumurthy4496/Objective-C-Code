	//
	//  WebEngine.h
	//	HPAC
	//  Copyright 2011 ValueLabs. All rights reserved.
	//

#import <Foundation/Foundation.h>

@interface WebEngine : NSObject {
	
    /**
     * ASRProAppDelegate object creating
     */
	AppDelegate *mAppDelegate_;
        
@public
    
    /**
     * NSMutableData webData parameter
     */
	NSMutableData *webData;
    NSInteger mResponseCode_;
}

@property(nonatomic,retain)NSString *mWebMethodName_;
@property(nonatomic,retain)NSString *mWebMethodType_;
@property (nonatomic)NSInteger mResponseCode_;
/**
 * Method used to initialize class
 */
- (id)init;

/**
 * Method used to make request request for login
 * @param mReqStr_ for url to post request
 */
- (void)makeRequestWithUrl:(NSString *)mRequestURL requestData:(NSString *)mRequestData;
@end
