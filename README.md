# iWN
iWN
http://s000.tinyupload.com/index.php?file_id=09244370693754424466

CustomCell:-

1) First import three file . (Custom cell name .h and .m and then .xib)
2) Give IDENTIFIER to customcell.
3) Connect UIControls to custom cell's .h and .m file
4) Import customcell file in mainview controller.
5) Go to main view controller and register cell into viewdidload or regiser cell from xib in Datasource method. 
6) 
static NSString *MainTableIdentifier = @"MainTableIdentifier";
         cell = [tableView dequeueReusableCellWithIdentifier:MainTableIdentifier];
   
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MainViewTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
Note :- Cell is Maintableviewcell

