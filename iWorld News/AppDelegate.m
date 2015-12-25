//
//  AppDelegate.m
//  iWorld News
//
//  Created by Nitin gohel on 10/14/15.
//  Copyright (c) 2015 Nitin gohel. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MFSideMenuContainerViewController.h"
#define ROOTVIEW [[[UIApplication sharedApplication] keyWindow] rootViewController]
static AppDelegate *delegate;

@interface AppDelegate ()
{
    MainViewController *mainViewController;
    BOOL shouldHideStatusBar;
}

@end
@implementation AppDelegate
@synthesize firstRun = _firstRun;

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"Side1ViewController"];
   
    
    [container setLeftMenuViewController:leftSideMenuViewController];
    [container setCenterViewController:navigationController];

    // Override point for customization after application launch.
    return YES;
}

#pragma mark -->GAD Intistitial<--
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    // [[UIApplication sharedApplication] setStatusBarHidden:TRUE withAnimation:NO];
    
    
    
    //   [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    [interstitial presentFromRootViewController:self.window.rootViewController];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    
    // [interstitial presentFromRootViewController:self];
    
    
}
+(AppDelegate*)sharedinstance
{
    if (delegate==nil) {
        delegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
        return delegate;
    }
    return delegate;
}


- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3225124349268589/2305911754"];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}

-(void)interstitialWillPresentScreen:(GADInterstitial *)ad{
    // [[UIApplication sharedApplication] setStatusBarHidden:TRUE withAnimation:NO];
    NSLog(@"on screen");
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    
    //[viewAdd removeFromSuperview];
    // [self.view removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/2934735716"];
    GADRequest *request = [GADRequest request];
    // Requests test ads on test devices.
    request.testDevices = @[@""];
    [self.interstitial loadRequest:request];
    self.interstitial = [self createAndLoadInterstitial];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//    dispatch_async(queue, ^{
//        [mainViewController selfmethod];
//    });

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "www.olbuz.iWorld_News" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iWorld_News" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    
   //  Create the coordinator and store
    
    
    
        NSString* from;
        NSString* to;
        NSArray* mainPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [mainPath objectAtIndex:0]; // Get documents folder
        /*VoiceRecords.plist file*/
        from=[[NSBundle mainBundle]pathForResource:@"iWorld_News" ofType:@"sqlite"];
        to=[documentsDirectory stringByAppendingPathComponent:@"iWorld_News.sqlite"];
        [[NSFileManager defaultManager]copyItemAtPath:from
                                               toPath:to error:nil];
        from=nil;
        to=nil;
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iWorld_News.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        
        
        
      
    }
    
    return _persistentStoreCoordinator;
}






- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
- (void)saveContext1 {
     NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
