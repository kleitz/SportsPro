//
//  SPTitleSegement.m
//  SegementDemo
//
//  Created by zjsruxxxy3 on 15/6/5.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import "SPTitleSegement.h"

@implementation SPTitleSegement

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (SPTitleSegement *)titleSegement {

    SPTitleSegement *title = [[SPTitleSegement alloc] initWithItems:@[@"地图约", @"列表约"]];
    
    title.titleTextColor =  [UIColor whiteColor];
    
    title.selectedTitleTextColor = [UIColor colorWithRed:245/255.0f green:72/255.0f blue:45/255.0f alpha:1.0f];

    title.selectedTitleFont = [UIFont boldSystemFontOfSize:16];
    
    title.segmentIndicatorBackgroundColor = [UIColor whiteColor];
    
    title.backgroundColor = [UIColor colorWithRed:245/255.0f green:72/255.0f blue:45/255.0f alpha:1.0f];
    
    title.borderWidth = 0.0f;
    title.segmentIndicatorBorderWidth = 1.0f;
    title.segmentIndicatorInset = 1.0f;
    title.segmentIndicatorBorderColor = [UIColor whiteColor];
    
    [title sizeToFit];
    title.cornerRadius = CGRectGetHeight(title.frame) / 2.0f;
    
    CGRect rect = title.bounds;
    CGSize size = title.bounds.size;
    size.width = 160;
    rect.size = size;
    title.bounds = rect;
    
    NSLog(@"%@",NSStringFromCGRect(title.bounds));
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    title.usesSpringAnimations = YES;
#endif
    
    return title;
    
    
}
@end
