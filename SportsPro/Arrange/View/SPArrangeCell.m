//
//  SPArrangeCell.m
//  SportsPro
//
//  Created by zjsruxxxy3 on 15/6/20.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import "SPArrangeCell.h"

@implementation SPArrangeCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    NSLog(@"%s",__func__);
    
    [self becomeFirstResponder];
    
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}
@end
