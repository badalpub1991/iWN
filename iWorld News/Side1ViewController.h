//
//  Side1ViewController.h
//  iWorld News
//
//  Created by Nitin gohel on 10/16/15.
//  Copyright (c) 2015 Nitin gohel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+GlobalHUD.h"
#import <CoreData/CoreData.h>

@interface Side1ViewController : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>{
    NSArray *channel;
    MBProgressHUD *HUD;
    UIButton *button;
}
@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic,strong) NSMutableArray *sidename;

@property (nonatomic,strong) NSURL *url1;
-(void)reloadtableview;
- (void)deleteRow1;

- (IBAction)moveButton;
-(void)fetchFromDatabase;


@end
