//
//  OpenROSupportWebEngine.m
//  ASRPro
//
//  Created by Kalyani on 25/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "OpenROSupportWebEngine.h"

@implementation OpenROSupportWebEngine

@synthesize mRequestData_;
@synthesize mImageAddArray_;
@synthesize mImagedeleteArray_;
@synthesize mImageData;

- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    }
    
    return self;
    
}

// Request to get list of services
-(void)getRequestForServices:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kGET];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    
    if([responseCodeStr intValue]==ASRProOKStatusCode){
        NSError *jsonError;
        NSArray* lTempArray=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&jsonError];
        mAppDelegate_.mServiceDataGetter_.mAllServicesArray_=[lTempArray mutableCopy];
        
        NSLog(@"%@", mAppDelegate_.mServiceDataGetter_.mAllServicesArray_);
        [mAppDelegate_.mServiceDataGetter_ AlphabeticalStaffNames:  mAppDelegate_.mServiceDataGetter_.mAllServicesArray_];
        [[FileUtils fileUtils] saveArrayInToFile:mAppDelegate_.mServiceDataGetter_.mAllServicesArray_ Path:kALLSERVICESPATH];
        [[SharedUtilities sharedUtilities] writeDateToUserDefaults:[NSDate date] forKey:kALLSERVICESDATE];
        [ mAppDelegate_.mServiceDataGetter_ filterServicepackages];
        
        
    }
    
    [self performSelectorOnMainThread:@selector(onSuccessForGetServices:) withObject:responseCodeStr waitUntilDone:NO];
}

// Request to get list of services for RO

-(void)getRequestForROLines:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kGET];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    if([responseCodeStr intValue]==ASRProOKStatusCode){
        NSError *jsonError;
        NSArray* lTempArray=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&jsonError];
        mAppDelegate_.mOpenRoServiceDataGetter_.mSelectedServicesArray_=[lTempArray mutableCopy];
        [mAppDelegate_.mOpenRoServiceDataGetter_ filterLines:mAppDelegate_.mOpenRoServiceDataGetter_.mSelectedServicesArray_];
        
    }
    [self performSelectorOnMainThread:@selector(onSuccessForGetROLines:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void) postRequestToAddLine:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPOST];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    if([responseCodeStr intValue]==201){
        NSError *jsonError;
          NSMutableDictionary* ldict =[[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&jsonError] mutableCopy];
        mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_ =[NSString stringWithFormat:@"%@",[ldict objectForKey:@"ASRLID"]];
    }



    [self performSelectorOnMainThread:@selector(onSuccessForAddLine:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void) putRequestToUpdateLine:(NSObject *)myObject{
    
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPUT];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForUpdateLine:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)deleteRequestForLine:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kDELETE];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForDeleteLine:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)putRequestFoPartStatus:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPUT];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    
    if([responseCodeStr intValue]==ASRProOKStatusCode){
        if([responseCodeStr intValue]==ASRProOKStatusCode){
            mAppDelegate_.mOpenRoServiceDataGetter_.mPartStatusID_=@"5";
        }    }
    
    
    [self performSelectorOnMainThread:@selector(onSucessofPartsStatus:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)onSucessofPartsStatus:(NSObject *) isSucces {
    
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
    }
}

-(void)putRequestForCompletedLine:(NSObject*)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONStringwithoutdata:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
	[Projrequest setHTTPMethod:kPUT];
    
    NSURLResponse *responseURL;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForCompletedLine:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)putRequestForApprovedLine:(NSObject*)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONStringwithoutdata:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
	[Projrequest setHTTPMethod:kPUT];
    NSURLResponse *responseURL;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForApprovedLine:) withObject:responseCodeStr waitUntilDone:NO];
}


-(void)postRequestForAllWorkDone:(NSObject*)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPUT];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForAllWorkDone:) withObject:responseCodeStr waitUntilDone:NO];
    
}


-(void)postRequestForDisplayOrder:(NSObject*)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPUT];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    
    DLog(@"%@",json_string);
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForDisplayOrder:) withObject:responseCodeStr waitUntilDone:NO];
    
}

-(void)putRequestForMultipleServiceDone:(NSObject*)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPUT];
    NSURLResponse *responseURL;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForMultipleServiceDone:) withObject:responseCodeStr waitUntilDone:NO];
    
}

-(void) postRequestToAddImages: (NSObject *) myObject {
    
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
    [Projrequest setHTTPMethod:kPOST];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [Projrequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    
    
    //[theBodyData appendData:[@"Content-Disposition: form-data; name= \"server_value_name\"\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //[theBodyData appendData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    //[theBodyData appendData:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    //this appends the image data
    
    //[theBodyData appendData:[[NSString stringWithFormat:@"{\"UserID\":\"%@\"}",mAppDelegate_.mResponseMethods_.mUserId] dataUsingEncoding:NSUTF8StringEncoding]];
    /*
     [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
     [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
     [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
     [Projrequest setHTTPMethod:KPOST];
     
     NSMutableData *theBodyData =[NSMutableData data];
     
     [theBodyData appendData:[[NSString stringWithFormat:@"{\"UserID\":\"%@\"}",mAppDelegate_.mResponseMethods_.mUserId] dataUsingEncoding:NSUTF8StringEncoding]];
     
     
     
     [theBodyData appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"18600.jpg\"\r\n"dataUsingEncoding:NSUTF8StringEncoding]];
     [theBodyData appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     [theBodyData appendData:[NSData dataWithData:mPictureData_]];
     [Projrequest setHTTPBody:theBodyData];*/
    NSMutableData *theBodyData = [NSMutableData data];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\"Image.jpeg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[NSData dataWithData:mImageData]];
    [theBodyData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"UserID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"%@",mAppDelegate_.mModelForSplashScreen_.mEmployeeID_] dataUsingEncoding:NSUTF8StringEncoding]];
    [theBodyData appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [theBodyData appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [Projrequest setHTTPBody:theBodyData];
    
    
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"response for iamges uplaoding %@",json_string);
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    //[json_string release];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessOfToAddImages:) withObject:responseCodeStr waitUntilDone:NO];
    //[threadPool release];
}

-(void) postRequestToDeleteImages: (NSObject *) myObject {
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kDELETE];
  [Projrequest setHTTPBody:nil];
    NSURLResponse *responseURL;

    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"response for iamges uplaoding %@",json_string);

    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessOfDeleteImages:) withObject:responseCodeStr waitUntilDone:NO];
}


-(void)getRequestForPDF:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kGET];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    
    if([responseCodeStr intValue]==ASRProOKStatusCode){
        NSError *jsonError;
        NSDictionary* lTempArray=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&jsonError];
        [mAppDelegate_.mOpenRoServiceDataGetter_ setMPdfURL:[lTempArray objectForKey:@"URL"]];
    }
    
    [self performSelectorOnMainThread:@selector(onSuccessForGetPDF:) withObject:responseCodeStr waitUntilDone:NO];
}


- (void)onSuccessForGetPDF:(NSObject *) isSucces {
  //  [[SharedUtilities sharedUtilities] createLoadView];
    [mAppDelegate_.mSearchViewController_ pushToPDFView];

}
- (void)onSuccessOfDeleteImages:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if((mAppDelegate_.mWebEngine_.mResponseCode_==ASRProOKStatusCode)||(mAppDelegate_.mWebEngine_.mResponseCode_==ASRProCreatedStatusCode))  {
        [mAppDelegate_.mModelforOpenROSupportEngine_ RequestDeleteImageData];

    }
}
- (void)onSuccessOfToAddImages:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if((mAppDelegate_.mWebEngine_.mResponseCode_==ASRProOKStatusCode)||(mAppDelegate_.mWebEngine_.mResponseCode_==ASRProCreatedStatusCode))  {
        [mAppDelegate_.mModelforOpenROSupportEngine_ requestToSendImageData];

    }
}
- (void)onSuccessForGetServices:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    
    if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==OPENROMAINVIEWCONTROLLER){
    [mAppDelegate_.mSearchViewController_.mOpenROServicesTableViewController_ loadAddServicesView];
    }
    else  if(mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_==FINISHINSPECTIONVIEWCONTROLLER){
        [mAppDelegate_.mFinishInspectionViewController_ pushToServicesList];

    }
}
- (void)onSuccessForGetROLines:(NSObject *) isSucces {
    
    [[SharedUtilities sharedUtilities] removeLoadView];

    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        //  [mAppDelegate_.mServicesViewController_.mServicesListTableViewController_.tableView reloadData];
        [mAppDelegate_.mSearchViewController_.mOpenROServicesTableViewController_.tableView reloadData];
        
        if((mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==4)||(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==6)){
            if([mAppDelegate_.mSearchViewController_ areAllCurrentServicesDone]&&[mAppDelegate_.mSearchViewController_ areAllRecommendedServicesDone]){
                [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestToChangeMode:@"7"];
                [[SharedUtilities sharedUtilities] showAlertWithTitle:NSLocalizedString(@"lALERT_TITLE", nil) message:[NSString stringWithFormat:@"RO %@ has been sent for review", mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_]];
            }
        }
       }

    
 }
- (void)onSuccessForAddLine:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    
    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForUpdateServiceLine:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_ LineID:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mLineID_ ServiceDict:mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mServiceDetailsDict_];

}
- (void)onSuccessForUpdateLine:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    [mAppDelegate_.mServiceDataGetter_.mAddServicesViewController_.mAddServiceTableViewController_.mServiceImageView sendTheimagesToServer];
}


- (void)onSuccessForDeleteLine:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
        [mAppDelegate_.mModelforOpenROSupportEngine_ setMGetServiceReference_:OPENROSERVICESVIEWCONTROLLER];
    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForRepairOrderServiceLines:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
}
- (void)onSuccessForCompletedLine:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    
      [mAppDelegate_.mModelforOpenROSupportEngine_ setMGetServiceReference_:OPENROSERVICESVIEWCONTROLLER];
    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForRepairOrderServiceLines:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
  }

- (void)onSuccessForApprovedLine:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    
    [mAppDelegate_.mModelforOpenROSupportEngine_ setMGetServiceReference_:OPENROSERVICESVIEWCONTROLLER];
    [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForRepairOrderServiceLines:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
}


- (void)onSuccessForAllWorkDone:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if(mAppDelegate_.mModelForVehicleHistoryTableView_.mCurrentMode_==3){
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelforOpenROSupportEngine_ setMGetServiceReference_:OPENROSERVICESVIEWCONTROLLER];
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForGetROLines:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_];
    }
    else{
        if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
            [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestToChangeMode:@"7"];
        }
    }

  }

- (void)onSuccessForMultipleServiceDone:(NSObject *) isSucces {
 }

- (void)onSuccessForDisplayOrder:(NSObject *) isSucces {
   }


@end