	//
	//  WebEngine.m
	//	HPAC
	//  Copyright 2011 ValueLabs. All rights reserved.
	//

#import "WebEngine.h"

@implementation WebEngine

@synthesize mWebMethodName_;
@synthesize mWebMethodType_;
@synthesize mResponseCode_;
- (id)init
{
    if (self = [super init])
    {
			// Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    }
    
    return self;

}


- (void)makeRequestWithUrl:(NSString *)mRequestURL requestData:(NSString *)mRequestData {
    
    NSURL *url = [NSURL URLWithString:mRequestURL];
    
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:url
                                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                        timeoutInterval:60.0];
    DLog(@"Request URL : %@",mRequestURL);
    DLog(@"Request Data : %@",mRequestData);
	[theRequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [theRequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];

    [theRequest setValue:@"json" forHTTPHeaderField:@"Format"];
    
	[theRequest setHTTPMethod:mWebMethodType_];
    
    if(mRequestData != nil) {
        [theRequest setHTTPBody:[mRequestData dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
    if( theConnection ) {
		if(webData != nil)
		{
			webData = nil;
		}
		
		webData = [NSMutableData data];
	}else {
        [[SharedUtilities sharedUtilities] showAlertWithTitle:@"" message:@"theConnection is NULL"];
	}
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	BOOL isvalue = [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
	
	return isvalue;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	//if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
	//if ([trustedHosts containsObject:challenge.protectionSpace.host])
	[challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
	
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}


#pragma mark Connection Delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    mResponseCode_ = [httpResponse statusCode];
    DLog(@"--------> ResponseCode %d <----------",mResponseCode_);
    if(mResponseCode_ ==ASRProOKStatusCode||mResponseCode_==ASRProCreatedStatusCode){
        [webData setLength: 0];
    }
    else
    {
        DLog(@"--------> Failed Failed %d <----------",[httpResponse statusCode]);
     
    }
}

#pragma mark NSURLConnection Delegate methods  
#pragma mark did receive data
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}

#pragma mark did fail with error
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[[NSNotificationCenter defaultCenter] postNotificationName: @"ResponseFailed" object: nil];
		//[connection release];
}

#pragma mark did finish loading 
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if([webData length]==0 && mResponseCode_ !=ASRProOKStatusCode&&mResponseCode_!=ASRProCreatedStatusCode) {
		[[NSNotificationCenter defaultCenter] postNotificationName: @"onNilResponse" object: nil];
		
	}else {
        if(mResponseCode_ ==ASRProOKStatusCode||mResponseCode_==ASRProCreatedStatusCode||mResponseCode_==ASRProHTTPInternalErrorCode) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName: @"onResponse" object:self];

        }else {
            [[SharedUtilities sharedUtilities] removeLoadView];
            NSString *json_string = [[NSString alloc]
                                     initWithData:webData encoding:NSUTF8StringEncoding];
            DLog(@"--------> Error response %@ <----------",json_string);
            if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kLOGIN] && [mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kPOST]) {
                [self showErrorResponseForLogInView];
            }else if ([mAppDelegate_.mWebEngine_.mWebMethodName_ isEqualToString:kVEHICLE_HISTORY_API]&&[mAppDelegate_.mWebEngine_.mWebMethodType_ isEqualToString:kGET]) {
                [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"ERROR", nil) message:json_string];
                NSMutableDictionary *lTempDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"lNoVehicleHistoryFound", Nil),@"RONumber",@"",@"DMSClosedDate", nil];
                
                NSMutableArray *lTempArray = [[NSMutableArray alloc] initWithObjects:lTempDictionary, nil];
                mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_ = lTempArray;
                
                DLog(@"%@",mAppDelegate_.mSearchDataGetter_.mVehicleHistoryData_);
            }
		}
	}
}

- (void)showErrorResponseForLogInView {
        [mAppDelegate_.mSplashScreenViewController_.mErrorView_ setHidden:FALSE];
        [mAppDelegate_.mSplashScreenViewController_.view bringSubviewToFront:mAppDelegate_.mSplashScreenViewController_.mErrorView_];
        [mAppDelegate_.mSplashScreenViewController_.mLoginScrollView_.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
            UIView *lTempView_ = object;
            UITextField *lTempTextField_ = object;
            switch (lTempView_.tag) {
                case 1: { // Welcome to ASR Pro Label;
                }
                    break;
                case 2: { // UserName Label;
                }
                    break;
                case 3: { // Password Label;
                }
                    break;
                case 4: { // StoreID Label;
                }
                    break;
                case 5: { //Username TextView;
                    [lTempTextField_.layer setBorderWidth:1];
                    lTempTextField_.font = [UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey];
                    [lTempTextField_ setTextColor:[UIColor redColor]];
                    [lTempTextField_.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
                }
                    break;
                case 6: { //Password TextView;
                    [lTempTextField_.layer setBorderWidth:1];
                    lTempTextField_.font = [UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey];
                    [lTempTextField_ setTextColor:[UIColor redColor]];
                    [lTempTextField_.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
                }
                    break;
                case 7: { //StoreID TextView;
                    [lTempTextField_.layer setBorderWidth:1];
                    lTempTextField_.font = [UIFont regularFontOfSize:17 fontKey:kFontNameHelveticaNeueKey];
                    [lTempTextField_ setTextColor:[UIColor redColor]];
                    [lTempTextField_.layer setBorderColor:[[UIColor lightGrayColor]CGColor]];
                }
                    break;
                case 8: { //Login Button;
                }
                    break;
                case 9: { //Login Button;
                }
                    break;
                default:
                    break;
            }
        }];
        [mAppDelegate_.mSplashScreenViewController_.mErrorMessageLabel_ setText:NSLocalizedString(@"lLOGIN_FAILURE_RESPONSE", nil)];
}
@end
