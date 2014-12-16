//
//  FileUtils.m
//  ASRPro
//
//  Created by Kalyani on 10/21/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "FileUtils.h"
static FileUtils *fileUtils = nil;
@implementation FileUtils

+ (id)fileUtils {
    @synchronized(self) {
        if(fileUtils == nil)
            fileUtils = [[super allocWithZone:NULL] init];
    }
    return fileUtils;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self fileUtils] ;
}
- (id)init {
    if (self = [super init]) {
    }
    return self;
}


-(NSString *)saveArrayInToFile:(NSObject *)anObject
                          Path:(NSString *)aPath{
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:aPath];
    [(NSMutableArray *)anObject writeToFile:path atomically:YES];
    return path;
}

- (NSMutableArray *) loadArrayFromFile:(NSString *)aPath{
    
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:aPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath: path]) {
        NSMutableArray *dataArray= [[NSMutableArray alloc] initWithContentsOfFile: path] ;
        return dataArray;
    }else {
        DLog(@"File not found");
        return nil;
    }
    
}

-(NSString *)saveDataInToFile:(NSData*)anObject
                   FolderName:(NSString*)aFolderName
                         Path:(NSString*)aPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:aFolderName];
    NSString *lPath=[aFolderName stringByAppendingPathComponent:aPath];
   // DLog(@"%@", dataPath);
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:lPath];
    [(NSMutableDictionary *)anObject writeToFile:path atomically:YES];
    return path;
}

-(NSData *)loadDataFromFile:(NSString*)aFolderName
                       Path:(NSString*)aPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:aFolderName];
    
    NSString *lPath=[aFolderName stringByAppendingPathComponent:aPath];
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:lPath];
   // DLog(@"path %@",lPath);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath: dataPath]) {
        NSData *ldata=[NSData dataWithContentsOfFile:path];
        return ldata;
    }else {
        DLog(@"File not found");
        return nil;
    }
}

-(NSString *)saveDictionaryInToFile:(NSObject *)anObject
                               Path:(NSString *)aPath{
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:aPath];
    [(NSMutableDictionary *)anObject writeToFile:path atomically:YES];
    return path;
}

- (NSMutableDictionary *) loadDictionaryToFile:(NSString *)aPath{
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:aPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath: path]) {
        NSMutableDictionary *dataArray= [[NSMutableDictionary alloc] initWithContentsOfFile: path] ;
        return dataArray;
    }else {
        DLog(@"File not found");
        return nil;
    }
    
}

-(NSString *)saveDictionaryInToFileFolder:(NSObject*)anObject
                               FolderName:(NSString*)aFolderName
                                     Path:(NSString*)aPath{
   NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:aFolderName];
   NSString *lPath=[aFolderName stringByAppendingPathComponent:aPath];
   //DLog(@"%@", dataPath);
    NSError *error = nil;
   if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:lPath];
    [(NSMutableDictionary *)anObject writeToFile:path atomically:YES];
     return path;
}

-(NSMutableDictionary *)loadDictionaryFromFileFolder:(NSString*)aFolderName
                                                Path:(NSString*)aPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:aFolderName];

    NSString *lPath=[aFolderName stringByAppendingPathComponent:aPath];
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:lPath];
    DLog(@"path %@",lPath);
  //
    if ([[NSFileManager defaultManager] fileExistsAtPath: dataPath]) {
        NSMutableDictionary *dataArray= [[NSMutableDictionary alloc] initWithContentsOfFile: path] ;
        return dataArray;
    }else {
        DLog(@"File not found");
        return nil;
    }
}

-(BOOL)deleteFileFromPath:(NSString *)aPath{
    NSError *error = nil;

    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:aPath];
    
    BOOL fileDeleted = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if (fileDeleted != YES || error != nil)
    {
        // Deal with the error...
    }

    
    return TRUE;
}

-(void)deleteAllFilesFromPath:(NSString*)aFolderName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Print out the path to verify we are in the right place
        NSString *directory = [paths objectAtIndex:0];
        directory = [directory stringByAppendingPathComponent:aFolderName];
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

-(void)deleteFileFromFolder:(NSString*)aFolderName :(NSString*)Filename{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Print out the path to verify we are in the right place
        NSString *directory = [paths objectAtIndex:0];
        directory = [directory stringByAppendingPathComponent:aFolderName];
        DLog(@"Directory: %@", directory);
        
        // For each file in the directory, create full path and delete the file
            NSString *filePath = [directory stringByAppendingPathComponent:Filename];
            DLog(@"File : %@", filePath);
            
            BOOL fileDeleted = [fileManager removeItemAtPath:filePath error:&error];
            
            if (fileDeleted != YES || error != nil)
            {
                // Deal with the error...
            }
        }
        
}


@end
