//
//  OnsuccessProtocol.h
//  Medifast
//
//  Created by Ramesh Muthe on 17/09/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OnsuccessProtocol <NSObject>

@optional
-(void)OnsuccessResponseForRequest;
-(void)OnsuccessResponseForServices;
@end
