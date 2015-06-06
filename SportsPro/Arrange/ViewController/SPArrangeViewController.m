//
//  SPArrangeViewController.m
//  SportsPro
//
//  Created by zjsruxxxy3 on 15/6/3.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import "SPArrangeViewController.h"
#import "SPTitleSegement.h"

@interface SPArrangeViewController ()

@property(nonatomic,strong)SPTitleSegement *titleSegement;

@property(nonatomic,weak)IBOutlet UIView *ContainerView;

@property(nonatomic,weak)IBOutlet UIView *toolView;

@property(nonatomic,weak)IBOutlet UITextField *searchView;

@property(nonatomic,weak)IBOutlet UIButton *dateButton;

@property(nonatomic,weak)IBOutlet UIButton *searchButton;

@end

@implementation SPArrangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupHeadTitle];
    
//    self.navigationItem.prompt = @"约运动";
    

}

- (void)setupHeadTitle {
    
    _titleSegement = [SPTitleSegement titleSegement];
    [_titleSegement addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.title = nil;
    self.navigationItem.titleView = _titleSegement;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.searchView resignFirstResponder];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -
#pragma mark TitleSegement Action 
- (void)segmentSelected:(id)sender {
    
    
    NYSegmentedControl *control = (NYSegmentedControl *)sender;
    
    NSLog(@"%lu",control.selectedSegmentIndex);
    
    /*
    if (self.ContainerView.subviews) {
        
        for (UIView *view in self.ContainerView.subviews) {
            
            [view removeFromSuperview];
        }
    }
     */
    

    if (control.selectedSegmentIndex == 1) {

        UIView *view = [[UIView alloc]initWithFrame:self.ContainerView.frame];

        view.backgroundColor = [UIColor yellowColor];
        
        [self.ContainerView addSubview:view];

    }else {
        
        [self.ContainerView.subviews[0] removeFromSuperview];
        
    }
    
    /*
     UIView *exampleViewToShow = self.exampleViews[self.segmentedControl.selectedSegmentIndex];
     if (self.visibleExampleView == exampleViewToShow) {
     return;
     }
     
     self.visibleExampleView.hidden = YES;
     exampleViewToShow.hidden = NO;
     self.visibleExampleView = exampleViewToShow;
     */
    
}
@end
