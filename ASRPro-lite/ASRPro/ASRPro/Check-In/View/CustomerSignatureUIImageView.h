//
//  CustomerSignatureUIImageView.h
//  ASRPro
//
//  Created by GuruMurthy on 18/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerSignatureUIImageView : AsyncCustImageView {
    CGPoint lastPoint;
    CGPoint startingPoint;
    //Flag value for mouseSwiped
	BOOL mouseSwiped;
	int mouseMoved;
	
}

@property (nonatomic, retain) NSData *mSignatureData_;

/**
 *Move lastPointsArr points of CustomerSignature in to Array.
 */
@property (nonatomic, retain) NSMutableArray *lastPointsArr;
/**
 *Move currentPointsArr points of CustomerSignature in to Array.
 */
@property (nonatomic, retain) NSMutableArray *currentPointsArr;
/**
 *Move all points of CustomerSignature in to Dictionary.
 */
@property (nonatomic, retain) NSMutableDictionary *movingPointsDict;
- (void)initializationForSignatureImageView;
@end
