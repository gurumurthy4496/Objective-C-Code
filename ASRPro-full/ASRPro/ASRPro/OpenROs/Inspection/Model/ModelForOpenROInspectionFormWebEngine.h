//
//  ModelForOpenROInspectionFormWebEngine.h
//  ASRPro
//
//  Created by Kalyani on 04/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OpenROInspectionWebEngine.h"



@interface ModelForOpenROInspectionFormWebEngine : UIView{
@public
    /**
     * AppDelegate object creating
     */
    AppDelegate *mAppDelegate_;
    
}
@property(nonatomic,retain) OpenROInspectionWebEngine* mOpenROInspectionWebEngine_;
@property(nonatomic,assign)getformreference mFormReference;

- (id)init;
-(void)requestForLoadingInspectionFormList;
-(void)requestForLoadingAllInspectionForms;
-(void)requestForLoadingInspectionForm:(NSString*)aFormID;
-(void)requestForLoadingROInspectionForm:(NSString*)aFormID;
-(void)requestForDeleteInspectionItem;
-(void)requestForFormID:(NSString*)aRONumber;
-(void)requestForInspectionItems:(NSString*)aRONumber;
-(void)requestForAddInspectionItem:(NSString*)aRONumber
                       requestDict:(NSMutableDictionary*)aRequestDict;
-(void)requestForUpdateInspectionItem:(NSString*)aRONumber
                               itemID:(NSString*)anASRIID
                          requestDict:(NSMutableDictionary*)aRequestDict;
-(void)requestForchangeInspectionForm:(NSString*)aRONumber
                          requestDict:(NSMutableDictionary*)aRequestDict;
-(void)requestToChangeMode:(NSString*)aString;

-(void)createLoadViewInspection;
-(void)removeLoadViewInspection;
-(void)requestForCompleteInspection:(NSString*)aRONumber;
@end
