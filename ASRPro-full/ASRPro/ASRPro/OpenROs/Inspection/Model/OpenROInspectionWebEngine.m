//
//  OpenROInspectionWebEngine.m
//  ASRPro
//
//  Created by Kalyani on 03/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "OpenROInspectionWebEngine.h"
#import "VehicleHistorySupportWebEngine.h"

@implementation OpenROInspectionWebEngine
@synthesize mRequestData;


- (id)init
{
    if (self = [super init])
    {
        // Initialization code here
        mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    }
    
    return self;
    
}

-(void)getRequestForInspectionFormList:(NSObject *) myObject{
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
        NSArray* lTempArray=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                            options:kNilOptions error:&jsonError];
        mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormsArray_=[lTempArray mutableCopy];
        DLog(@"%@", mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormsArray_);
        [[FileUtils fileUtils] saveArrayInToFile:mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormsArray_ Path:kINSPECTIONFORMSLISTPATH];
        [[SharedUtilities sharedUtilities] writeDateToUserDefaults:[NSDate date] forKey:kALLSERVICESDATE];
    }
    [self performSelectorOnMainThread:@selector(onSuccessForInspectionFormList:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)getRequestForInspectionForm:(NSMutableArray *) myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)[myObject objectAtIndex:0]]
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
       NSDictionary* lTempDict=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                           options:kNilOptions error:&jsonError];

        if(lTempDict!=nil){
            [[FileUtils fileUtils] saveDictionaryInToFileFolder:[lTempDict mutableCopy] FolderName:kINSPECTIONFORMSFOLDERPATH Path:[NSString stringWithFormat:@"%@-%@",kINPECTIONFORMNAMEPATH,[myObject objectAtIndex:1]]];
        }
    }
    [self performSelectorOnMainThread:@selector(onSuccessForInspectionForm:) withObject:responseCodeStr waitUntilDone:NO];
    
}

-(void)getRequestForInspectionFormIndividual:(NSMutableArray *) myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)[myObject objectAtIndex:0]]
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
        NSDictionary* lTempDict=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions error:&jsonError];
        if(lTempDict!=nil){
            [mAppDelegate_.mOpenROInspectionDataGetter_ setMInspectionFormDict_:[lTempDict mutableCopy]];
            [[FileUtils fileUtils] saveDictionaryInToFileFolder:[lTempDict mutableCopy] FolderName:kINSPECTIONFORMSFOLDERPATH Path:[NSString stringWithFormat:@"%@-%@",kINPECTIONFORMNAMEPATH,[myObject objectAtIndex:1]]];
        }
    }
    [self performSelectorOnMainThread:@selector(onSuccessForInspectionFormIndividual:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)getInspectionFormID:(NSObject *) myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    DLog(@"RO DETILAS REQUEST:-%@",Projrequest);
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
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
   if([responseCodeStr intValue]==ASRProOKStatusCode){
       NSError *jsonError;
       NSMutableDictionary* RODetails=[NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                      options:kNilOptions error:&jsonError];
       
       [mAppDelegate_ mModelForVehicleHistory_].mRODetailsArray_ = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
                                                                                                   options:kNilOptions error:&jsonError];
       
       // ----------------------------;
       // ADD LeftView to ECS_Sliding -> WalkAroundLeftSlider;
       // ----------------------------;
       if (mAppDelegate_.mWalkAroundLeftViewController_ == nil) {
           WalkAroundLeftViewController *lViewControler = [[WalkAroundLeftViewController alloc] initWithNibName:@"WalkAroundLeftViewController" bundle:nil];
           [mAppDelegate_ setMWalkAroundLeftViewController_:lViewControler];
       }
       [mAppDelegate_.mWalkAroundLeftViewController_.view setBackgroundColor:[UIColor ASRProRGBColor:66 Green:66 Blue:68]];
       if (![mAppDelegate_.mECSlidingViewController_.underLeftViewController isKindOfClass:[WalkAroundLeftViewController class]]) {
           mAppDelegate_.mECSlidingViewController_.underLeftViewController  = mAppDelegate_.mWalkAroundLeftViewController_;
       }
       mAppDelegate_.mWalkAroundLeftViewController_.mShowVehicleHistoryForOpenRO_ = ShowVehicleHistoryForOpenROSection;
       DLog(@"%@",[mAppDelegate_ mModelForVehicleHistory_].mRODetailsArray_);
       DLog(@"RO DETILAS RESPONSE :-%@",RODetails);
       mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormID_=[NSString stringWithFormat:@"%@",[RODetails objectForKey:@"FormID"]];
       mAppDelegate_.mOpenRoServiceDataGetter_.mPartStatusID_=[NSString stringWithFormat:@"%@",[RODetails objectForKey:@"PartStatusID"]];
   }
    [self performSelectorOnMainThread:@selector(onSuccessForGetInspectionFormID:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)getRequestForInspectionItems:(NSObject *) myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kPUT];
    
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
    [self performSelectorOnMainThread:@selector(onSuccessForgetInspectionItems:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)postRequestForAddInspectionItem:(NSObject *) myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kPOST];
    DLog(@"%@",myObject);
    DLog(@"%@",[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData]);
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    DLog(@"%@",json_string);
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForAddInspectionItem:) withObject:responseCodeStr waitUntilDone:NO];
}


-(void)putRequestForUpdateInspectionItem:(NSObject *) myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kPUT];
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData] dataUsingEncoding:NSUTF8StringEncoding]];
    DLog(@"%@",myObject);
    DLog(@"%@",[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData]);
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    DLog(@"%@",json_string);
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForUpdateInspectionItem:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void)deleteRequestForInspectionItem:(NSObject *) myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kDELETE];
    NSURLResponse *responseURL;
    NSData *response = [NSURLConnection
                        sendSynchronousRequest:Projrequest
                        returningResponse:&responseURL error:nil];
    NSString *json_string = [[NSString alloc]
                             initWithData:response encoding:NSUTF8StringEncoding];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
    NSInteger responseCode = [httpResponse statusCode];
    DLog(@"%@",json_string);
    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
    [self performSelectorOnMainThread:@selector(onSuccessForDeleteInspectionItem:) withObject:responseCodeStr waitUntilDone:NO];
}


-(void)putRequestForChangeInspectionForm:(NSObject *) myObject{
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kPUT];
    DLog(@"%@",myObject);
    DLog(@"%@",[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData] dataUsingEncoding:NSUTF8StringEncoding]);
    [Projrequest setHTTPBody:[[[SharedUtilities sharedUtilities] ConvertRequestDictToJSONString:mRequestData] dataUsingEncoding:NSUTF8StringEncoding]];
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
    [self performSelectorOnMainThread:@selector(onSuccessForChangeInspectionForm:) withObject:responseCodeStr waitUntilDone:NO];
}

-(void) PutRequestToChangeRoModeFromDispatchToInspection: (NSObject *) myObject {
    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
                                      requestWithURL:[NSURL
                                                      URLWithString:(NSString *)myObject]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                      timeoutInterval:60.0];
    [Projrequest setValue:kCONTENT_TYPE_VALUE forHTTPHeaderField:kCONTENT_TYPE];
    [Projrequest setValue:kACCEPT_VALUE forHTTPHeaderField:kACCEPT];
    [Projrequest setValue:kAUTHORISATION_VALUE forHTTPHeaderField:kAUTHORISATION];
    [Projrequest setValue:kFORMAT_VALUE forHTTPHeaderField:kFORMAT];
	[Projrequest setHTTPMethod:kPUT];
    NSString *data = [NSString stringWithFormat:@"{\"UserID\":\"%@\",\"ClosedReason\":\"%@\"}",[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForSplashScreen_].mEmployeeID_,@"1"];
    /*we are setting default value "1" for ClosedReason`(Note: Need to make dynamic) (int; required when closing a repair order.)
     * 1    Default
     * 2    Manual: An advisor closes it as part of the normal work process.
     * 3    Manual: An advisor batch-closes all ROs in Review mode.
     * 4    Manual: A manager closes it.
     * 11   Manual: A Super Admin closes it.*/
    [Projrequest setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
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
    [self performSelectorOnMainThread:@selector(onSuccessOfChangeROMode:) withObject:responseCodeStr waitUntilDone:NO];
}

- (void)onSuccessOfChangeROMode:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
    [[VehicleHistorySupportWebEngine sharedInstance] threadRequestToGetRepairOrders];
    }
}

- (void)onSuccessForInspectionFormList:(NSObject *) isSucces {
            mFormCount_=[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormsArray_ count];
            [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_  requestForLoadingAllInspectionForms];
}
- (void)onSuccessForInspectionForm:(NSObject *) isSucces {
  [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForLoadingAllInspectionForms];
}

- (void)onSuccessForInspectionFormIndividual:(NSObject *) isSucces {
        [[SharedUtilities sharedUtilities] removeLoadView];
    if(mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference==WALKAROUNDINSPECTION)  {
        [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForInspectionItems:mAppDelegate_.mModelForEditCustomerScreen_.mRONumber_];
    }
   else if(mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference==FINISHINSPECTION)  {
        [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForInspectionItems:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_];
    }
   else if(mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference==FINISHINSPECTIONVIEW)  {
       [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForInspectionItems:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_];
   }
}

- (void)onSuccessForGetInspectionFormID:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
  if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
      [mAppDelegate_.mSearchViewController_.mOpenROServicesTableViewController_.tableView reloadData];
      [[VehicleHistorySupportWebEngine sharedInstance] getRequestForVehicleHistory];
  }
}

- (void)onSuccessForgetInspectionItems:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
    }
}

- (void)onSuccessForAddInspectionItem:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
    }
}

- (void)onSuccessForUpdateInspectionItem:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
    }
}

- (void)onSuccessForDeleteInspectionItem:(NSObject *) isSucces {
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
    }
}

- (void)onSuccessForChangeInspectionForm:(NSObject *) isSucces {
    [[SharedUtilities sharedUtilities] removeLoadView];
    if([(NSString *)isSucces intValue]==ASRProOKStatusCode) {
        mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_=[[FileUtils fileUtils] loadDictionaryFromFileFolder:kINSPECTIONFORMSFOLDERPATH Path:[NSString stringWithFormat:@"%@-%@",kINPECTIONFORMNAMEPATH,mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormID_]];
        if( mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_==nil){
            mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference=FINISHINSPECTIONVIEW;
            [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForLoadingROInspectionForm:mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormID_];
        }
        else{
            mAppDelegate_.mModelForOpenROInspectionFormWebEngine_.mFormReference=FINISHINSPECTIONVIEW;
            [mAppDelegate_.mModelForOpenROInspectionFormWebEngine_ requestForInspectionItems:mAppDelegate_.mModelForVehicleHistoryTableView_.mOpenROString_];
        }
    }
}

@end

