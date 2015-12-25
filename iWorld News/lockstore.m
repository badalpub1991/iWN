//
//  lockstore.m
//  iWorld News
//
//  Created by Nitin gohel on 10/29/15.
//  Copyright © 2015 Nitin gohel. All rights reserved.
//

#import "lockstore.h"

@implementation lockstore


+ (lockstore*) instance
{
    static dispatch_once_t _singletonPredicate;
    static lockstore *_singleton = nil;
    
    dispatch_once(&_singletonPredicate, ^{
        _singleton = [[super allocWithZone:nil] init];
    });
    
    return _singleton;
}

+ (id) allocWithZone:(NSZone *)zone {
    return [self instance];
}
@end
