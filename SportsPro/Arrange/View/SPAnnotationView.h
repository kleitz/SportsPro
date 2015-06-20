//
//  SPAnnotationView.h
//  GDTest
//
//  Created by zjsruxxxy3 on 15/6/11.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "SPCalloutView.h"

@interface SPAnnotationView : MAAnnotationView

@property (nonatomic, readonly) SPCalloutView *calloutView;

@end
