//
//  MainViewTableViewCell.h
//  News-Application
//
//  Created by Nitin gohel on 8/21/15.
//  Copyright (c) 2015 Badal-PUB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ImgMainView;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblDateTime;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;

@end
