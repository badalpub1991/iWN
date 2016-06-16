# iWN
http://s000.tinyupload.com/index.php?file_id=09244370693754424466

# AppDelegate SharedInstant

==>    *//In .h file* 
```
+ (AppDelegate *)mainDeleagte;
```

==>    *//In .m file* 
``` 
+ (AppDelegate *)mainDeleagte{
    return [UIApplication sharedApplication].delegate;
}
```




# Customcell for UICollectionView

//In viewdidload

    [self.aCollectionView registerClass:[ProductViewCell class] forCellWithReuseIdentifier:@"ProductViewCell"];
    [self.aCollectionView registerNib:[UINib nibWithNibName:@"ProductViewCell" bundle:nil]//RegisterCell forCellWithReuseIdentifier:@"ProductViewCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];//Custom Flowlayout
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    float ratio = self.aCollectionView.frame.size.width/3;
    [flowLayout setItemSize:CGSizeMake(ratio, ratio)];
    [flowLayout setMinimumInteritemSpacing:0];
    [flowLayout setMinimumLineSpacing:0];
    
    #pragma mark - UICollectionView Datasource
     // 1
     - (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
       return 12;
       }
     // 2
    - (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
      }
    // 3
    - (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     ProductViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"ProductViewCell" forIndexPath:indexPath];
     if (cell == nil) {
        NSArray *xib = [[NSBundle mainBundle] loadNibNamed:@"ProductViewCell" owner:self options:nil];
        cell = [xib objectAtIndex:0];
     }
    
    cell.key.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item+1];    
    return cell;
    }
    
     #pragma mark – UICollectionViewDelegateFlowLayout

     // 1
    - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float width = collectionView.frame.size.width/3;//120
    float height = collectionView.frame.size.height/4;//120
    return CGSizeMake(width-17,height-14);
    }

    // 3
    - (UIEdgeInsets)collectionView:
    (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(14.0, 14.0, 0.0, 14.0);
    }    

# CustomCell for UITableview:-

1) First import three file . (Custom cell name .h and .m and then .xib)

2) Give IDENTIFIER to customcell.

3) Connect UIControls to custom cell's .h and .m file

4) Import customcell file in mainview controller.

5) Go to main view controller and register cell into viewdidload or regiser cell from xib in Datasource method. 

6)    //Create custom cell
```
static NSString *MainTableIdentifier = @"MainTableIdentifier";
cell = [tableView dequeueReusableCellWithIdentifier:MainTableIdentifier];
if (cell == nil)
{
 NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MainViewTableViewCell" owner:self options:nil];
 cell = [nib objectAtIndex:0];

    Note :- Cell is Maintableviewcell //Custom cell
```

# Json Call:-(GET)
```
NSString *path= [[NSBundle mainBundle] pathForResource:@"New Data" ofType:@"json"];
NSData *data = [[NSData alloc]initWithContentsOfFile:path];
     //Get data in Dictionary
NSDictionary *dicjson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    // NSLog(@"%@",dicjson);
NSArray *arrydata=[[NSArray alloc]initWithObjects:[dicjson valueForKey:@"results"], nil];
NSString *datasrring=[[NSString alloc]initWithFormat:@"%@",[[[arrydata firstObject]objectAtIndex:1]objectForKey:@"id"]];
```    
**Another Way ====>**
```
NSString *apiURL = @"http://180.211.99.162/jt/kinjal/mobileappdemoapi/callme.php?api=datalisting&lastid=0&limit=11";
NSURL *url = [NSURL URLWithString:apiURL];
NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse  *response, NSData *data,NSError *connectionError){
    //Get Data in Dictionary
NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    arryJsonResponce = [[NSMutableArray alloc]initWithArray:[jsonDic objectForKey:@"data"]];
```    
    
# Json Call:- (POST)   
```
-(void)btnreplaycommonmethod
{
 if   ([_txtAnswerStory.text isEqualToString:@""] )    { //if Text Field is Empty Validation measure
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"Fill answer";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1];
    }
    else //If textfield have Text then Post Request --
    {
        //Hud start to Show
        hudobj = [[MBProgressHUD alloc] initWithView:self.view];
        [hudobj setLabelText:@""];
        hudobj.dimBackground = YES;
        hudobj.mode =MBProgressHUDModeIndeterminate;
        [self.view addSubview:hudobj];
        [hudobj show:YES];
        NSString *url = [kPredefinedURL stringByAppendingPathComponent:kAnswerStory]; //Joint string and made url 
        NSString *body = [NSString stringWithFormat:@"answer=%@&your_fb_id=%@&your_fbname=%@&story_id=%@&post_user_fb_id=%@&noti_id=%@",self.txtAnswerStory.text,_objappDelegate.FbId,_objappDelegate.FbName,StoryId,post_user_fb_id,Notificationid]; //Parameter for Post
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];//Pass Whole URL
        [request setHTTPMethod:@"POST"]; //Service Name
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (data.length > 0) { //<--If datalength is not 0
                [hudobj hide:YES];
                [hudobj removeFromSuperViewOnHide];
                NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                if ([dict[@"status"] integerValue] == 1) { //<-- get status 1 if data post successfully
                    UIAlertController * alert=   [UIAlertController
                                                  alertControllerWithTitle:@"Success"
                                                  message:@"Thank You"
                                                  preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* yesButton = [UIAlertAction
                                                actionWithTitle:@"Ok"
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action)
                                                {
                                                    //Handel your yes please button action here
                                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                                    for (UIViewController *controller in self.navigationController.viewControllers) {
                                                        
                                                        //Do not forget to import AnOldViewController.h
                                                        if ([controller isKindOfClass:[NotificationViewController class]]) {
                                                            
                                                            [self.navigationController popToViewController:controller
                                                                                                  animated:YES];
                                                            break;
                                                        }
                                                    }
                                                    
                                                }];
                    
                    [alert addAction:yesButton];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }else{ //<--- If Data Post failed
                [hudobj hide:YES];
                [hudobj removeFromSuperViewOnHide];
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Failed"
                                              message:@"Please Try Again"
                                              preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"Ok"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action)
                                            {
                                                //Handel your yes please button action here
                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                                //[self.navigationController popToRootViewControllerAnimated:YES];
                                                
                                            }];
                [alert addAction:yesButton];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
     }
    }
```

# UIPickerview in Alertview ==> IOS 8.0 and Above

==>    *//In .h file* 
```
@interface AddDetailViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate
```    
==>    //In .m file open pickerview on Buttonclick
```
- (IBAction)btnCategory:(UIButton *)sender {
    [_txtTitle resignFirstResponder];
    [_txtPrice resignFirstResponder];
    //Declare Alertview
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select category" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    //Declare pickerview
    UIPickerView * pickerView = [[UIPickerView alloc] init];
    [pickerView setDataSource: self];
    [pickerView setDelegate: self];
    pickerView.tag=1; //If Required
    [pickerView setFrame: CGRectMake(alert.frame.origin.x, alert.frame.origin.y, alert.frame.size.width, alert.frame.size.height)];
    pickerView.showsSelectionIndicator = YES;
    [pickerView selectRow:2 inComponent:0 animated:YES];
    [alert addSubview:pickerView];
    [alert setValue:pickerView forKey:@"accessoryView"];
    [alert show];
}
```    
==>    #pragma mark --> UIPickeriew Delegate
```
 -(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1; //Component in pickerview
}
    // Total rows in our component.
 -(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag==1) {
        return [categoryArray count];
    }
    else
        return [SubcategoryArray count];
    }
    // Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag==1) {
        return [categoryArray objectAtIndex: row];
    }
    else
        return [SubcategoryArray objectAtIndex:row];
    }
    // Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView.tag==1) {
        _txtCategory.text=[categoryArray objectAtIndex:row];
    }
    else
        _txtSubcategory.text=[SubcategoryArray objectAtIndex:row];
    }
```    
    
   
#    Dictionary For loop Easily


     
     - (void)FilterData{
    [list removeAllObjects];
    if ([self.title isEqualToString:@"Songs"]) {
        for (NSDictionary *category in [AppDelegate mainDelegate].allData) {
            for (NSDictionary *subcategory in [category objectForKey:@"Sub_category"]) {
                [list addObjectsFromArray:[subcategory valueForKey:@"songs"]];
            }
        }
    }else if ([self.title isEqualToString:@"Categories"]) {
        for (NSDictionary *category in [AppDelegate mainDelegate].allData) {
           [list addObject:category];
        }
    }else if ([self.title isEqualToString:@"Favorite"]) {
        self.FavButton.hidden = YES;
        NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"lyrics_id" ascending:YES];
        [list addObjectsFromArray:[[AppDelegate mainDelegate].favorites sortedArrayUsingDescriptors:@[sd]]];
    }else{
        if (self.isSubCategory) {
            for (NSDictionary *category in [AppDelegate mainDelegate].allData) {
                if ([self.title isEqualToString:[category objectForKey:@"cat_name_hr"]]) {
                    [list addObjectsFromArray:[category valueForKey:@"Sub_category"]];
                    break;
                }
            }
        }else{
            for (NSArray *array in [[AppDelegate mainDelegate].allData valueForKey:@"Sub_category"]) {
                for (NSDictionary *Sub_category in array) {
                    if ([self.title isEqualToString:[Sub_category objectForKey:@"sub_cat_name_hr"]]) {
                        [list addObjectsFromArray:[Sub_category valueForKey:@"songs"]];
                        break;
                    }
                }
            }
        }
    }
    all = [[NSMutableArray alloc] initWithArray:list];
    [self.listTable reloadData];
     }
     
     
#  Check Button with Background Image
```
      //Also helpful for check in and out buttom
    - (IBAction)Tick:(id)sender{
    if ([[self.Tick imageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"check"]]) {
        [self.Tick setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        [self.Go setEnabled:NO];
    }else{
        [self.Tick setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        [self.Go setEnabled:YES];
    }
    
     [[NSUserDefaults standardUserDefaults] setBool:self.Go.enabled forKey:@"Verified"];
     [[NSUserDefaults standardUserDefaults] synchronize];
    }
```     

#   Autocomplete TextField 

https://ktrkathir.wordpress.com/2015/07/18/auto-complete-textfield-in-ios



