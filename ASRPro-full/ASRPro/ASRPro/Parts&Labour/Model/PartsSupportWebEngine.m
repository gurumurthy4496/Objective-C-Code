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

#pragma mark -  ********************** Request methods**************************

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** request to get part and labor items in parts lookup ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)getRequestForPartsLookup:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                  requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                  cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                  timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
    [Projrequest setHTTPMethod:kGET];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                    sendSynchronousRequest:Projrequest
                    returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                         initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);
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

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** request to add individual part item in parts lookup ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)postRequestForPartsLookup:(NSObject *)myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
    [Projrequest setHTTPMethod:kPOST];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONStringwithoutdata:self.mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);
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

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** request to edit individual part item in parts lookup ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)putRequestForPartsLookup:(NSObject *)anObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)anObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
    [Projrequest setHTTPMethod:kPUT];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:self.mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);
NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];

    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSucessputRequestForPartsLookup:) withObject:responseCodeStr waitUntilDone:NO];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** request to delete individual part item in parts lookup ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)deleteRequestForPartsLookup:(NSObject *)anObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)anObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
    [Projrequest setHTTPMethod:kDELETE];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:self.mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);
 NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSucessdeleteRequestForPartsLookup:) withObject:responseCodeStr waitUntilDone:NO];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                      *** request to add multiple part items and labor items in parts lookup ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)postRequestForAddLookup:(NSObject *)anObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)anObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
    [Projrequest setHTTPMethod:kPOST];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONStringwithoutdata:self.mRequestData_] dataUsingEncoding:NSUTF8StringEncoding]];

    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);
NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSucesspostRequestForAddLookup:) withObject:responseCodeStr waitUntilDone:NO];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** request to get added parts in parts lookup ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)getRequestForAddParts:(NSObject *)anObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)anObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
    [Projrequest setHTTPMethod:kGET];

    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);
NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    if([responseCodeStr intValue]==ASRProOKStatusCode){
        NSError *jsonError;
        NSArray* lTempArray=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&jsonError];
        mAppDelegate_.mPartLabourDataGetter_.mAddedPartsArray_=[lTempArray mutableCopy];
    }
    [self performSelectorOnMainThread:@selector(onSuccessForGetAddParts:) withObject:responseCodeStr waitUntilDone:NO];
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** request to get Location IDs for store  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)getRequestForLocationID:(NSObject *)anObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)anObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
    [Projrequest setHTTPMethod:kGET];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    DLog(@"%@",json_string);
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

#pragma mark -  ********************** Response methods**************************

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** on Sucess of get locationIDs  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)onSuccessForgetRequestForLocationID:(NSObject *) isSucces {
    
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** on Sucess of get Added Parts  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)onSuccessForGetAddParts:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
  if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_ reloadPartsView];
}
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** on Sucess of Adding Part Item  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)onSucesspostRequestForPartsLookup:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
 if([(NSString *)isSucces intValue]==200) {
    mAppDelegate_.mPartLabourDataGetter_->isAdd=TRUE;
     [mAppDelegate_.mModelForPartsSupportEngine_ RequestFoGetPartsLines:mAppDelegate_.mPartLabourDataGetter_.mRONumber_];
  }
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** on Sucess of Get Parts Lookup  ***
//--------------------------------------------------- ************** ------------------------------------------------------
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

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** on Sucess of Editing Part Item  ***
//--------------------------------------------------- ************** ------------------------------------------------------
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

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** on Sucess of delete Part Item  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)onSucessdeleteRequestForPartsLookup:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        [mAppDelegate_.mPartLabourDataGetter_.mPartsLaborMainSubview deleteIndex];
          [mAppDelegate_.mPartLabourDataGetter_.mPartsLabourMainViewController_ resizeTheViews];
    }
}

//--------------------------------------------------- ************** ------------------------------------------------------
//                                                *** on Sucess of Adding multiple Part and Labor Item  ***
//--------------------------------------------------- ************** ------------------------------------------------------
-(void)onSucesspostRequestForAddLookup:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
   if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        [mAppDelegate_.mModelForPartsSupportEngine_ RequestFoGetPartsLines:mAppDelegate_.mPartLabourDataGetter_.mRONumber_];
    }
}

@end
