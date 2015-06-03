//
//  SPLeftItem.h
//  SportsPro
//
//  Created by zjsruxxxy3 on 15/6/3.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLeftItem : NSObject

@property(copy,nonatomic)NSString *menuTitle;

@property(copy,nonatomic)NSString *menuIcon;

+ (instancetype)leftItemWithDictionary:(NSDictionary *)dic;

- (instancetype)initItemWithDictionary: (NSDictionary *)dic;

@end
