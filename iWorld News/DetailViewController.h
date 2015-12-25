//
//  DetailViewController.h
//  News-Application
//
//  Created by Nitin gohel on 8/24/15.
//  Copyright (c) 2015 Badal-PUB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedInfo.h"
#import "MWFeedParser.h"
#import "MWFeedItem.h"
#import "NJKWebViewProgress.h"
#import "kConstant.h"
#import "Reachability.h"
#import "MBProgressHUD.h"


@import GoogleMobileAds;


@interface DetailViewController : UIViewController<NJKWebViewProgressDelegate,UIWebViewDelegate,MBProgressHUDDelegate,GADInterstitialDelegate>
{
    MWFeedItem *item;
    NSString *dateString, *summaryString;
    NSArray *storearray;
    NSString *titlestring;
    UILabel *lblTitle;
    UIWebView *wbviewnews;
    NSString  *sites;

    NSString *itemt;
    
    MBProgressHUD *HUD;

    Reachability *internetReachableFoo;

    
}

@property (nonatomic,strong) IBOutlet GADBannerView *AbMob;


@property (strong, nonatomic) IBOutlet NSString *itemt;

@property (retain) NSString  *sites;


@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@property (nonatomic, strong) MWFeedItem *item;
@property (nonatomic, strong) NSString *dateString, *summaryString;

@property (strong, nonatomic) IBOutlet UIWebView *wbviewnews;
@property (strong, nonatomic) IBOutlet NSArray *storearray;
@end
