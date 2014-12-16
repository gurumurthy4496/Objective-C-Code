//
//  CustomerSignatureUIImageView.m
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "CustomerSignatureUIImageView.h"

@implementation CustomerSignatureUIImageView
@synthesize mSignatureData_;
@synthesize lastPointsArr;
@synthesize currentPointsArr;
@synthesize movingPointsDict;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initializationForSignatureImageView {
    mouseMoved = 0;
    // ****** Initializing lastPointsArr, currentPointsArr, movingPointsDict ****
    self.lastPointsArr = [[NSMutableArray alloc]init];
	self.currentPointsArr = [[NSMutableArray alloc]init];
	self.movingPointsDict = [[NSMutableDictionary alloc]init];
    [self setContentMode:UIViewContentModeScaleAspectFit];
    if ([[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mCustomerAndVehicleInfoArray_ valueForKey:@"CustomerSignatureImageUrl"] length] == 0) {
        return;
    }else {
        self.mUIImageViewDispatchLoader_ = ISCustomerSignature;
        self.activityView = nil;
        [self setCustomImageURL:[NSURL URLWithString:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForCheckIn_].mCustomerAndVehicleInfoArray_ valueForKey:@"CustomerSignatureImageUrl"]]];
    }
}

#pragma mark --
#pragma mark Touch Event Methods For CustomerSignature.

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
	if ([touch tapCount] == 2)
    {
        return;
    }
    
    
    if ([touch view] == self)
    {
        //add your code for image touch here
        mouseSwiped = NO;
        // UITouch *touch = [touches anyObject];
        
        lastPoint = [touch locationInView:self];
        startingPoint= [touch locationInView:self];
        
        if([self.lastPointsArr count])
        {
            NSString *pStr=[NSString stringWithFormat:@"%0.0f,%0.0f",startingPoint.x,startingPoint.y];
            //if the last point and current points oone in the same then remove the objects from the currentPointsArr.
            if(![[self.lastPointsArr objectAtIndex:[self.lastPointsArr count]-1]isEqualToString:pStr ])
            {
                
                //			[currentPointsArr removeAllObjects];
            }
            
        }
        
        [self.lastPointsArr addObject:[NSString stringWithFormat:@"%0.0f,%0.0f",lastPoint.x,lastPoint.y]];
        
        //Explicitly adding first point as a -1,-1 and then the  starting point.
        [self.currentPointsArr addObject:@"-1,-1"];
        [self.currentPointsArr addObject:[NSString stringWithFormat:@"%0.0f,%0.0f",startingPoint.x,startingPoint.y]];
    }
    
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = YES;
	
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:self];
	
    UIGraphicsBeginImageContext(self.frame.size);
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
	
    self.image = UIGraphicsGetImageFromCurrentImageContext();
	
	[self.currentPointsArr addObject:[NSString stringWithFormat:@"%0.0f,%0.0f",currentPoint.x,currentPoint.y]];
	NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	
	
	NSString *pStr=[NSString stringWithFormat:@"%0.0f,%0.0f",startingPoint.x,startingPoint.y];
	NSString *dictFilePath = [NSString stringWithFormat:@"%@%@",docDir,kSIGNATURE_DATA_PATH];
	NSMutableDictionary *pDict;
	if([[NSFileManager defaultManager] fileExistsAtPath:dictFilePath])
	{
		pDict=[[NSMutableDictionary alloc]initWithDictionary:[NSMutableDictionary dictionaryWithContentsOfFile:dictFilePath] copyItems:YES];
	}
	else {
		pDict=[[NSMutableDictionary alloc]init];
	}
	
	[pDict setObject:self.currentPointsArr forKey:pStr];
	[self.movingPointsDict setObject:self.currentPointsArr forKey:pStr];
    
    //Saving the dictionary (Array of points ) to file system.
	
	[pDict writeToFile:dictFilePath atomically:YES];
	
	UIGraphicsEndImageContext();
	
    lastPoint = currentPoint;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
		
    // if(!mouseSwiped)
    {
        UIGraphicsBeginImageContext(self.frame.size);
        [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 2.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 5.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.image = UIGraphicsGetImageFromCurrentImageContext();
		
        UIGraphicsEndImageContext();
    }
    NSData* pictureData = UIImageJPEGRepresentation(self.image, 1.0f);
    self.mSignatureData_ = pictureData;
    [[SharedUtilities sharedUtilities] saveDataInToFile:pictureData :kSIGNATURE_DATA_PATH :kSIGNATURE_DATA_PATH];
}

@end
