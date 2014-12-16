//
//  DataBaseUtilsClass.m
//  WebAndMaps
//
//  Created by Ramesh Muthe on 04/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataBaseUtilsClass.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

//****************** DBName   ***********************//
#define mDataBaseName @"GM_IndiaDB.sqlite"


@implementation DataBaseUtilsClass

static DataBaseUtilsClass *dBInstance = nil ;

-(id)init
{
	return self;
}
+(DataBaseUtilsClass*)instance {
	
	@synchronized (self){
		if (nil==dBInstance) {
			dBInstance=[[DataBaseUtilsClass alloc]init];
			
		}
		return dBInstance;
	}
	return nil;
}
/***********	Files 		*******/
#pragma mark Files
-(NSString *)saveArrayInToFile:(NSObject *)myObject :(NSString *)myPath{
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:myPath];
    [(NSMutableArray *)myObject writeToFile:path atomically:YES];
    return path;
}

- (NSMutableArray *) loadArrayFromFile:(NSString *)myPath {
    
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:myPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath: path]) {
        NSMutableArray *dataArray= [[NSMutableArray alloc] initWithContentsOfFile: path];
        return dataArray;
    }else {
        DLog(@"File not found");
        return nil;
    }
   
} 

- (NSMutableDictionary *) loadDictionaryToFile:(NSString *)myPath {
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:myPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath: path]) {
        NSMutableDictionary *dataArray= [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        return dataArray;
    }else {
        DLog(@"File not found");
        return nil;
    }
    
} 

-(NSString *)saveDictionaryInToFile:(NSObject *)myObject :(NSString *)myPath{
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:myPath];
    [(NSMutableDictionary *)myObject writeToFile:path atomically:YES];
    return path;
}

-(NSString *)saveDictionaryInToFileFolder:(NSObject *)myObject :(NSString *)myFolder :(NSString *)myPath{
    
    NSString *dataPath = [DOCUMENTS_FOLDER stringByAppendingPathComponent:myFolder];
    NSString *lPath=[myFolder stringByAppendingPathComponent:myPath];
    DLog(@"%@", dataPath);
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:lPath];
    [(NSMutableDictionary *)myObject writeToFile:path atomically:YES];
    return path; 
}

-(NSMutableDictionary *)loadDictionaryFromFileFolder :(NSString *)myFolder :(NSString *)myPath{
    NSString *lPath=[myFolder stringByAppendingPathComponent:myPath];
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:lPath];
      NSString *dataPath =[DOCUMENTS_FOLDER stringByAppendingPathComponent:myFolder];
    DLog(@"path %@",lPath);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath: dataPath]) {
        NSMutableDictionary *dataArray= [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        return dataArray;
    }else {
        DLog(@"File not found");
        return nil;
    }

}


-(NSString *)saveDataInToFile:(NSData *)myData :(NSString *)myFolder :(NSString *)myPath{

    NSString *dataPath = [DOCUMENTS_FOLDER stringByAppendingPathComponent:myFolder];
    NSString *lPath=[myFolder stringByAppendingPathComponent:myPath];
    DLog(@"%@", dataPath);
    NSError *error = NULL;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:lPath];
    [myData writeToFile:path atomically:YES];
    return path; 
}

-(NSData *)loadDataFromFile:(NSString *)myFolder :(NSString *)myPath{
    NSString *lPath=[myFolder stringByAppendingPathComponent:myPath];
    NSError *error = nil;  
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:lPath];
    lPath=[DOCUMENTS_FOLDER stringByAppendingPathComponent:myFolder];
   // DLog(@"path %@",lPath);
    if ([[NSFileManager defaultManager] fileExistsAtPath:lPath]) {
        NSData *ldata=[NSData dataWithContentsOfFile:path]; 
        return ldata;
    }
    else if ([[NSFileManager defaultManager] contentsOfDirectoryAtPath:[DOCUMENTS_FOLDER stringByAppendingPathComponent:myFolder] error:&error]) {
        NSData *ldata=[NSData dataWithContentsOfFile:path]; 
        return ldata;
    }else {
        DLog(@"File not found");
        return nil;
    }

}
-(BOOL)deleteFileFromPath:(NSString *)path{
    NSError *error = nil;  
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [DOCUMENTS_FOLDER stringByAppendingPathComponent:path];
    DLog(@"File : %@", filePath);
    
    BOOL fileDeleted = [fileManager removeItemAtPath:filePath error:&error];
    
    if (fileDeleted != YES || error != nil)
    {
        // Deal with the error...
    }
    return TRUE;
}
-(void)deleteAllFileFromDirectory:(NSString *)myDirectory{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        NSError *error = nil;  
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Print out the path to verify we are in the right place
        NSString *directory = [paths objectAtIndex:0];
        directory = [directory stringByAppendingPathComponent:myDirectory];
        DLog(@"Directory: %@", directory);
        
        // For each file in the directory, create full path and delete the file
        for (NSString *file in [fileManager contentsOfDirectoryAtPath:directory error:&error])
        {    
            NSString *filePath = [directory stringByAppendingPathComponent:file];
            DLog(@"File : %@", filePath);
            
            BOOL fileDeleted = [fileManager removeItemAtPath:filePath error:&error];
            
            if (fileDeleted != YES || error != nil)
            {
                // Deal with the error...
            }
        }
        
    }
    
}


#pragma mark UserDefaults
/***********	NsUserDefalts 		*******/
+ (void) writeDictionaryToUserDefaultsvalue:(NSDictionary*)aValue ForKey:(NSString*)aKey{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:aValue forKey:aKey];
    [defaults synchronize];
}

+ (NSDictionary*) readDictionaryFromUserDefaultsForKey:(NSString*)aKey{
    
    return([[NSUserDefaults standardUserDefaults] objectForKey:aKey]); 
}

+ (void)writetoUserDefaults:(NSString*)aValue forKey:(NSString*)aKey
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:aValue forKey:aKey];
    [defaults synchronize];
}

+ (NSString*)readStringFromUserDefaultsforKey:(NSString*)aKey
{
    return([[NSUserDefaults standardUserDefaults] objectForKey:aKey]);
}

+ (void)writenumbertoUserDefaults:(NSNumber*)aValue forKey:(NSString*)aKey
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:aValue forKey:aKey];
    [defaults synchronize];
}

+ (NSNumber*)readNumberfromUserDefaultsforKey:(NSString*)aKey
{
    return([[NSUserDefaults standardUserDefaults] objectForKey:aKey]);
}

+ (void)writeArrayToUserDefaults:(NSArray*)aArray forKey:(NSString*)aKey
{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:aArray forKey:aKey];
    [defaults synchronize];
}

+ (NSArray*) readArrayFromUserDefaultsforKey:(NSString*)aKey
{
    return([[NSUserDefaults standardUserDefaults] objectForKey:aKey]);	
}

+ (void)writeDateToUserDefaults:(NSDate*)aDate forKey:(NSString*)aKey
{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:aDate];
    [defaults setObject:data forKey:aKey];
	[defaults synchronize];
	
}

+ (NSDate*)readDateFromDefaultsForKey:(NSString*)aKey
{
	NSDate* date = (NSDate*)[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:aKey]];
	return date;
}

@end
