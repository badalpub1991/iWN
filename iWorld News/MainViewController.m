//
//  MainViewController.m
//  News-Application
//
//  Created by Badal-PUB on 8/21/15.
//  Copyright (c) 2015 Badal-PUB. All rights reserved.
//

#import "MainViewController.h"
#import "MFSideMenu.h"
#import "Parser.h"
#import "MainViewTableViewCell.h"
#import "NSString+HTML.h"
#import "MWFeedParser.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "Side1ViewController.h"
#define IS_NOT_NIL_OR_NULL(x) (x && x != (id)[NSNull null])
@interface MainViewController ()
{
    Side1ViewController *side;
    BOOL AllUrlLoad;
    long long expectedLength;
    long long currentLength;
    MWFeedInfo* chanelInfo;
    NSMutableArray* newslist;
    Reachability *internetReachableFoo;

    }

@end

@implementation MainViewController
@synthesize itemsToDisplay,HUD;
@synthesize progress,check,traitCollection,itemarray,cell,firstImg,itemTitle,trial;
//@synthesize HUD;

@synthesize index;

- (void)viewDidLoad {
    
    
    
      //----------------------------
//     _lock = [[lockstore alloc] init];
//    _lock.arr = [[NSMutableArray alloc] init];
//        _lock = [[lockstore alloc] init];
//    _lock.arr = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    //---------------------

    
    //----------------check Document FolderPath----------------------//
      NSLog(@"%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
    
    //----------------ADMOB Banner----------------------//
 
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    self.AbMob.adUnitID = @"ca-app-pub-3225124349268589/9829178550";
    self.AbMob.rootViewController = self;
   // [GADRequest request].testDevices = @[@"" ];  // Eric's iPod Touch
                                        
    
    [self.AbMob loadRequest:[GADRequest request]];
    
    
    //----------------Refresh Button Declaration----------------------//

//    UIButton *button1 = [[UIButton alloc] init];
//    button1.frame=CGRectMake(0,0,25,20);
//    [button1 setBackgroundImage:[UIImage imageNamed: @"refrsh.png"] forState:UIControlStateNormal];
//    [button1 addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
 //   [button1 release];
    
    [super viewDidLoad];
    trial=[[NSArray alloc]init];
    
  
    //[self.menuContainerViewController setMenuSlideAnimationEnabled:YES];
   // [self.menuContainerViewController setMenuSlideAnimationFactor:3.0f];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-736h@3x.png"]];
    self.tableview.backgroundColor=[UIColor clearColor];
    
   // [self.navigationController pushViewController: animated:YES];
  //  [AppDelegate showGlobalProgressHUDWithTitle:@"Processing"];

self.tableview.separatorColor = [UIColor clearColor];

    
    self.title = @"Loading...";
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    parsedItems = [[NSMutableArray alloc] init];
    self.itemsToDisplay = [NSArray array];
    
    
    itemarray=[[NSArray alloc]initWithObjects:
               @"http://rss.cnn.com/rss/edition_world.rss",
               @"http://feeds.abcnews.com/abcnews/topstories",
               @"http://newsrss.bbc.co.uk/rss/newsonline_world_edition/front_page/rss.xml",
               @"http://rssfeeds.usatoday.com/UsatodaycomWorld-TopStories",
               @"http://www.nytimes.com/services/xml/rss/nyt/World.xml",
               @"http://hosted.ap.org/lineups/WORLDHEADS-rss_2.0.xml?SITE=RANDOM&SECTION=HOME",
               @"http://feeds.nbcnews.com/feeds/topstories",
               @"http://www.cbsnews.com/feeds/rss/world.rss",
               @"http://rss.news.yahoo.com/rss/world",
               @"http://news.google.com/news?pz=1&ned=us&hl=en&topic=w&output=rss",
              
               nil];
       // Do any additional setup after loading the view.
    
    [self CallForWebService:_url2];
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

#pragma mark -->Core Data Method<--
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

#pragma mark -->Present Popup<--
-(void)presentpopup1
{
    urlnill=NO;
    
    Popup *popup = [[Popup alloc] initWithTitle:@"iWorld"
                                       subTitle:@"Please enter the Details"
                          textFieldPlaceholders:@[@"Name",@"Website",@"RSS Feed URL"]
                                    cancelTitle:@"Cancel"
                                   successTitle:@"Submit"
                                    cancelBlock:^{
                                        [HUD hide:YES];
                                      //  [feedParser.HUD show:NO];
                                      
                                    } successBlock:^{
                                        NSURL *url = [NSURL URLWithString:_Feedlink];
                                        
                                        NSUserDefaults *StoreScore;
                                        
                                        StoreScore = [NSUserDefaults standardUserDefaults];
                                        [StoreScore setURL:url forKey:@"lasturl"];
                                        [StoreScore synchronize];
                                        NSLog(@"High Score: %@ ", url);
                                        
                                        
                                        
                                        
//                                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                                        hud.labelText = @"Processing...";
                                        [self CallForWebService:url];

                                      
                                    }
                    ];
    [popup setDelegate:self];
   
    
//    int titleHeights = popup.titleLabel.frame.size.height + popup.subTitleLabel.frame.size.height;
//    int textFieldHeight = 28;
//    autoCompleteTextField = [[NHAutoCompleteTextField alloc]
//                             initWithFrame:CGRectMake(8, titleHeights+24+28, popup.frame.size.width-16, textFieldHeight+28+28)];
//    [autoCompleteTextField setDropDownDirection:NHDropDownDirectionDown];
//    [autoCompleteTextField setDataSourceDelegate:self];
//    [autoCompleteTextField setDataFilterDelegate:self];
//    autoCompleteTextField.backgroundColor=[UIColor greenColor];
//    [popup.popupView addSubview:autoCompleteTextField];
//    [popup bringSubviewToFront:autoCompleteTextField];

    //[popup setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-736h@3x.png"]]];
    
    [popup setBackgroundColor:[UIColor whiteColor]];
    [popup setBorderColor:[UIColor colorWithRed:98.0f/255.0f green:42.0f/255.0f blue:101.0f/255.0f alpha:1]];
    [popup setTitleColor:[UIColor colorWithRed:98.0f/255.0f green:42.0f/255.0f blue:101.0f/255.0f alpha:1]];
    [popup setSubTitleColor:[UIColor colorWithRed:98.0f/255.0f green:42.0f/255.0f blue:101.0f/255.0f alpha:1]];    [popup setCancelBtnColor:[UIColor colorWithRed:98.0f/255.0f green:42.0f/255.0f blue:101.0f/255.0f alpha:1]];
    [popup setSuccessBtnColor:[UIColor colorWithRed:98.0f/255.0f green:42.0f/255.0f blue:101.0f/255.0f alpha:1]];
    [popup setRoundedCorners:YES];
    [popup setIncomingTransition:PopupIncomingTransitionTypeGhostAppear];
    [popup setOutgoingTransition:PopupOutgoingTransitionTypeGhostDisappear];
   // [popup setSwipeToDismiss:YES];
    [popup setBackgroundBlurType:PopupBackGroundBlurTypeLight];
    [popup showPopup];
}





- (void)dictionary:(NSMutableDictionary *)dictionary forpopup:(Popup *)popup stringsFromTextFields:(NSArray *)stringArray {
    
   // SideMenuViewController *sidemenuviewcontroller=[[SideMenuViewController alloc]init];
    
    _Name = [stringArray objectAtIndex:0];
  //  sidemenuviewcontroller.PassName=_Name;
   
    
   // NSLog(@"Name ---> %@",sidemenuviewcontroller.PassName);
_WebsiteName = [stringArray objectAtIndex:1];
  //  sidemenuviewcontroller.PassWebsiteName=_WebsiteName;
    
  //  NSLog(@"Websitename ---> %@",sidemenuviewcontroller.PassWebsiteName);
  
    _Feedlink = [stringArray objectAtIndex:2];
    
    // _URL1=[NSURL URLWithString:_Feedlink];
    NSLog(@"Feedlink ---> %@",_Feedlink);
    
    
    
    
}

-(void)refresh
{
    
}
#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
     //Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
   // [HUD release];
    HUD = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  //  [self testInternetConnection];
    [self.view bringSubviewToFront:self.AbMob];
    }
-(void)viewDidAppear:(BOOL)animated
{
    //[MBProgressHUD displayGlobalHUD];

}
- (IBAction)btnAdd:(id)sender {
    [self presentpopup1];

}

- (void)selfmethod
{
   // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   // hud.labelText = @"Processing...";

    chanelInfo = [MWFeedInfo new];
    NSLog(@"the index is %ld",(long)index);
    sectionheaders = [NSMutableArray new];
    if (index == 0) {
        // NSURL *url = [NSURL URLWithString:@"http://rss.news.yahoo.com/rss/world"];
        AllUrlLoad=YES;
        for(NSString* strurl in itemarray){
            NSString* url = strurl;
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"\n%@",url);
            [self CallForWebService:[NSURL URLWithString:url]];
            
        }
        
        //  [self CallForWebService:url];
        
        // [self.tableview reloadData];
        return;
    }
    else  if (index == 1) {
        NSURL *url = [NSURL URLWithString:@"http://rss.cnn.com/rss/edition_world.rss"];
        
        [self CallForWebService:url];
        // [self.tableview reloadData];
        return;
    }
    else   if (index ==2) {
        NSURL *url = [NSURL URLWithString:@"http://feeds.abcnews.com/abcnews/topstories"];
        
        [self CallForWebService:url];
        // [self.tableview reloadData];
        return;
    }
    else  if (index ==3) {
        NSURL *url = [NSURL URLWithString:@"http://newsrss.bbc.co.uk/rss/newsonline_world_edition/front_page/rss.xml"];
        
        [self CallForWebService:url];
        //  [self.tableview reloadData];
        return;
    }
    else  if (index ==4) {
        NSURL *url = [NSURL URLWithString:@"http://rssfeeds.usatoday.com/UsatodaycomWorld-TopStories"];
        
        [self CallForWebService:url];
        // [self.tableview reloadData];
        return;
    }
    else  if (index ==5) {
        NSURL *url = [NSURL URLWithString:@"http://www.nytimes.com/services/xml/rss/nyt/World.xml"];
        
        [self CallForWebService:url];
        //  [self.tableview reloadData];
        return;
    }
    else   if (index ==6) {
        NSURL *url = [NSURL URLWithString:@"http://hosted.ap.org/lineups/WORLDHEADS-rss_2.0.xml?SITE=RANDOM&SECTION=HOME"];
        
        [self CallForWebService:url];
        //  [self.tableview reloadData];
        return;
    }
    else  if (index ==7) {
        NSURL *url = [NSURL URLWithString:@"http://feeds.nbcnews.com/feeds/topstories"];
        
        [self CallForWebService:url];
        //   [self.tableview reloadData];
        return;
    }
    else  if (index ==8) {
        NSURL *url = [NSURL URLWithString:@"http://www.cbsnews.com/feeds/rss/world.rss"];
        
        [self CallForWebService:url];
        //  [self.tableview reloadData];
        return;
    }
    else   if (index ==9) {
        NSURL *url = [NSURL URLWithString:@"http://rss.news.yahoo.com/rss/world"];
        
        [self CallForWebService:url];
        //   [self.tableview reloadData];
        return;
    }
    else    if (index ==10) {
        NSURL *url = [NSURL URLWithString:@"http://news.google.com/news?pz=1&ned=us&hl=en&topic=w&output=rss"];
        
        [self CallForWebService:url];
        // [self.tableview reloadData];
        return;
    }
    else   if (index ==11) {
        NSURL *url = [NSURL URLWithString:@"http://news.google.com/news?pz=1&ned=us&hl=en&topic=w&output=rss"];
        
        [self CallForWebService:url];
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Processing...";
    
}

-(void)CallForWebService:(NSURL *)url
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Processing...";
    
      //  [feedParser.HUD show:YES];
    
   
    
//    NSURL *url = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults]
//                                       objectForKey:@"url"]];
    
    
    
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if ([userDefaults objectForKey:@"lasturl"] != nil || url !=nil)
        {
           // refernews=nil;
            url = [[NSUserDefaults standardUserDefaults] URLForKey:@"lasturl"];
            
//            url = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults]
//                                        URLForKey:@"lasturl"]];
            feedParser = [[MWFeedParser alloc] initWithFeedURL:url];
            
        }
    else
    {
        
        url= [NSURL URLWithString:@"http://www.refernews.com/feed"];
        feedParser = [[MWFeedParser alloc] initWithFeedURL:url];
        
        
        NSUserDefaults *StoreScore;
        
        StoreScore = [NSUserDefaults standardUserDefaults];
        [StoreScore setURL:url forKey:@"lasturl"];
        [StoreScore synchronize];
        NSLog(@"High Score: %@ ", url);
        
        self.Name = @"Refer News";
        self.WebsiteName=@"www.refernews.com";
        self.Feedlink=[url absoluteString];
        
       

        
    }

    
//    if (url==nil) {
//        urlnill=YES;
//        url= [NSURL URLWithString:@"http://www.refernews.com/feed"];
//        feedParser = [[MWFeedParser alloc] initWithFeedURL:url];
//        self.Name = @"Refer News";
//        self.WebsiteName=@"www.refernews.com";
//        self.Feedlink=[url absoluteString];
//        //refernews =[url absoluteString];
//        
//
//    }
//    else
//    {
//        refernews=nil;
//        
//        //    NSURL *url = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults]
//        //                                       objectForKey:@"url"]];
//        
//        
//        feedParser = [[MWFeedParser alloc] initWithFeedURL:url];
//
//    }

    feedParser.delegate = self;
      feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
    feedParser.connectionType = ConnectionTypeAsynchronously;
    [feedParser parse];
    
   // [feedParser.HUD show:YES];
    check = [url absoluteString];
    
    
   }

- (void)updateTableWithParsedItems {
    self.tableview.userInteractionEnabled = YES;
    self.tableview.alpha = 1;
    NSLog(@"You are in reload tableview");

    [self.tableview reloadData];
   [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
    NSLog(@"Started Parsing: %@", parser.url);
    [parsedItems removeAllObjects];
    parsedItems = [NSMutableArray new];
    chanelInfo = [MWFeedInfo new];
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
 
    NSLog(@"Parsed Feed Info: “%@”", info.title);
//    if (index == 0) {
//        self.title= @"iWorld News";
//        
//                chanelInfo = info;
//
//    }
//        else
//        {
    self.title = info.title;
//    }
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
 
    //NSLog(@"Parsed Feed Item: “%@”", item.title);
    
    if (item) [parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
 
    
    
      [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (parsedItems.count==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                        message:@"Please enter proper RSS Feed url"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        NSLog(@"##ERROR:parsedItems Count:%ld",(long)sectionheaders.count);
        self.title = @"Failed";
        AllUrlLoad=NO;

    }
    else
    {

    //**Coredata inserting value**//
    
    
 
    
    
    
            NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"IWorld"];
            NSFetchRequest *fetchrequestforside=[NSFetchRequest fetchRequestWithEntityName:@"Sidetablename"];
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"feedurl = %@", self.Feedlink];
            fetchrequestforside.predicate=[NSPredicate predicateWithFormat:@"feedurl = %@", self.Feedlink];
            NSManagedObjectContext *context = [self managedObjectContext];
            
            
    
    
    
            if ([[context executeFetchRequest:fetchRequest error:NULL] count] == 0) {
                    NSError *error = nil;
                
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"feedurl contains %@",check];
                [fetchRequest setPredicate:predicate];
                  NSMutableArray *checkp = [[context executeFetchRequest:fetchRequest error:&error]mutableCopy];
             

                if (checkp.count<=0) {
                    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"IWorld" inManagedObjectContext:context];
                    [newDevice setValue:self.Name forKey:@"name"];
                    [newDevice setValue:self.WebsiteName forKey:@"websitename"];
                    [newDevice setValue:self.Feedlink forKey:@"feedurl"];
                    
                                       // Save the object to persistent store
                    if (![context save:&error]) {
                        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                    }
                        //Save value in lockbox
                    
                   
                }
                    
            }
    
                if ([[context executeFetchRequest:fetchrequestforside error:NULL] count] == 0) {
                    // Create a new managed object
                    
                    NSError *error = nil;
                    
                    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"feedurl contains %@",check ];
                    [fetchrequestforside setPredicate:predicate];
                    NSMutableArray *checkp = [[context executeFetchRequest:fetchrequestforside error:&error]mutableCopy];
                    
                    
                    if (checkp.count<=0) {
                    
                    NSManagedObject *newDevice1 = [NSEntityDescription insertNewObjectForEntityForName:@"Sidetablename" inManagedObjectContext:context];
                    
                    if (self.Name)
                    {
                        [newDevice1 setValue:self.Name forKey:@"name"];
                        
                        
                    }
                    if (self.WebsiteName)
                    {
                        [newDevice1 setValue:self.WebsiteName forKey:@"websitename"];
                        
                    }
                    
                    if (self.Feedlink)
                    {
                        [newDevice1 setValue:self.Feedlink forKey:@"feedurl"];
                        
                    }
                    NSError *error = nil;
                        // Save the object to persistent store
                        if (![context save:&error]) {
                            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                        }
                        NSArray *keys = [[[newDevice1 entity] attributesByName] allKeys];
                        NSDictionary *singledict = [newDevice1 dictionaryWithValuesForKeys:keys];
                        
                        [_lock.arr addObject:singledict];
                        
//            self.keychain = [[FXKeychain alloc]init];
//                                                    [self.keychain setObject:_lock.arr forKey:@"lock"];
//                        
//                        
//                    NSLog(@"dictionary value %@",[self.keychain objectForKey:@"lock"]);
                        
               }
                    
                    
                   

                                  }
                // Create a new managed object
//    self.Name=nil;
//    self.WebsiteName=nil;
//    self.Feedlink=nil;
    // Create a new managed object
      //**Parsing url**//
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if ([userDefaults objectForKey:@"Extreme"] != nil)
    
    
    
//    NSUserDefaults *StoreScore;
//
//    StoreScore = [NSUserDefaults standardUserDefaults];
//    [StoreScore setURL:_url2 forKey:@"lasturl"];
//    [StoreScore synchronize];
//    NSLog(@"High Score: %@ ", _url2);
    

    NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    NSArray* array =[parsedItems sortedArrayUsingDescriptors:
                     [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                          ascending:NO]]];
        NSMutableDictionary* dict = [NSMutableDictionary new];
        [dict setObject:chanelInfo forKey:@"title"];
        [dict setObject:array forKey:@"data"];
        [sectionheaders addObject:dict];
            NSLog(@"SectionHeader Count:%ld",(long)sectionheaders.count);
            [self updateTableWithParsedItems];
//        NSURL *url = [NSURL URLWithString:self.Feedlink];
//        NSUserDefaults *StoreScore;
//        
//        StoreScore = [NSUserDefaults standardUserDefaults];
//        [StoreScore setURL:url forKey:@"lasturl"];
//        [StoreScore synchronize];
//        NSLog(@"High Score: %@ ", url);
    }


}


- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"\n##Finished Parsing With Error: %@", error.localizedDescription);
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

  //  [feedParser.HUD show:NO];


    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed"
                                                            message:@"Please enter proper RSS Feed url"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            NSLog(@"##ERROR:parsedItems Count:%ld",(long)sectionheaders.count);
            //self.title = @"Failed";
            AllUrlLoad=NO;
//    }
//  else if (AllUrlLoad==NO)
//  {
//      
//      if (parsedItems.count == 0) {
//        self.title = @"Failed"; // Show failed message in title
//    } else {
//        // Failed but some items parsed, so show and inform of error
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
//                                                        message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
//                                                       delegate:nil
//                                              cancelButtonTitle:@"Dismiss"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
//  }
    //[self updateTableWithParsedItems];
}

#pragma mark -->Alertview Delegate
    - (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
        // the user clicked OK
        if (buttonIndex == 0) {
            // do something here...
            [self presentpopup1];
        }
    }

- (void)popupDidDisappear:(Popup *)popup buttonType:(PopupButtonType)buttonType
{
    
}
#pragma mark - UITableViewDataSource


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* headerView ;
    
    UILabel* headerLabel ;


    
    
//    if (AllUrlLoad==YES)
//    {
//       headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
//        headerLabel=[[UILabel alloc] init];
//        headerLabel.frame = CGRectMake(5, 2, tableView.frame.size.width - 5, 18);
//        headerLabel.backgroundColor = [UIColor clearColor];
//        headerLabel.textColor = [UIColor whiteColor];
//
//        NSDictionary* aDict =[sectionheaders objectAtIndex:section];
//        MWFeedInfo *newsFeedInfo = [sectionheaders[section] objectForKey:@"title"];
//        
//               headerLabel.text = newsFeedInfo.title;
//        headerView.backgroundColor= [UIColor colorWithRed:98.0f/255.0f green:42.0f/255.0f blue:101.0f/255.0f alpha:1];
//        
//        
//          }
//    else
   // {
        headerView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        headerLabel= Nil;

        headerLabel.text=@"";
        headerView.backgroundColor= [UIColor clearColor];
   // }
    headerLabel.textAlignment = NSTextAlignmentLeft;

        [headerView addSubview:headerLabel];

        return headerView;

     }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    NSLog(@"Height: %d",[tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0);
//    if (AllUrlLoad==YES)
//    {
//     return    25;
//    }
//    else
    
      return   0;
    
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    if (AllUrlLoad==YES) {
//        return sectionheaders.count;
//        AllUrlLoad=NO;
//    }
//    else
//    {
        return 1;
//    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return feeds.count;
    //return itemsToDisplay.count;
//    if(index == 0){
//        return [[sectionheaders[section] objectForKey:@"data"]count];
//    }else{
    NSLog(@"you are in Datasource method");
        return [parsedItems count];
//    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *separatorLineView;
    if (isiPhone4s || isiPhone5 || isiPhone6 || isiPhone6plus) {
        separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x+90, 90, 320, 1)];/// change size as you need.

    }
    else if (isiPad2 || isiPadAir || isiPadRatina)
    {
        separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x+90, 90, 768, 1)];/// change size as you need.

        
    }
   
       separatorLineView.backgroundColor = [UIColor whiteColor];// you can also put image here
    [cell.contentView addSubview:separatorLineView];
         static NSString *MainTableIdentifier = @"MainTableIdentifier";
         cell = [tableView dequeueReusableCellWithIdentifier:MainTableIdentifier];
   
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MainViewTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.backgroundColor=[UIColor clearColor];
    
    MWFeedItem *item;
   // MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
//    if(index == 0){
//        NSDictionary* aDict =[sectionheaders objectAtIndex:indexPath.section];
//        item = [[aDict objectForKey:@"data"]objectAtIndex:indexPath.row];
//    }else{
        //item = [[sectionheaders objectAtIndex:0]objectAtIndex:indexPath.row];
        item = [parsedItems objectAtIndex:indexPath.row];
//    }
    if (item) {
        
        // Process
        itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
        
      
        cell.lblTitle.text = itemTitle;
        cell.lblTitle.textColor=[UIColor whiteColor];
        NSMutableString *subtitle = [NSMutableString string];
        if (item.date) [subtitle appendFormat:@"%@ ", [formatter stringFromDate:item.date]];
        //[subtitle appendString:itemSummary];
        cell.lblDateTime.text = subtitle;
        cell.lblDateTime.textColor=[UIColor whiteColor];
        
        cell.lblDescription.text=itemSummary;
        cell.lblDescription.textColor=[UIColor whiteColor];
      
        
    }
    
    
[cell.ImgMainView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    cell.ImgMainView.layer.borderWidth = 1.0f;
    cell.ImgMainView.layer.masksToBounds = YES;
    
    UIImage *setplaceholderimage = [UIImage imageNamed:@"placeholder_iwn3.png"];
    [cell.ImgMainView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", item.image]]
                        placeholderImage:setplaceholderimage];
     
    
//    [cell.ImgMainView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", item.image]]
//                   placeholderImage:[UIImage imageNamed:@"placeholder_iwn3.png"]
//                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//                              if(item.image == nil) {
//                                  [cell.ImgMainView setImage:[UIImage imageNamed:@"placeholder_iwn3.png"]];
//                                  //];
//                              }
//                          }
//     
//     ];
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:180/255.0
                                                      green:138/255.0
                                                       blue:171/255.0
                                                      alpha:0.5];
    cell.selectedBackgroundView =  customColorView;

    
    
;
    return cell;
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
     DetailViewController *detailViewController = [storyBoard instantiateViewControllerWithIdentifier:@"DetailViewController"];
     MWFeedItem *item = [parsedItems objectAtIndex:indexPath.row];
      detailViewController.item= item;
      [self.navigationController pushViewController:detailViewController animated:YES];
        // Deselect
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
    
  }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - UIBarButtonItems

- (IBAction)showLeftMenuPressed:(id)sender {
    
    side=[[Side1ViewController alloc]init];
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
    
    //self.tableView.editing=false;
    

        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNotification" object:self];
   
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btnpopup:(id)sender {
     [self presentpopup1];
}

- (IBAction)btnRefresh:(id)sender {
   // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.labelText = @"Processing...";
    
    _url2 = [[NSUserDefaults standardUserDefaults] URLForKey:@"lasturl"];
    
    //            url = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults]
    //                                        URLForKey:@"lasturl"]];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:_url2];
    
    [self CallForWebService:_url2];

}
@end
