//
//  PartsSupportWebEngine.m
//  ASRPro
//
//  Created by Kalyani on 24/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PartsSupportWebEngine.h"

@implementation PartsSupportWebEngine
@synthesize mRequestData_;


- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    }
    
    return self;
    
}

-(void)getRequestForPartsLookup:(NSObject *)myObject{
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
        NSArray* lTempArray=[[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&jsonError] mutableCopy];
        mAppDelegate_.mPartLabourDataGetter_.mPartsLookupDict_=[lTempArray mutableCopy];
    }
    
    [self performSelectorOnMainThread:@selector(onSuccessForGetPartsAndLabour:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)postRequestForPartsLookup:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPOST];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONStringwithoutdata:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
    
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

        NSMutableDictionary* lTempArray=[[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                             options:kNilOptions error:&jsonError] mutableCopy];

        [mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_ setMPartID_:[[lTempArray objectForKey:@"IDs"] objectAtIndex:0]];
    }
    

  [self performSelectorOnMainThread:@selector(onSucesspostRequestForPartsLookup:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)putRequestForPartsLookup:(NSObject *)myObject{
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
    [self performSelectorOnMainThread:@selector(onSucessputRequestForPartsLookup:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)deleteRequestForPartsLookup:(NSObject *)myObject{
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
    [self performSelectorOnMainThread:@selector(onSucessdeleteRequestForPartsLookup:) withObject:responseCodeStr waitUntilDone:NO];
}


-(void)postRequestForAddLookup:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [Projrequest setValue:@"Basic TGFuZUFwcDpjamQjIDlmMHJtNSkgZGQ5MERN" forHTTPHeaderField:@"Authorization"];
    [Projrequest setValue:@"JSON" forHTTPHeaderField:@"Format"];
	[Projrequest setHTTPMethod:kPOST];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONStringwithoutdata:mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSucesspostRequestForAddLookup:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)putRequestForLaborLookup:(NSObject *)myObject{
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
    [self performSelectorOnMainThread:@selector(onSucessputRequestForLaborLookup:) withObject:responseCodeStr waitUntilDone:NO];
}


-(void)deleteRequestForLaborLookup:(NSObject *)myObject{
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
    [self performSelectorOnMainThread:@selector(onSucessdeleteRequestForLaborLookup:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)getRequestForAddParts:(NSObject *)myObject{
    //  NSAutoreleasePool *threadPool = [[NSAutoreleasePool alloc] init];
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
        mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_=[lTempArray mutableCopy];

        
        //NSLog(@"%@", mAppDelegate_.mServiceDataGetter_.mRecommendedServicesArray_);
    }
    
    [self performSelectorOnMainThread:@selector(onSuccessForGetAddParts:) withObject:responseCodeStr waitUntilDone:NO];
    //	[threadPool release];
}


-(void)getRequestForLocationID:(NSObject *)myObject{
    //    NSAutoreleasePool *threadPool = [[NSAutoreleasePool alloc] init];
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
        mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mLocationArray_=[lTempArray mutableCopy];
        [[FileUtils fileUtils] saveArrayInToFile:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mLocationArray_ Path:kPARTSLOCATIONSPATH];
    }
    
    [self performSelectorOnMainThread:@selector(onSuccessForgetRequestForLocationID:) withObject:responseCodeStr waitUntilDone:NO];
}
-(void)onSuccessForgetRequestForLocationID:(NSObject *) isSucces {
    
}

-(void)onSuccessForGetAddParts:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
  if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        
        [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_ reloadPartsView];
}
}


-(void)onSucesspostRequestForPartsLookup:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
 if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
    mAppDelegate_.mPartLabourDataGetter_->isAdd=TRUE;
     [mAppDelegate_.mModelForPartsSupportEngine_ RequestFoGetPartsLines:mAppDelegate_.mPartLabourDataGetter_.mRONumber_];
     
  }
}

-(void)onSuccessForGetPartsAndLabour:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        mAppDelegate_.mPartLabourDataGetter_->isSucess=TRUE;
    }
    else{
        mAppDelegate_.mPartLabourDataGetter_->isSucess=FALSE;

    }
    if(mAppDelegate_.mModelForPartsSupportEngine_.mGetPartsReference_==INPROCESSOPARTSVIEWCONTROLLER){
        [mAppDelegate_.mServicesViewController_ initPopUpView];
    }
    else   if(mAppDelegate_.mModelForPartsSupportEngine_.mGetPartsReference_==OPENROPARTSVIEWCONTROLLER){
        [mAppDelegate_.mSearchViewController_ pushToPartsLabour];

    }
    }
-(void)onSucessputRequestForPartsLookup:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {

    if(mAppDelegate_.mPartLabourDataGetter_->isAdd){
        [mAppDelegate_.mModelForPartsSupportEngine_ requestToGetParts:mAppDelegate_.mPartLabourDataGetter_.mRONumber_];
    }  else{
        [mAppDelegate_.mPartLabourDataGetter_.mPartsLaborMainSubview reloadTableData:mAppDelegate_.mPartLabourDataGetter_.mModelForCurrentPart_.mPartsDict_ ];
    }
   }
    
}

-(void)onSucessdeleteRequestForPartsLookup:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        [mAppDelegate_.mPartLabourDataGetter_.mPartsLaborMainSubview deleteIndex];
          [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_ resizeTheViews];
    }
}
-(void)onSucesspostRequestForAddLookup:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
   if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        [mAppDelegate_.mModelForPartsSupportEngine_ RequestFoGetPartsLines:mAppDelegate_.mPartLabourDataGetter_.mRONumber_];
    }
}

-(void)onSucessputRequestForLaborLookup:(NSObject *) isSucces {
        
    }
-(void)onSucessdeleteRequestForLaborLookup:(NSObject *) isSucces {
        
    }
@end
