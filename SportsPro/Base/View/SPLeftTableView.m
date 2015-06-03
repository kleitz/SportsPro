//
//  SPLeftTableView.m
//  SportsPro
//
//  Created by zjsruxxxy3 on 15/6/3.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import "SPLeftTableView.h"

@implementation SPLeftTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = nil;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.bounces = NO;
    self.scrollsToTop = NO;
    
}
@end
