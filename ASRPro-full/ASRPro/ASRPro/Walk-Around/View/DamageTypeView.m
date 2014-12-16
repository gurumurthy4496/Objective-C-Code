//
//  DamageTypeView.m
//  ASRPro
//
//  Created by GuruMurthy on 11/09/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "DamageTypeView.h"


@implementation DamageTypeView
@synthesize draggedImageView;
@synthesize draggedView;

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

- (void)initializationForView {
    [self.layer setBorderWidth:2.0f];
    [self.layer setBorderColor:[UIColor ASRProBlueColor].CGColor];
    [self setDamageTypeImagesAndViews];
}

- (void)setDamageTypeImagesAndViews {
    damagesImagesArray = [NSArray arrayWithObjects:@"Ding_Blue",@"Dent_Blue",@"Scratch_Blue",@"Chip_Blue",@"Crack_Blue", nil];
    CGFloat xCoord = 0,yCoord = 0,width = 98,height = 40;

    for (int iterate = 1; iterate <= 5; iterate ++) {
        //view
        UIView *view = [[UIView alloc] init];
        [view setFrame:CGRectMake(xCoord, yCoord, width, height)];
        [view setTag:iterate + 1000];
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handlePanning:)];
        [recognizer setDelegate:self];
        [view addGestureRecognizer:recognizer];
        
        [self addSubview:view];
        //damageImageView
        UIImage *image = [UIImage imageNamed:[damagesImagesArray objectAtIndex:iterate-1]];
        UIImageView *damageImageView = [[UIImageView alloc] init];
        [damageImageView setFrame:CGRectMake(5, (self.frame.size.height - image.size.height)/2, image.size.width, image.size.height)];
        [damageImageView setTag:iterate + 2000];
        [damageImageView setImage:image];
        [view addSubview:damageImageView];
        //damageLabel
        UILabel *damageLabel = [[UILabel alloc] init];
        [damageLabel setFrame:CGRectMake(damageImageView.frame.size.width + damageImageView.frame.origin.x + 5, (self.frame.size.height - image.size.height)/2,width - 30, image.size.height)];
        [damageLabel setText:[NSString stringWithFormat:@"%@",[self getTheStringUpToLetter:@"_" ActualString:[damagesImagesArray objectAtIndex:iterate-1]]]];
        [damageLabel setTextColor:[UIColor ASRProBlueColor]];
        [damageLabel setFont:[UIFont regularFontOfSize:15 fontKey:kFontNameHelveticaNeueKey]];
        [view addSubview:damageLabel];
        xCoord += width;
    }
}

- (NSString *)getTheStringUpToLetter:(NSString *)aLetter ActualString:(NSString *)actualString {
    NSString *string = actualString;
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:aLetter]];
    return [array objectAtIndex:0];
}

#pragma mark--
#pragma mark Handel Pannign Guestures
- (void)handlePanning:(UIPanGestureRecognizer *)gestureRecognizer
{
    switch ([gestureRecognizer state]) {
        case UIGestureRecognizerStateBegan:
            [self startDragging:gestureRecognizer];
            break;
        case UIGestureRecognizerStateChanged:
            [self doDrag:gestureRecognizer];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            if(gestureRecognizer)
                [self stopDragging:gestureRecognizer];
            break;
        default:
            break;
    }
}

#pragma mark--
#pragma mark PannignGuesture Methods
- (void)startDragging:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *view = gestureRecognizer.view;
    NSData *tempArchiveView = [NSKeyedArchiver archivedDataWithRootObject:view];
    UIView *viewOfSelf = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchiveView];
    [self setDraggedView:viewOfSelf];
    UIImage *image = [UIImage imageNamed:[damagesImagesArray objectAtIndex:self.draggedView.tag - 1001]];
    [self.draggedView.subviews enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop) {
        if ([object isKindOfClass:[UIImageView class]]) {
            [self setDraggedImageView:object];
            [self.draggedImageView setImage:image];
        }
    }];
    CGPoint pointInSrc = [gestureRecognizer locationInView:self];
    if([self pointInside:pointInSrc withEvent:nil]) {
        [self startDraggingFromSrcAtPoint:pointInSrc];
    }
    
}

- (void)startDraggingFromSrcAtPoint:(CGPoint)point {
    if(self.draggedImageView != nil) {
        CGPoint origin = self.draggedImageView.frame.origin;
        
        origin.x += self.frame.origin.x
         + self.draggedView.frame.origin.x;
        origin.y += [self superview].frame.origin.y;
        previousPostition=self.draggedView.frame.origin.x;
        origin.y -= 20;// to be on top of fingure
        
        [self initDraggedCellWithCell:self.draggedImageView AtPoint:origin];
    }
}

- (void)initDraggedCellWithCell:(UIView *)cell AtPoint:(CGPoint)point
{
    // get rid of old cell, if it wasn't disposed already
//    if(draggedImageView != nil) {
//        [draggedImageView removeFromSuperview];
//    }
    
    CGRect frame = CGRectMake(point.x, point.y, cell.frame.size.width, cell.frame.size.height);
    self.draggedImageView.frame = frame;
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_].mView_ addSubview:self.draggedImageView];
    
}

- (void)doDrag:(UIPanGestureRecognizer *)gestureRecognizer
{
    if(self.draggedImageView != nil )
    {
        CGPoint translation = [gestureRecognizer translationInView:[self.draggedImageView superview]];
        [self.draggedImageView setCenter:CGPointMake([self.draggedImageView center].x + translation.x,
                                           [self.draggedImageView center].y + translation.y)];
        [gestureRecognizer setTranslation:CGPointZero inView:[self.draggedImageView superview]];

    }
}

- (void)stopDragging:(UIPanGestureRecognizer *)gestureRecognizer
{
    BuildInspectionDetailsViewController *lViewCotroller = [[BuildInspectionDetailsViewController alloc] initWithNibName:@"BuildInspectionDetailsViewController" bundle:nil];
    [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] mVehicleDiagramsImageView_].mBuildInspectionDetailsViewController_ = lViewCotroller;
    [[SharedUtilities sharedUtilities] appDelegateInstance]. buildInspectionDetailsViewController = [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] mVehicleDiagramsImageView_].mBuildInspectionDetailsViewController_;
    [[SharedUtilities sharedUtilities] appDelegateInstance].mGetVehicleDamagepointOnImageView_ = [[SharedUtilities sharedUtilities] appDelegateInstance].mWalkAroundViewController_.mVehicleDiagramsImageView_;

    int index = [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].contentOffset.x/981;
    
    VehicleDiagramsImageView *imageView = [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] imagesArray] objectAtIndex:index];
    
    CGPoint localePoint = self.draggedImageView.center;
    UIView *view = [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] mView_] hitTest:localePoint withEvent:nil];
    
    localePoint.x -= imageView.frame.origin.x - [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].contentOffset.x;
    
    localePoint.y -= imageView.frame.origin.y - [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].contentOffset.y;
    
//    CGPoint localePoint1 = [gestureRecognizer locationInView:[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] mView_]];
    
//    UIView *view1 = [[[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] mView_] hitTest:localePoint1 withEvent:nil];
//    localePoint1.x -= imageView.frame.origin.x - [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].contentOffset.x;
//    
//    localePoint1.y -= imageView.frame.origin.y - [[[[SharedUtilities sharedUtilities] appDelegateInstance] mWalkAroundViewController_] scrollView].contentOffset.y;
    DLog(@"%@",view);
    DLog(@"%@",NSStringFromCGPoint(localePoint));
    
//    DLog(@"%@",view1);
//    DLog(@"%@",NSStringFromCGPoint(localePoint1));
    if (view != nil && [view isKindOfClass:[VehicleDiagramsImageView class]]) {
        [[WalkAroundSupportWebEngine walkAroundSharedInstance] setMVehicleDiagramRequest_:VehicleDiagramPOSTRequest];
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mImageData_ = nil;
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mNotesString_ = @"";
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mDamageTypeIndex_ = self.draggedView.tag - 1000;
        [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForWalkAround_.mSeverityTypeIndex_ = 3;
        CGPoint morigin=self.draggedImageView.frame.origin;
        morigin.x-=previousPostition;
        [[[[SharedUtilities sharedUtilities] appDelegateInstance] mModelForWalkAround_] setXCoordAndYCoord:localePoint];
        //----- POST REQUEST METHOD FOR WALK-AROUND DETIALS -----
        if ([[WalkAroundSupportWebEngine walkAroundSharedInstance] mVehicleDiagramRequest_] == VehicleDiagramPOSTRequest) {
            [[WalkAroundSupportWebEngine walkAroundSharedInstance] postRequestForDamageDetails];
        }
        [[SharedUtilities sharedUtilities] appDelegateInstance].mOnSuccessDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance].buildInspectionDetailsViewController;
    }
    [self.draggedImageView removeFromSuperview];
}

@end
