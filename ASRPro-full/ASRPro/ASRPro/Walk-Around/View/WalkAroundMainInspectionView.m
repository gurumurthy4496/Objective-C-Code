//
//  WalkAroundMainInspectionView.m
//  ASRPro
//
//  Created by Kalyani on 12/02/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "WalkAroundMainInspectionView.h"
#import "AddServicePopupViewController.h"
@interface WalkAroundMainInspectionView(){

}
@property (nonatomic,retain)AddServicePopupViewController *mAddServicePopupViewController_;
@property(nonatomic,retain)NSMutableArray* mSGIDsArray_;
@end

@implementation WalkAroundMainInspectionView
@synthesize mInspectionDetailsView_;
@synthesize mTiremeasurementsView_;
@synthesize mAddServicePopupViewController_;
@synthesize mSGIDsArray_;

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

-(void)initTheViews{
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];

    mTiremeasurementsView_=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 700, 298)];
    [self addSubview:mTiremeasurementsView_];

    mInspectionDetailsView_=[[UIScrollView alloc] initWithFrame:CGRectMake(714, 0, 280, 298)];
    [self addSubview:mInspectionDetailsView_];
    [self.mTiremeasurementsView_.layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
    [self.mTiremeasurementsView_ .layer setBorderWidth:2.0];
    [self.mInspectionDetailsView_.layer setBorderColor:[UIColor colorWithRed:(20.0/255.0) green:(107.0/255.0) blue:(255.0/255.0) alpha:1.0].CGColor];
    [self.mInspectionDetailsView_ .layer setBorderWidth:2.0];
    [self addInspectionItemsToView];
}


-(void)addInspectionItemsToView{
    int m=0;
    int n=0;
    [mAppDelegate_.mModelForCheckIn_.mInspectionAllItemsArray_ removeAllObjects];
    DLog(@"%@",mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_ );

    ModelForLaneInspectionFormView* lModelforInspectionItemsView=[[ModelForLaneInspectionFormView alloc] init];
    NSMutableArray* lTempArray=[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_ objectForKey:@"Categories"];

    for(int i=0;i<[lTempArray count];i++){
        if([[[lTempArray objectAtIndex:i] objectForKey:@"Active"] boolValue]){

        //adding category to view
        m=0;
        n=0;
        NSMutableArray* lTempArray1=[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_  objectForKey:@"Categories"] objectAtIndex:i] objectForKey:@"Items"];

        for(int j=0;j<[lTempArray1 count];j++){
           if([[[[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_  objectForKey:@"Categories"] objectAtIndex:i] objectForKey:@"Items"] objectAtIndex:j] objectForKey:@"ShowInLaneApp"] boolValue]){
            NSMutableDictionary* lItemDict=[[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_  objectForKey:@"Categories"] objectAtIndex:i] objectForKey:@"Items"] objectAtIndex:j];
               [mAppDelegate_.mModelForCheckIn_.mInspectionAllItemsArray_ addObject:lItemDict];
                if(([[lItemDict objectForKey:@"ItemTypeID"] intValue]==0)&&(m==0)){
                    [self.mInspectionDetailsView_ addSubview:[lModelforInspectionItemsView addCategoryView:[NSString  stringWithFormat:@"%@",[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_ objectForKey:@"Categories"] objectAtIndex:i] objectForKey:@"Name"]] isTires:FALSE]];
                    m=1;
                }
                if(([[lItemDict objectForKey:@"ItemTypeID"] intValue]!=0)&&(n==0)){
                    [self.mTiremeasurementsView_ addSubview:[lModelforInspectionItemsView addCategoryView:[NSString  stringWithFormat:@"%@",[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionFormDict_ objectForKey:@"Categories"] objectAtIndex:i] objectForKey:@"Name"]] isTires:TRUE]];
                    n=1;
                }

            int i=[self returnIndexFromItemArray:[lItemDict objectForKey:@"IIID"]];
            NSMutableDictionary* lTempDict=nil;
            if(i!=-1)
                lTempDict=[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionItemsArray_ objectAtIndex:i];
               if([[lItemDict objectForKey:@"Active"] boolValue]){

                // adding items to view
                switch ([[lItemDict objectForKey:@"ItemTypeID"] intValue]) {
                    case 0:
                    {
                        [self.mInspectionDetailsView_ addSubview:[lModelforInspectionItemsView addInspectionButtonView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 1:
                    {
                        [self.mTiremeasurementsView_ addSubview:[lModelforInspectionItemsView addInspectionCheckButtonView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 2:
                    {
                        [self.mTiremeasurementsView_ addSubview:[lModelforInspectionItemsView addInspectionRadioButtonView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 3:
                    {
                        [self.mTiremeasurementsView_ addSubview:[lModelforInspectionItemsView addInspectionSliderView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 4:
                    {
                        [self.mTiremeasurementsView_ addSubview:[lModelforInspectionItemsView addInspectionPickerView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 5:
                    {
                        [self.mTiremeasurementsView_ addSubview:[lModelforInspectionItemsView addInspectionTextView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    case 6:
                    {
                        [self.mTiremeasurementsView_ addSubview:[lModelforInspectionItemsView addInspectionTextFieldView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                    default:
                    {
                        [self.mInspectionDetailsView_ addSubview:[lModelforInspectionItemsView addInspectionButtonView:lItemDict valueDict:lTempDict]];
                        break;
                    }
                }
                }
            }
        }
      }
    }
    [mTiremeasurementsView_ setContentSize:CGSizeMake(700, lModelforInspectionItemsView->yTiresPos+30)];
    [mInspectionDetailsView_ setContentSize:CGSizeMake(280, lModelforInspectionItemsView->yItemsPos+30)];
}


-(int)returnIndexFromItemArray:(NSString *)IIID  { // this method is to return the matching index to IIID
    for(int i=0;i<[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionItemsArray_ count];i++){
        if([IIID intValue]==[[[mAppDelegate_.mOpenROInspectionDataGetter_.mInspectionItemsArray_ objectAtIndex:i]objectForKey:@"IIID"] intValue])
            return i;
    }
    return -1;
}


-(void)addServicePopupView:(int)xPos :(int)yPos :(NSMutableArray*)aArray :(int)tag :(int)type{
    if( [mAppDelegate_.isCustomHeaderViewFullOrLight isEqualToString:@"FULL"]){
  AddServicePopupViewController* lAddServicePopupViewController_=[[AddServicePopupViewController alloc] initWithNibName:@"AddServicePopupViewController" bundle:nil];
        [self setMAddServicePopupViewController_:lAddServicePopupViewController_];
    [mAddServicePopupViewController_ setMFormtype:LANEINSPECTION];
        [mAddServicePopupViewController_.view setFrame:CGRectMake(xPos-39, yPos-47, 108, 47)];
        [self setMSGIDsArray_:aArray];
    if(type==0)
        [self.mInspectionDetailsView_ addSubview:mAddServicePopupViewController_.view];
    else
        [self.mTiremeasurementsView_ addSubview:mAddServicePopupViewController_.view];
   isRequireAttention =(tag==3)?TRUE:FALSE;
    }
    }
    

-(void)removeAddServicePopupView{
    [self.mAddServicePopupViewController_.view removeFromSuperview];
}


-(void)loadServices{
    mAppDelegate_.mServiceDataGetter_.mPayTypesArray_=[[FileUtils fileUtils] loadArrayFromFile:kPAYTYPESPATH];
    if(mAppDelegate_.mServiceDataGetter_.mPayTypesArray_==nil){
        [mAppDelegate_.mModelforOpenROSupportEngine_ RequestForGetPayTypes];
    }

    mAppDelegate_.mServiceDataGetter_.mAllServicesArray_=[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPATH];
    if(  mAppDelegate_.mServiceDataGetter_.mAllServicesArray_==nil)
    {
        mAppDelegate_.mModelForServiceRequestWebEngine_.mGetServiceReference_=WALKAROUNDCONTROLLER;
        [mAppDelegate_.mModelForServiceRequestWebEngine_ RequestForServiceLines];
        
    }
    else{
        [[SharedUtilities sharedUtilities] createLoadView];
        [self performSelector:@selector(pushToServicesList) withObject:mAppDelegate_.mWalkAroundViewController_ afterDelay:0.5];
        mAppDelegate_.mServiceDataGetter_.mModelForSelectedService_.mColor_=isRequireAttention?@"Red":@"Yellow";
    }
}

- (void)pushToServicesList {
    
    [mAppDelegate_.mWalkAroundViewController_ pushToServicesList];
}

-(NSMutableArray*)getServiceLines{
    NSMutableArray* lServicesArray=[[FileUtils fileUtils] loadArrayFromFile:kALLSERVICESPATH];
    NSMutableArray* lCurrentArray=[NSMutableArray new] ;
    
    for(int i=0;i<[mSGIDsArray_ count];i++)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.SGID = %@",[mSGIDsArray_ objectAtIndex:i]];
        NSArray *lArray = [lServicesArray filteredArrayUsingPredicate:predicate];
      //  DLog(@"Current SGID's : %@",lArray);
        [lCurrentArray addObjectsFromArray:lArray];
    }
  //  [[SharedUtilities sharedUtilities] removeLoadView];

    return lCurrentArray;
}
@end
