//
//  SharedUtilities.h
//  ASRPro
//
//  Created by GuruMurthy on 07/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadingView.h"

@class AppDelegate;
@class LoadingView;

@interface SharedUtilities : NSObject {
    AppDelegate *mAppDelegate_;
}

#pragma mark --
#pragma mark Loading View
@property (retain, nonatomic) LoadingView *mLoadingView_;


/**
 * method for getting the instance of class
 */
+ (id)sharedUtilities;
/**
 * method for allocWithZone
 */
+ (id)allocWithZone:(NSZone *)zone;

#pragma mark --
#pragma mark Shared Methods

/**
 * Method to get AppDelegate Instance.
 */
- (AppDelegate *) appDelegateInstance;

/**
 * Method to display LoadView.
 */
- (void)createLoadView;
/**
 * Method to remove LoadView.
 */
- (void)removeLoadView;

/**
 * Method for dynamic Label Height For TextCharacterWrap.
 */
-(int)dynamicLabelHeightForTextCharacterWrap:(NSString *)text :(int)width :(UIFont *)font :(NSLineBreakMode)lineBreakMode;

/**
 * Method to hide empty rows in TableView.
 * @param UITableView -> tableView
 */
- (void)hideEmptySeparators:(UITableView *)tableView;

/**
 * Method to get Date From .Net JSON String.
 */
- (NSDate *)dateFromDotNetJSONString:(NSString *)string;

/**
 * Method to show alert with alert and message.
 */
- (void)showAlertWithTitle:(NSString*)title
                   message:(NSString*)message;
/**
 * Method to hide empty rows in TableView.
 * @param UITableView -> tableView
 */
- (NSString *)getIntFromString:(NSString *)mstring;

/**
 * readArrayFromUserDefaultsforKey Method to read an array from userDefaults
 * @param aKey to read an read which this key from userdefaults
 */
- (id)readObjectFromUserDefaultsforKey:(NSString *)aKey;
/**
 * writeArrayToUserDefaults Method to write an array to userDefaults
 * @param aArray refers to the NSarray to be stored
 * @param aKey refres to the key for which the array is to set
 */
- (void)writeObjectToUserDefaults:(id)aObject
                          forKey:(NSString *)aKey;

- (void)writeDateToUserDefaults:(NSDate*)aDate
                         forKey:(NSString*)aKey;

#pragma mark --
#pragma mark Methods for Storing Data into Files
/**
 * Store Dictionary into files.
 * @param my Object -> NSMutableDictionary.
 * @param myPath -> indicates where the data should be stored.
 */
- (NSString *)saveDictionaryInToFile:(NSObject *)myObject
                                    :(NSString *)myPath;
-(BOOL)deleteFileFromPath:(NSString *)path;
/**
 * Retrieve data from files.
 * @param mypath -> indicates where the data is stored.
 */
- (NSMutableDictionary *)retrieveDictionaryFromFile:(NSString *)myPath;

- (NSString *)saveArrayInToFile:(NSObject *)myObject :(NSString *)myPath;
- (NSMutableArray *)retrieveArrayFromFile:(NSString *)myPath;

-(NSString *)saveDataInToFile:(NSData *)myData :(NSString *)myFolder :(NSString *)myPath;
-(NSData *)loadDataFromFile:(NSString *)myFolder :(NSString *)myPath;

-(NSString*)ConvertRequestDictToJSONString:(NSMutableDictionary*)aDataDict;
-(NSString*)ConvertStringToJSONString:(NSString*)aDataDict;
-(NSString*)ConvertRequestDictToJSONStringwithoutdata:(NSMutableDictionary*)aDataDict ;


-(int)dynamiclabelHeightForTextCharacterWrap:(NSString *)text :(int)width :(UIFont *)font :(NSLineBreakMode)lineBreakMode;


@end
