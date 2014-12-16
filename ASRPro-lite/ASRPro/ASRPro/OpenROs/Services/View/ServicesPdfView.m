//
//  ServicesPdfView.m
//  ASRPro
//
//  Created by Ramesh on 4/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ServicesPdfView.h"

@interface ServicesPdfView()
-(void)setFontsandText;
-(void) PostRequestForCustomerPDF: (NSObject *) myObject;
-(void)loadDataToWebView;
@end

@implementation ServicesPdfView
@synthesize mHeaderLabel_;
@synthesize mShowPdfView_;
@synthesize mActivityIdicator_;
@synthesize mCancelBtn_;
@synthesize mWebURl;
@synthesize mTitle;
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
    [self setFontsandText];
    [self loadDataToWebView];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.view.superview.bounds = CGRectMake(0, 0, 600,600);
}

-(void)viewDidAppear:(BOOL)animated {
    //self.view.layer.cornerRadius = 0;
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

-(void)loadDataToWebView {
    NSURL *targetURL = [NSURL URLWithString:mWebURl];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    [self.mShowPdfView_ loadRequest:request];
        
}

#pragma Mark - ********************* Button Actions *********************
#pragma mark 

- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Mark - ****************** UIwebview delegates ******************
#pragma mark 
- (void)webViewDidStartLoad:(UIWebView *)webView {
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.mActivityIdicator_ startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.mActivityIdicator_ stopAnimating];
	//[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma Mark - ******************** Request Methods ********************
#pragma mark -



@end
