//
//  SharedUtilities.m
//  ASRPro
//
//  Created by GuruMurthy on 07/10/13.
//  Copyright (c) 2013 ASRPro. All rights reserved.
//

#import "SharedUtilities.h"

static SharedUtilities *sharedUtilities = nil;

@implementation SharedUtilities
//@synthesize someProperty;
@synthesize mLoadingView_;


#pragma mark --
#pragma mark Singleton Methods

+ (id)sharedUtilities {
    @synchronized(self) {
        if(sharedUtilities == nil)
            sharedUtilities = [[super allocWithZone:NULL] init];
    }
    return sharedUtilities;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedUtilities];
}

- (id)init {
    if (self = [super init]) {
        //        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
        mAppDelegate_ = [self appDelegateInstance];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark --
#pragma mark AppDelegateInstance
- (AppDelegate *) appDelegateInstance {
    return((AppDelegate *) [[UIApplication sharedApplication] delegate]);
}

#pragma mark --
#pragma mark LoadingView Methods
- (void)createLoadView {
    if (mLoadingView_ != nil) {
		mLoadingView_ = nil;
    }
	mLoadingView_ = [[LoadingView alloc]init];
    mLoadingView_.autoresizingMask= UIViewAutoresizingFlexibleWidth;
	[mLoadingView_ loadingViewInView:mAppDelegate_.window];
}

- (void)removeLoadView {
	if (mLoadingView_ != nil) {
		[mLoadingView_ removeView];
		mLoadingView_ = nil;
	}
}

#pragma mark --
#pragma mark Height for label in the
-(int)dynamicLabelHeightForTextCharacterWrap:(NSString *)text :(int)width :(UIFont *)font :(NSLineBreakMode)lineBreakMode
{
	
	CGSize maximumLabelSize = CGSizeMake(width,2500);
	
	CGSize expectedLabelSize = [text sizeWithFont:font
								constrainedToSize:maximumLabelSize
									lineBreakMode:lineBreakMode];
    
	
	return expectedLabelSize.height;
	
}

#pragma mark --
#pragma mark Hide Empty Separators in TableView
- (void)hideEmptySeparators:(UITableView *)tableView {
    UIView *emptyView_ = [[UIView alloc] initWithFrame:CGRectZero];
    emptyView_.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:emptyView_];
    RELEASE_NIL(emptyView_);
}

#pragma mark --
#pragma mark Date From .Net JSON String
- (NSDate *)dateFromDotNetJSONString:(NSString *)string {
    if ([string length] == 0) {
        return nil;
    }
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
            
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

#pragma mark --
#pragma mark Method to show alert with title and message
- (void)showAlertWithTitle:(NSString*)title
                   message:(NSString*)message{
	
	UIAlertView *lAlertView=[[UIAlertView alloc]initWithTitle:title
                                                      message:message
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"lALERT_OK", @"lALERT_OK")
                                            otherButtonTitles:nil];
	[lAlertView show];
	lAlertView = nil;
}

#pragma mark --
#pragma mark Method To Get Int From String
- (NSString*)getIntFromString:(NSString *)mstring {
    
    NSString *originalString = mstring;
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:originalString.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:originalString];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    return strippedString;
}

#pragma mark -
#pragma mark NSUserDefaults Methods
- (id)readObjectFromUserDefaultsforKey:(NSString *)aKey {
    return([[NSUserDefaults standardUserDefaults] objectForKey:aKey]);
}

- (void)writeObjectToUserDefaults:(id)aObject
                           forKey:(NSString *)aKey {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:aObject forKey:aKey];
    [defaults synchronize];
}

- (void)writeDateToUserDefaults:(NSDate*)aDate forKey:(NSString*)aKey
{
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:aDate];
    [defaults setObject:data forKey:aKey];
	[defaults synchronize];
	
}


#pragma mark --
#pragma mark Methods for Storing Data into Files
- (NSString *)saveDictionaryInToFile:(NSObject *)myObject
                                    :(NSString *)myPath {
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:myPath];
    [(NSMutableDictionary *)myObject writeToFile:path atomically:YES];
    return path;
}

- (NSMutableDictionary *)retrieveDictionaryFromFile:(NSString *)myPath {
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:myPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath: path]) {
        NSMutableDictionary *dataArray= [[NSMutableDictionary alloc] initWithContentsOfFile: path];
        return dataArray;
    }else {
        DLog(@"File not found");
        return nil;
    }
    
}


- (NSString *)saveArrayInToFile:(NSObject *)myObject :(NSString *)myPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:myPath];
    [(NSMutableArray *)myObject writeToFile:filePath atomically:YES];
    return filePath;
}

- (NSMutableArray *)retrieveArrayFromFile:(NSString *)myPath {
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:myPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath: path]) {
        NSMutableArray *dataArray= [[NSMutableArray alloc] initWithContentsOfFile: path];
        return dataArray;
    }else {
        DLog(@"File not found");
        return nil;
    }
    
}

-(NSString*)ConvertRequestDictToJSONString:(NSMutableDictionary*)aDataDict {
NSMutableDictionary* lTempDict=[[NSMutableDictionary alloc] init];
    if(aDataDict!=nil)
        [lTempDict setObject:aDataDict forKey:@"Data"];

    [lTempDict setObject:[NSString stringWithFormat:@"%@", mAppDelegate_.mModelForSplashScreen_.mEmployeeID_] forKey:@"UserID"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:lTempDict options:kNilOptions error:&error];
    if (! jsonData) {
        return @"{}";
    } else {
        DLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);

        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
}
-(NSString*)ConvertRequestDictToJSONStringwithoutdata:(NSMutableDictionary*)aDataDict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:aDataDict options:kNilOptions error:&error];
    if (! jsonData) {
        return @"{}";
    } else {
        DLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);

        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

-(NSString*)ConvertStringToJSONString:(NSString*)aDataDict{
   NSMutableDictionary* lTempDict=[[NSMutableDictionary alloc] init];
    if(aDataDict!=nil)
        [lTempDict setObject:aDataDict forKey:@"Data"];
    
    [lTempDict setObject:[NSString stringWithFormat:@"%@", mAppDelegate_.mModelForSplashScreen_.mEmployeeID_] forKey:@"UserID"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:lTempDict options:kNilOptions error:&error];
    if (! jsonData) {
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

-(NSString *)saveDataInToFile:(NSData *)myData :(NSString *)myFolder :(NSString *)myPath {
    
    NSString *dataPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:myFolder];
    NSString *lPath=[myFolder stringByAppendingPathComponent:myPath];
    DLog(@"%@", dataPath);
    NSError *error = NULL;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:lPath];
    [myData writeToFile:path atomically:YES];
    return path;
}

-(BOOL)deleteFileFromPath:(NSString *)path {
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:path];
    DLog(@"File : %@", filePath);
    BOOL fileDeleted = [fileManager removeItemAtPath:filePath error:&error];
    
    if (fileDeleted != YES || error != nil)
    {
        // Deal with the error...
    }
    return TRUE;
}


-(NSData *)loadDataFromFile:(NSString *)myFolder :(NSString *)myPath {
    NSString *lPath=[myFolder stringByAppendingPathComponent:myPath];
    NSError *error = nil;
    NSString *path = [(NSString *) [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:lPath];
    lPath=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:myFolder];
    // DLog(@"path %@",lPath);
    if ([[NSFileManager defaultManager] fileExistsAtPath:lPath]) {
        NSData *ldata=[NSData dataWithContentsOfFile:path];
        return ldata;
    }
    else if ([[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:myFolder] error:&error]) {
        NSData *ldata=[NSData dataWithContentsOfFile:path];
        return ldata;
    }else {
        DLog(@"File not found");
        return nil;
    }
    
}

-(int)dynamiclabelHeightForTextCharacterWrap:(NSString *)text :(int)width :(UIFont *)font :(NSLineBreakMode)lineBreakMode
{
	
	CGSize maximumLabelSize = CGSizeMake(width,2500);
	
	CGSize expectedLabelSize = [text sizeWithFont:font
								constrainedToSize:maximumLabelSize
									lineBreakMode:lineBreakMode];
	
	
	return expectedLabelSize.height;
	
	
}

@end

//#warning UIStrikedLabel Class Which is not in use
@interface UIStrikedLabel : UILabel

- (void)drawTextInRect:(CGRect)rect;

@end
//TODO: The below lines are important don't delete the lines
//CGSize textSize = [[label text] sizeWithFont:[label font]];
//
//CGFloat strikeWidth = textSize.width;
@implementation UIStrikedLabel

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context,CGRectMake(0,rect.size.height/2,rect.size.width,1));
}
@end


