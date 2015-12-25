//
//  DetailViewController.m
//  News-Application
//
//  Created by Nitin gohel on 8/24/15.
//  Copyright (c) 2015 Badal-PUB. All rights reserved.
//

#import "DetailViewController.h"
#import "MainViewController.h"
#import "NSString+HTML.h"
#import "NJKWebViewProgressView.h"
#import "MBProgressHUD.h"


@interface DetailViewController ()
{
    MainViewController *mainViewController;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

@end

@implementation DetailViewController
@synthesize lblTitle,item,title,wbviewnews,itemt,summaryString,storearray,sites,dateString;

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
//    self.AbMob.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
//    self.AbMob.rootViewController = self;
//    [GADRequest request].testDevices = @[@"" ];  // Eric's iPod Touch
//    
//    
//    [self.AbMob loadRequest:[GADRequest request]];
    
    
    
    GADBannerView *gv=[[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    if (isiPhone5) {
        gv.frame = CGRectMake(0, self.view.frame.origin.y+454, self.view.frame.size.width, 50);

    }
    else if (isiPhone6)
    {
        gv.frame = CGRectMake(0, self.view.frame.origin.y+553, self.view.frame.size.width, 50);

    }
    else if (isiPhone6plus)
    {
        gv.frame = CGRectMake(0, self.view.frame.origin.y+622, self.view.frame.size.width, 50);
 
    }
    else if (isiPhone4s)
    {
        gv.frame = CGRectMake(0, self.view.frame.origin.y+366, self.view.frame.size.width, 50);
    }
    [self.view addSubview:gv];
    
    gv.adUnitID = @"ca-app-pub-3225124349268589/9829178550";
    gv.rootViewController = self;
    gv.delegate=(id<GADBannerViewDelegate>)self;
    GADRequest *request = [GADRequest request];
    gv.backgroundColor=[UIColor blackColor];
    // Enable test ads on simulators.
  //  request.testDevices = @[ GAD_SIMULATOR_ID ];
    [gv loadRequest:request];
    
  
    
    
   
    
    lblTitle.text=item.title;
    
    [self Webviewcalled];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                   target:self
                                   action:@selector(refresh)];
    self.navigationItem.rightBarButtonItem = shareButton;
    
}

- (void)testInternetConnection
{
    internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Yayyy, we have the interwebs!");
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Internet connection failed" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            
            
            
            NSLog(@"Someone broke the internet :(");
        });
    };
    
    [internetReachableFoo startNotifier];
}


-(void)Webviewcalled
{
        //hud.color=[UIColor colorWithRed:98.0f/255.0f green:42.0f/255.0f blue:101.0f/255.0f alpha:1.0];
    [self.wbviewnews setBackgroundColor:[UIColor clearColor]];
    self.wbviewnews.delegate=self;
    [self.wbviewnews setOpaque:NO];
    self.navigationItem.title = item.title;
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    wbviewnews.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    
    
    
    lblTitle.text=item.title;
    NSURL *url = [NSURL URLWithString:item.link];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSLog(@"url is: %@" , url);
    [self.wbviewnews loadRequest:urlRequest];
    self.wbviewnews.scalesPageToFit = YES;
    self.wbviewnews.contentMode = UIViewContentModeScaleAspectFit;
}



-(void)refresh
{
    
    UIActivityViewController *activityController  = [[UIActivityViewController alloc] initWithActivityItems:@[item.title,      @"For More Information Click on below Link:",item.link]  applicationActivities:Nil];
    [self presentViewController:activityController animated:YES completion:^{              ;
    
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self testInternetConnection];
    [self.view bringSubviewToFront:self.AbMob];

    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
       [_progressView removeFromSuperview];
}
- (IBAction)reloadButtonPushed:(id)sender
{
    [wbviewnews reload];
}


#pragma Mark - WEbview Delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Webview load finished");

}
 -(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Webview load failed with error");

}
 -(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"Webview started Loading");

}



#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    //self.navigationItem.title = [wbviewnews stringByEvaluatingJavaScriptFromString:item.title];
   //  self.title = [wbviewnews stringByEvaluatingJavaScriptFromString:@"document.title"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
