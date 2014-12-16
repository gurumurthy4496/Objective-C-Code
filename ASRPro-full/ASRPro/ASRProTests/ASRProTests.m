//
//  ASRProTests.m
//  ASRProTests
//
//  Created by GuruMurthy on 27/01/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ASRProTests : XCTestCase

@end

@implementation ASRProTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

//- (void)testAPI {
//    
//    NSString *mRequestStr = @"";
//    mRequestStr = [NSString stringWithFormat:@"%@Stores/%@/VehicleDiagramSets",WEBSERVICEURL,@"1"];
//    mRequestStr = [mRequestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    
//    NSError *jsonError;
//    NSMutableURLRequest *Projrequest=[NSMutableURLRequest
//                                      requestWithURL:[NSURL
//                                                      URLWithString:mRequestStr]
//                                      cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                                      timeoutInterval:60.0];
//    [Projrequest setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    [Projrequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [Projrequest setValue:@"Basic Q2hlY2tJbkFwcDowM2E1YkU4MDY4ZEM5YyA4ZGUyNDc=" forHTTPHeaderField:@"Authorization"];
//    [Projrequest setValue:@"json" forHTTPHeaderField:@"Format"];
//    [Projrequest setHTTPMethod:kGET];
//    NSURLResponse *responseURL;
//    NSData *response = [NSURLConnection
//                        sendSynchronousRequest:Projrequest
//                        returningResponse:&responseURL error:nil];
//    NSString *json_string = [[NSString alloc]
//                             initWithData:response encoding:NSUTF8StringEncoding];
//    
//    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)responseURL;
//    NSInteger responseCode = [httpResponse statusCode];
//    
//    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:[json_string dataUsingEncoding:NSUTF8StringEncoding]
//                                                                                                   options:kNilOptions error:&jsonError];
//    NSLog(@"VehicleDiagramSets Request:-%@",Projrequest);
//    NSLog(@"Data:-%@",response);
//    NSLog(@"VehicleDiagramSets Response:-%@",json_string);
//    NSLog(@"mVehicleDiagramSetsDictionary_:-%@",array);
//    NSString *responseCodeStr = [NSString stringWithFormat:@"%d",responseCode];
//}

@end
