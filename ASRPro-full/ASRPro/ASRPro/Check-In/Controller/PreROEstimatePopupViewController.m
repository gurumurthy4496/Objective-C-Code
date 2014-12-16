//
//  PreROEstimatePopupViewController.m
//  ASRPro
//
//  Created by GuruMurthy on 02/05/14.
//  Copyright (c) 2014 VL. All rights reserved.
//

#import "PreROEstimatePopupViewController.h"
#import "CheckInSupportWebEngine.h"

@interface PreROEstimatePopupViewController () {
    AppDelegate *appDelegate_;
}
@property(nonatomic,retain) NSData *mWebData;

@end

@implementation PreROEstimatePopupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.activityIndicatorView_ startAnimating];
    appDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self setFontsandText];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.layer.cornerRadius = 0.0f;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view.superview.bounds = CGRectMake(0, 0, 600,600);
}

-(void)viewDidAppear:(BOOL)animated {
    //self.view.layer.cornerRadius = 0;
    [self loadDataToWebView];
    [self.pdfWebView_.scrollView setContentOffset:CGPointZero animated:YES];
}

#pragma Mark --
#pragma mark Private Methods
- (void)setFontsandText {
    if ([[[[SharedUtilities sharedUtilities] appDelegateInstance] isCustomHeaderViewFullOrLight] isEqualToString:@"FULL"]) {
        [self.titleLabel_ setText:@"Pre RO Estimate"];
    }else {
        [self.titleLabel_ setText:@"Customer Plan"];
    }
    [self.doneButton_ setTitle:@"Done" forState:UIControlStateNormal];
    [self.printButton_ setTitle:@"Print" forState:UIControlStateNormal];
    
}

- (void) tryPrintPdf
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    
    if ( pic && [UIPrintInteractionController canPrintData: self.mWebData] ) {
        pic.delegate = self;
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = @".pdf";
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        pic.printInfo = printInfo;
        pic.showsPageRange = YES;
        pic.printingItem = self.mWebData;
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
            if (!completed && error) {
                DLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
            }
        };
        [pic presentFromRect:self.printButton_.frame inView:self.printButton_.superview animated:YES completionHandler:completionHandler];
    }
}

- (void)loadDataToWebView {
    /*NSString *mWebURl = @"";
     mWebURl = [[SharedUtilities sharedUtilities] appDelegateInstance].mModelForCheckIn_.urlString;
     NSURL *targetURL = [NSURL URLWithString:mWebURl];
     NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
     [self.pdfWebView_ loadRequest:request];
     self.mWebData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:mWebURl]];*/
    
    {
        
        //    NSURL *targetURL = [NSURL URLWithString:mWebURl];
        //    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
        //    [self.mShowPdfView_ loadRequest:request];
        self.mWebData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForCheckIn_.urlString]];
        
        [self.pdfWebView_  loadData:self.mWebData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
        
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark --
#pragma mark UIwebview delegates
- (void)webViewDidStartLoad:(UIWebView *)webView {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicatorView_ stopAnimating];
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma Mark --
#pragma mark Button Actions
- (IBAction)doneButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    appDelegate_.mOnSuccessDelegate_ = self;
//    [[CheckInSupportWebEngine checkInSharedInstance] putRequestForROToBeMovedToDispatchMode];
}

- (IBAction)printButtonAction:(id)sender {
    [self tryPrintPdf];
}

#pragma Mark --
#pragma mark Delegate Methods
- (void)OnsuccessResponseForRequest {
    if (![[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_.topViewController isKindOfClass:[SearchViewController class]]) {
        [[[SharedUtilities sharedUtilities] appDelegateInstance].mECSlidingViewController_ setTopViewController:[[SharedUtilities sharedUtilities] appDelegateInstance].mSearchViewController_];
    }
    for (UIView *lview in [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.view.subviews) {
        if([lview isKindOfClass:[UIButton class]]) {
            if (lview.tag == 3) {
                [[[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_ segmentBtnAction:(UIButton *)lview];
                [[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_->mselectedSegment_ = 3;
            }
        }
    }
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForVehicleHistoryTableView_ setMCurrentMode_:2];
    [[SharedUtilities sharedUtilities] appDelegateInstance].mSearchDataGetter_.mOpenROListDisplayData_ = nil;
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_.mOpenROTableView_ reloadData];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mModelForSearchScreen_ setMDoneCheckInTOOpenROView_:DoneToOPenROMode];
    [[[SharedUtilities sharedUtilities] appDelegateInstance].mMasterViewController_ postRequestToGetRepairOrders];
}

@end
