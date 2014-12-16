//
//  DataBaseUtilsClass.h
//  WebAndMaps
//
//  Created by Ramesh Muthe on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//#ifdef DEBUG
//#define DLog(fmt, ...) DLog(fmt, ## __VA_ARGS__)
//#else
//#define DLog(...)
//#endif
@interface DataBaseUtilsClass : NSObject

+(DataBaseUtilsClass*)instance;

/***********	Files 		*******/

//Files Methods which are  useful for Storing the Array and Data (images),so that we can over come memory waring
-(NSString *)saveArrayInToFile:(NSObject *)myObject :(NSString *)myPath;
- (NSMutableArray *) loadArrayFromFile:(NSString *)myPath;

-(NSString *)saveDataInToFile:(NSData *)myData :(NSString *)myFolder :(NSString *)myPath;
-(NSData *)loadDataFromFile:(NSString *)myFolder :(NSString *)myPath;

-(BOOL)deleteFileFromPath:(NSString *)path;
-(void)deleteAllFileFromDirectory:(NSString *)myDirectory;

-(NSString *)saveDictionaryInToFile:(NSObject *)myObject :(NSString *)myPath;
- (NSMutableDictionary *) loadDictionaryToFile:(NSString *)myPath;
-(NSString *)saveDictionaryInToFileFolder:(NSObject *)myObject :(NSString *)myFolder :(NSString *)myPath;
-(NSMutableDictionary *)loadDictionaryFromFileFolder:(NSString *)myFolder :(NSString *)myPath;
/***********	NsUserDefalts 		*******/

//NsUserDefalts Methods which are  useful for Storing the Array, Data (images) And any object for persistance storing

+ (void) writeDictionaryToUserDefaultsvalue:(NSDictionary*)aValue ForKey:(NSString*)aKey;
+ (NSDictionary*) readDictionaryFromUserDefaultsForKey:(NSString*)aKey;

+ (void)writetoUserDefaults:(NSString*)aValue forKey:(NSString*)aKey;
+ (NSString*)readStringFromUserDefaultsforKey:(NSString*)aKey;

+ (void)writenumbertoUserDefaults:(NSNumber*)aValue forKey:(NSString*)aKey;
+ (NSNumber*)readNumberfromUserDefaultsforKey:(NSString*)aKey;

+ (void)writeArrayToUserDefaults:(NSArray*)aArray forKey:(NSString*)aKey;
+ (NSArray*) readArrayFromUserDefaultsforKey:(NSString*)aKey;

+ (void)writeDateToUserDefaults:(NSDate*)aDate forKey:(NSString*)aKey;
+ (NSDate*)readDateFromDefaultsForKey:(NSString*)aKey;

@end
