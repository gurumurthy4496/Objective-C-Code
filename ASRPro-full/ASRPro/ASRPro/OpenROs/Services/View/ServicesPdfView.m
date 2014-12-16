//
//  ServicesPdfView.m
//  ASRPro
//
//  Created by Ramesh on 4/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ServicesPdfView.h"

@interface ServicesPdfView()
@property(nonatomic,retain) NSData*mWebData;
-(void)setFontsandText;
//-(void) PostRequestForCustomerPDF: (NSObject *) myObject;
-(void)loadDataToWebView;
@end

@implementation ServicesPdfView
@synthesize mHeaderLabel_;
@synthesize mShowPdfView_;
@synthesize mActivityIdicator_;
@synthesize mCancelBtn_;
@synthesize mWebURl;
@synthesize mTitle;
@synthesize mPrintBtn_;
@synthesize mWebData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mAppDelegate_ = [[SharedUtilities sharedUtilities] appDelegateInstance];
    [self.mActivityIdicator_ startAnimating];
    [self setFontsandText];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view.superview.bounds = CGRectMake(0, 0, 600,600);
}

-(void)viewDidAppear:(BOOL)animated {
    //self.view.layer.cornerRadius = 0;
    
    [self loadDataToWebView];
    [mShowPdfView_.scrollView setContentOffset:CGPointZero animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
  //  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.layer.cornerRadius = 0.0f;
}

#pragma Mark - ********************** Methods ***********************
#pragma mark
-(void)setFontsandText {
    [mHeaderLabel_ setText:mTitle];
    [mCancelBtn_ setTitle:@"Cancel" forState:UIControlStateNormal];
    [mPrintBtn_ setTitle:@"Print" forState:UIControlStateNormal];

}

- (void)loadURL {
//    // NSURL *targetURL = [NSURL URLWithString:@"http://www.asrpro.com/ASR2/PDFs/Booklet/Booklet.aspx?q=cllIJZy44AUYe%40NThi%402%2f6dxTLOdtcRHDJT7qS6c%2fvu%405SeQ3FZSU1indDwF%2fBfZdi91w9py7%2fqxKDs4IVPGZGNaxxdo10FFqzEBizCMmXJQngZwVzO2fg%3d%3d"];
//    // NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
//    //[mShowPdfView_ loadRequest:request];
//  //  if([[DataBaseUtilsClass instance] loadDataFromFile:CUSTOMERPLAN :CUSTOMERPLANPDF]==nil)
//  //  {
//    NSData *pdfData = [[NSData alloc]
//                       initWithContentsOfURL:[NSURL URLWithString:mWebURl]];
//   // [[FileUtils fileUtils]saveDataInToFile:pdfData :kCUSTOMERPLAN :kCUSTOMERPLANPDF];
//    [self.mShowPdfView_ loadData:pdfData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
//    [[SharedUtilities sharedUtilities] removeLoadView];
//    
////    } else {
////        [self loadDataToWebView];
////    }
}


- (void) tryPrintPdf
{
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    
    if ( pic && [UIPrintInteractionController canPrintData: mWebData] ) {
        pic.delegate = self;
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        printInfo.outputType = UIPrintInfoOutputGeneral;
        printInfo.jobName = @".pdf";
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        pic.printInfo = printInfo;
        pic.showsPageRange = YES;
        pic.printingItem = mWebData;

        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
            if (!completed && error) {
                DLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
            }
        };
        [pic presentFromRect:mPrintBtn_.frame inView:mPrintBtn_.superview animated:YES completionHandler:completionHandler];
    }
}

-(void)loadDataToWebView {
    //    NSURL *targetURL = [NSURL URLWithString:mWebURl];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    //    [self.mShowPdfView_ loadRequest:request];
    mWebData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:mWebURl]];
    
    [self.mShowPdfView_  loadData:mWebData MIMEType:@"application/pdf" textEncodingName:@"utf-8" baseURL:nil];
    
    
}

#pragma Mark - ********************* Button Actions *********************
#pragma mark 

- (IBAction)PrintBtnAction:(id)sender {
    [self tryPrintPdf];
}

- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Mark - ****************** UIwebview delegates ******************
#pragma mark
- (void)webViewDidStartLoad:(UIWebView *)webView {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.mActivityIdicator_ stopAnimating];
   
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma Mark - ******************** Request Methods ********************
#pragma mark -



@end
