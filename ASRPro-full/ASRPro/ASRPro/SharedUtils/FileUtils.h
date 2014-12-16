//
//  FileUtils.h
//  ASRPro
//
//  Created by Kalyani on 10/21/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject

/**
 * method for getting the instance of class
 */
+ (id)fileUtils;
/**
 * method for allocWithZone
 */
+ (id)allocWithZone:(NSZone *)zone;
/**
 * Store Array into files.
 * @param anObject -> NSMutableArray.
 * @param aPath -> indicates where the data should be stored.
 */
-(NSString *)saveArrayInToFile:(NSObject *)anObject
                          Path:(NSString *)aPath;
/**
 * Retrieve Array from files.
 * @param aPath -> indicates where the data is stored.
 */
- (NSMutableArray *) loadArrayFromFile:(NSString *)aPath;
/**
 * Store Data into files.
 * @param anObject -> NSData
 * @param aFolderName -> indicates folder name in which the data should be stored..
 * @param aPath -> indicates where the data should be stored.
 */
-(NSString *)saveDataInToFile:(NSData*)anObject
                   FolderName:(NSString*)aFolderName
                         Path:(NSString*)aPath;
/**
 * Retrieve Data from files.
 * @param aFolderName -> indicates folder name in which the data is stored..
 * @param aPath -> indicates where the data is stored.
 */
-(NSData *)loadDataFromFile:(NSString*)aFolderName
                       Path:(NSString*)aPath;
/**
 * Store Dictionary into files.
 * @param anObject -> NSMutableDictionary.
 * @param aPath -> indicates where the data should be stored.
 */
-(NSString *)saveDictionaryInToFile:(NSObject *)anObject
                               Path:(NSString *)aPath;
/**
 * Retrieve Dictionary from files.
 * @param aPath -> indicates where the data is stored.
 */
- (NSMutableDictionary *) loadDictionaryToFile:(NSString *)aPath;
/**
 * Store Dictionary into files.
 * @param anObject -> NSDictionary
 * @param aFolderName -> indicates folder name in which the dictionary should be stored..
 * @param aPath -> indicates where the dictionary should be stored.
 */
-(NSString *)saveDictionaryInToFileFolder:(NSObject*)anObject
                               FolderName:(NSString*)aFolderName
                                     Path:(NSString*)aPath;
/**
 * Retrieve Data from files.
 * @param aFolderName -> indicates folder name in which the data is stored.
 * @param aPath -> indicates where the data is stored.
 */
-(NSMutableDictionary *)loadDictionaryFromFileFolder:(NSString*)aFolderName
                                                Path:(NSString*)aPath;
/**
 * Delete file from path.
 * @param aPath -> indicates where the file is stored.
 */
-(BOOL)deleteFileFromPath:(NSString *)aPath;
/**
 * Delete all files from folder.
 * @param aFolderName -> indicates folder name 
 */
-(void)deleteAllFilesFromPath:(NSString*)aFolderName;
-(void)deleteFileFromFolder:(NSString*)aFolderName :(NSString*)Filename;

@end
