//
//  SPAnnotation.h
//  GDTest
//
//  Created by zjsruxxxy3 on 15/6/12.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface SPAnnotation : MAPointAnnotation

//@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate2;

@property (nonatomic, copy) NSString *userIcon;

@property (nonatomic, copy) NSString *currentUsers;
@property (nonatomic, copy) NSString *totalUsers;

@property (nonatomic, copy) NSString *itemName;

@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;

- (instancetype)initAnnotationWithDictionary: (NSDictionary *)dic;

+ (instancetype)spannotationWithDictionary: (NSDictionary *)dic;

@end
