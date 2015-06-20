//
//  SPCalloutView.m
//  GDTest
//
//  Created by zjsruxxxy3 on 15/6/11.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import "SPCalloutView.h"


@implementation SPCalloutView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    
}

- (IBAction)clickUserButton:(id)sender {
    
    NSLog(@"%s",__func__);

}

- (IBAction)clickDateButton:(id)sender {
    
    NSLog(@"%s",__func__);

}

- (void)awakeFromNib {
    
    NSLog(@"%s",__func__);
    
}

@end
