//
//  SPLeftItem.m
//  SportsPro
//
//  Created by zjsruxxxy3 on 15/6/3.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import "SPLeftItem.h"

@implementation SPLeftItem

+ (instancetype)leftItemWithDictionary:(NSDictionary *)dic {
    
    return [[self alloc]initItemWithDictionary:dic];
    
}

- (instancetype)initItemWithDictionary: (NSDictionary *)dic {
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}

@end
