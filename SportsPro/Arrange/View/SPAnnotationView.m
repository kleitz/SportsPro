//
//  SPAnnotationView.m
//  GDTest
//
//  Created by zjsruxxxy3 on 15/6/11.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import "SPAnnotationView.h"
#import "SPAnnotation.h"

#define kCalloutWidth 173.0
#define kCalloutHeight 98.0

@interface SPAnnotationView ()

@property (nonatomic, strong, readwrite) SPCalloutView *calloutView;

@end

@implementation SPAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    if (self.selected == selected) {
        
        return;
    }
    
    if (selected) {

        if (self.calloutView == nil)
        {
            
            
            SPCalloutView *callView =  [[[NSBundle mainBundle]loadNibNamed:@"SPCalloutView" owner:nil options:nil] lastObject];
            
            self.calloutView = callView;
//            self.calloutView = [[SPCalloutView alloc] initWithFrame:CGRectMake(0, 0,kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f +self.calloutOffset.x,-CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            
        }
        
        SPAnnotation *spA = (SPAnnotation *)self.annotation;

        self.calloutView.itemName.text = spA.itemName;
        
        [self.calloutView.userButton setImage:[UIImage imageNamed:spA.userIcon] forState:UIControlStateNormal];
        
        self.calloutView.userButton.backgroundColor = [UIColor grayColor];
        
        self.calloutView.numLabel.text = [NSString stringWithFormat:@"%@/%@人",spA.currentUsers,spA.totalUsers];
        
        

//        self.calloutView.bgView.image = [UIImage imageNamed:spA.userIcon];
        self.calloutView.bgView.image = [UIImage imageNamed:@"messages_groupchat_bubble_tips.png"];
        
        [self addSubview:self.calloutView];
        
        
    }else {
        
        [self.calloutView removeFromSuperview];
        
    }
    
    [super setSelected:selected animated:animated];
    
}

@end
