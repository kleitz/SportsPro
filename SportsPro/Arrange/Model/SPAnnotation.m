//
//  SPAnnotation.m
//  GDTest
//
//  Created by zjsruxxxy3 on 15/6/12.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import "SPAnnotation.h"

@implementation SPAnnotation
//@dynamic coordinate;

+ (instancetype)spannotationWithDictionary:(NSDictionary *)dic {
    
    return [[self alloc]initAnnotationWithDictionary:dic];
    
}

- (instancetype)initAnnotationWithDictionary:(NSDictionary *)dic {
    
    if (self = [super init]) {
        
        _userIcon = dic[@"usrIcon"];
        
        _currentUsers = dic[@"currentUsers"];
        
        _totalUsers = dic[@"totalUsers"];
        
        _itemName = dic[@"itemName"];
        
        _longitude = dic[@"longitude"];
        
        _latitude = dic[@"latitude"];
        
        _coordinate2 = CLLocationCoordinate2DMake([_latitude doubleValue], [_longitude doubleValue]);
        
    }
    
    return self;
    
}

@end
