//
//  lockstore.h
//  iWorld News
//
//  Created by Nitin gohel on 10/29/15.
//  Copyright © 2015 Nitin gohel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface lockstore : NSObject
@property (nonatomic, retain) NSMutableDictionary *dict;
@property (nonatomic, retain) NSMutableArray *arr; 
+ (lockstore *) instance;
@end
