//
//  MainViewController.h
//  News-Application
//
//  Created by Badal-PUB on 8/21/15.
//  Copyright (c) 2015 Badal-PUB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "MWFeedParser.h"
#import "MainViewTableViewCell.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+GlobalHUD.h"
#import <unistd.h>
#import "Popup.h"
#import "lockstore.h"

@import GoogleMobileAds;

@interface MainViewController : UIViewController<MWFeedParserDelegate,UITableViewDataSource,UITableViewDataSource,NSXMLParserDelegate,MBProgressHUDDelegate,PopupDelegate,UIAlertViewDelegate,UITextFieldDelegate>
{
    NSArray *inUseDataSource;

    
    
    BOOL urlnill;
    UIButton *btnManual;
    UIButton *btnSearch;
    
    GADInterstitial *interstitial_;

    // Parsing
    MWFeedParser *feedParser;
    NSMutableArray *parsedItems;
    NSMutableArray *sectionheaders;

    IBOutlet UIBarButtonItem *btnAdd;
    IBOutlet UIButton *btnpopup;
    
    // Displaying
    NSArray *itemsToDisplay;
    NSDateFormatter *formatter;
    NSString *itemTitle;
    MainViewTableViewCell *cell;
    NSMutableArray *test;
    NSArray *itemarray;
    
    NSArray *trial;
    
    NSString *sectionTitle;
    MBProgressHUD *HUD;

    float progress ;
    
    UIImage *image;

    IBOutlet UIButton *btnRefresh;
    NSData* firstImg;
    NSString *check;
    BOOL sectionindex;
    NSString *refernews;
}
- (IBAction)btnpopup:(id)sender;
- (IBAction)btnRefresh:(id)sender;
@property (retain , nonatomic) lockstore *lock;
@property (nonatomic,strong) IBOutlet GADBannerView *AbMob;
@property (nonatomic , strong) NSURL *url2;

- (IBAction)btnAdd:(id)sender;

- (void)selfmethod;

@property (nonatomic)    float progress ;

@property (nonatomic, strong)     MBProgressHUD *HUD;

-(void)CallForWebService:(NSURL *)url;
@property (nonatomic, strong) NSString *itemTitle;

@property (nonatomic, strong)  NSArray *itemarray;

@property (nonatomic, strong)  NSArray *trial;;


@property (nonatomic, strong)  NSString *check;




@property (nonatomic, strong) MainViewTableViewCell *cell;;


@property (nonatomic, retain) NSData* firstImg;

// Properties
@property (nonatomic, strong) NSArray *itemsToDisplay;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic) NSInteger index;
-(void)viewWillAppear:(BOOL)animated;


//--------------------------------------------//
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *WebsiteName;
@property (nonatomic, strong) NSString *Feedlink;
-(void)presentpopup1;

//--------------------------------------------//




@end
