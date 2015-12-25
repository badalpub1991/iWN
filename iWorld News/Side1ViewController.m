//
//  Side1ViewController.m
//  iWorld News
//
//  Created by Nitin gohel on 10/16/15.
//  Copyright (c) 2015 Nitin gohel. All rights reserved.
//

#import "Side1ViewController.h"
#import "MFSideMenu.h"
#import "MainViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "kConstant.h"


@interface Side1ViewController ()

@end

@implementation Side1ViewController
@synthesize tableview;

- (void)handleNotification:(NSNotification*)note {
    
  
   
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Sidetablename"];
    self.sidename = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
      

    [tableview reloadData];
      self.tableview.editing=false;
    
  
    
}

- (void)handleNotification1:(NSNotification*)note1 {
    
    
    
    
   
    self.tableview.editing=false;
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated
{
   
   // [self.tableview setEditing:!self.tableview.editing animated:YES];
    
    [super viewDidDisappear:YES];
}
- (void)viewDidLoad {
    
    
    //------Reload tableview from another viewcontroller---------//
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"MyNotification" object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification1:) name:@"MyNotification1" object:nil];
    
    
    
    
    //--------Navigationbar setting------------------------//
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navbar.barTintColor=[UIColor colorWithRed:98.0f/255.0f green:42.0f/255.0f blue:101.0f/255.0f alpha:1];
    // navbar.backgroundColor=[UIColor redColor];
    
    UIImage *img = [UIImage imageNamed:@"logo_iwn.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 20, 80, 40)];
    [imgView setImage:img];
    // setContent mode aspect fit
    [imgView setContentMode:UIViewContentModeScaleAspectFit];
    self.navigationItem.titleView = imgView;
    navbar.translucent=FALSE;
    
    [navbar addSubview:imgView];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(moveButton)
     forControlEvents:UIControlEventTouchUpInside];
    
           [button setTitle:@"Delete" forState:UIControlStateNormal];

    
    button.frame = CGRectMake(0, 20.0, 80, 40.0);
    [navbar addSubview:button];
    [self.view bringSubviewToFront:navbar];
    [self.view bringSubviewToFront:button];
    
    
    [self.view addSubview:navbar];
    
    
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    
    self.tableview.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"Default-736h@3x.png"]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default-736h@3x.png"]];
    [self.menuContainerViewController setMenuSlideAnimationEnabled:YES];
    [self.menuContainerViewController setMenuSlideAnimationFactor:10.0f];
    
    
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"slide_menu_img.png"]];
    channel=[[NSArray alloc]initWithObjects:@"ALL",@"CNN",@"ABC News",@"BBC UK",@"USA Today",@"NY Times",@"AP",@"MSNBC",@"CBS",@"Yahoo",@"Google", nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}




- (IBAction)moveButton
{
    if ([button.titleLabel.text isEqualToString:@"Cancel"]) {
        [button setTitle:@"Delete" forState:UIControlStateNormal];
        
    }
    else if ([button.titleLabel.text isEqualToString:@"Delete"])
    {
        [button setTitle:@"Cancel" forState:UIControlStateNormal];
    }

    
   // [button setTitle:@"Cancel" forState:UIControlStateNormal];

    // SideMenuViewController *side=[[SideMenuViewController alloc]init];
    [self.tableview setEditing:!self.tableview.editing animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Sidetablename"];
    self.sidename = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableview reloadData];
}
#pragma mark -->Core Data Methods<--
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)fetchFromDatabase
{
     AppDelegate *appdelegate=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Sidetablename" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSError *error;
    self.sidename = [[context executeFetchRequest:request error:&error]mutableCopy];
    NSLog(@"fetched data = %@",[self.sidename lastObject]); //this shows the data
    [self.tableview reloadData];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    
}

-(void)reloadtableview
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Sidetablename"];
    self.sidename = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableview reloadData];
}
#pragma mark -
#pragma mark - UITableViewDataSource

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] init];
    
    
    
   
    headerView.backgroundColor =[UIColor clearColor];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   // NSManagedObject *fetchsidename = [self.sidename objectAtIndex:indexPath.row];

    return [self.sidename count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    //tableView.separatorColor=[UIColor whiteColor];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
       
        
    }
    
    
    NSManagedObject *fetchsidename = [self.sidename objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [fetchsidename valueForKey:@"name"]]];
    [cell.detailTextLabel setText:[fetchsidename valueForKey:@"websitename"]];
    
    // cell.textLabel.text = [self.sidename objectAtIndex:indexPath.row];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    
    
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:180/255.0
                                                      green:138/255.0
                                                       blue:171/255.0
                                                      alpha:0.5];
    cell.selectedBackgroundView =  customColorView;
    
    
//    //------Create custom seperator--------//
//    UIView *separatorLineView;
//    if (isiPhone4s || isiPhone5 || isiPhone6 || isiPhone6plus) {
//        separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 42, 320, 1)];/// change size as you need.
//        
//    }
//    else if (isiPad2 || isiPadAir || isiPadRatina)
//    {
//        separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 90, 768, 1)];/// change size as you need.
//        
//        
//    }
//    
//    separatorLineView.backgroundColor = [UIColor whiteColor];// you can also put image here
//    [cell.contentView addSubview:separatorLineView];
    
    return cell;
}







#pragma mark -
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    
    MainViewController *mainViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    mainViewController.index = indexPath.row;
    // HUD.delegate = self;
    // HUD.labelText = @"Processing";
    // [HUD show:YES];
    
    
    mainViewController.title = [NSString stringWithFormat:@"Demo #%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    
    NSManagedObject *fetchsidename = [self.sidename objectAtIndex:indexPath.row];
    
    
    NSString *stringurl= [NSString stringWithFormat:@"%@", [fetchsidename valueForKey:@"feedurl"]];
    
    NSLog(@"String url is----> %@", stringurl);
    _url1=[NSURL URLWithString:stringurl];
   

    NSLog(@"url is----> %@", _url1);
    mainViewController.url2=_url1;
   
    
    NSUserDefaults *StoreScore;
    
    StoreScore = [NSUserDefaults standardUserDefaults];
    [StoreScore setURL:_url1 forKey:@"lasturl"];
    [StoreScore synchronize];
    NSLog(@"High Score: %@ ", _url1);

    
    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    NSArray *controllers = [NSArray arrayWithObject:mainViewController];
    navigationController.viewControllers = controllers;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

#pragma mark -->delete cell<--
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
        return YES;
}



- (void)deleteRow1
{
    //self.tableView.setEditing(true, animated: true)
    // [self.tableView setEditing:true animated:true];
    [self.tableview setEditing:!self.tableview.editing animated:YES];
    
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Default News Channel"
                                                        message:@"You can't Delete default News Channel"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
         self.tableview.editing=false;
        [button.titleLabel setText:@"Delete"];
       // NSLog(@"##ERROR:parsedItems Count:%ld",(long)sectionheaders.count);
    }
    else
    {
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.sidename objectAtIndex:indexPath.row]];
         [self.sidename removeObjectAtIndex:indexPath.row];

        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
       [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
        // Remove device from table view
        [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    }
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
