//
//  AppDelegate.h
//  iWorld News
//
//  Created by Nitin gohel on 10/14/15.
//  Copyright (c) 2015 Nitin gohel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MBProgressHUD.h"
#import "MWFeedParser.h"
#import <Foundation/Foundation.h>
#import "lockstore.h"

@import GoogleMobileAds;

@interface AppDelegate : UIResponder <UIApplicationDelegate,GADInterstitialDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain , nonatomic) lockstore *lock;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property(nonatomic) BOOL firstRun;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@property(nonatomic, strong) GADInterstitial *interstitial;
+(AppDelegate*)sharedinstance;

@end

