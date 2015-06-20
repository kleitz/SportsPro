//
//  SPArrangeViewController.m
//  SportsPro
//
//  Created by zjsruxxxy3 on 15/6/3.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import "SPArrangeViewController.h"
#import "SPTitleSegement.h"
#import <MAMapKit/MAMapKit.h>
#import "SPCalloutView.h"
#import "SPAnnotationView.h"
#import "SPAnnotation.h"
#import <Masonry.h>

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

NSString* const AppKey = @"0e53206c7bebe6d6c7324f87e5718bbc";
CGFloat const defaultSpanValue = .02;
CGFloat const key = .002;
CGFloat const keyboardDuration = .250000;
//CGFloat const keyboardHeight = 224.0;

@interface SPArrangeViewController ()<MAMapViewDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)SPTitleSegement *titleSegement;

@property(nonatomic, weak)IBOutlet UIView *ContainerView;

@property(nonatomic, weak)IBOutlet UIView *toolView;

@property(nonatomic, weak)IBOutlet UITextField *searchView;

@property(nonatomic, weak)IBOutlet UIButton *dateButton;

@property(nonatomic, weak)IBOutlet UIButton *searchButton;

@property(nonatomic, strong)MAMapView *mapView;
@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, assign)CLLocationCoordinate2D userCoordinate;

@property(nonatomic, strong)NSArray *spannotations;

@property(nonatomic, strong)SPAnnotation *currentAnnotation;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolBarBottomConstraint;

@end

@implementation SPArrangeViewController

+ (void)load {
    
    [MAMapServices sharedServices].apiKey = AppKey;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchView.delegate = self;
    
    [self setupHeadTitle];
    
    [self addNotification];
    
    NSLog(@"%@",NSStringFromCGRect(self.ContainerView.bounds));
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self segmentSelected:nil];
    
}
- (void)addNotification {

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHideFrameNotification:) name:UIKeyboardWillHideNotification object:nil];
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


#pragma -
#pragma mark LazyInitilization
- (NSArray *)spannotations {
    
    if (!_spannotations) {
        
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"records" ofType:@"plist"];
        
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePath];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        [dataArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
            
            SPAnnotation *annotation = [SPAnnotation spannotationWithDictionary:dic];
            
            annotation.coordinate = annotation.coordinate2;
            
            [tempArray addObject:annotation];
            
        }];
        
        _spannotations = tempArray;
        
        
    }
//    NSLog(@"%@",_spannotations);
    
    
    return _spannotations;
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        
//        _tableView = [
        _tableView = (UITableView *) [[[NSBundle mainBundle] loadNibNamed:@"SPArrangeTableView" owner:nil options:0] lastObject];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ArrangeCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    
    return _tableView;
    
}
- (MAMapView *)mapView {
    
    if (!_mapView) {
        
        _mapView = [[MAMapView alloc]init];

        _mapView = [[MAMapView alloc]initWithFrame:self.ContainerView.frame];

        
//        _mapView = [MAMapView alloc]initWithFrame:<#(CGRect)#>
        _mapView.delegate = self;
        
        [self loadMAMap];
        
        
    }
    
    return _mapView;
    
}

#pragma mark -
#pragma mark Button Action
-(void)clickToBack:(UIButton *)sender {
    
    [self.mapView setRegion:MACoordinateRegionMake(self.mapView.centerCoordinate, MACoordinateSpanMake(defaultSpanValue,defaultSpanValue)) animated:NO];
    
    [self.mapView setCenterCoordinate:self.userCoordinate animated:YES];
    
}

#pragma mark -
#pragma mark TitleSegement Action
- (void)segmentSelected:(id)sender {
    
    
    NYSegmentedControl *control = (NYSegmentedControl *)sender;

    if (control.selectedSegmentIndex == 1) {
        
        [self loadMapViewWithData];
        [self loadLocationItem];

    }else {
        
        for (UIView *view in self.ContainerView.subviews) {
            
            [view removeFromSuperview];
        }
        
        [self.mapView deselectAnnotation:self.currentAnnotation animated:NO];
        
        [self loadTableViewWithData];
        
    }
    
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)loadLocationItem {
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(clickToBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.ContainerView addSubview:button];

    WS(weak_self);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.right.mas_equalTo(weak_self.ContainerView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.leading.equalTo(weak_self.ContainerView).with.offset(15);
        make.bottom.equalTo(weak_self.ContainerView).with.offset(-15);
        
    }];
    
    
}

#pragma mark -
#pragma mark TableView
- (void)loadTableViewWithData {
    
    [self.ContainerView addSubview:self.tableView];
    
    WS(weak_self);
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(weak_self.ContainerView).with.offset(0);
        make.trailing.equalTo(weak_self.ContainerView).with.offset(0);
        make.top.equalTo(weak_self.ContainerView).with.offset(0);
        make.bottom.equalTo(weak_self.ContainerView).with.offset(0);
        
    }];

}
#pragma mark -
#pragma mark MapView

- (void)loadMapViewWithData {
    
    [self.ContainerView addSubview:self.mapView];
    
    WS(weak_self);
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //        make.right.mas_equalTo(weak_self.ContainerView);
        make.size.mas_equalTo(weak_self.ContainerView.bounds.size);
        make.leading.equalTo(weak_self.ContainerView).with.offset(0);
        make.bottom.equalTo(weak_self.ContainerView).with.offset(0);
        
    }];

    [self.mapView addAnnotations:self.spannotations];
    
    [self.spannotations enumerateObjectsUsingBlock:^(SPAnnotation *obj, NSUInteger idx, BOOL *stop) {
        
        [weak_self.mapView addAnnotation:obj];
        
    }];
    
}

- (void)loadMAMap {
    
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.showsCompass = NO;
    _mapView.showsScale = NO;
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    
}

- (void)setUserCoordinate:(CLLocationCoordinate2D)userCoordinate {
    
    if (!_userCoordinate.longitude) {
        
        _userCoordinate = userCoordinate;
        
        self.mapView.centerCoordinate = userCoordinate;
        
        self.mapView.region = MACoordinateRegionMake(userCoordinate, MACoordinateSpanMake(defaultSpanValue,defaultSpanValue));
        
    }
    
}

#pragma mark -
#pragma mark MAMapViewDelegate
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView {
    
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation {
    
    self.userCoordinate = userLocation.coordinate;
    
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
//    NSLog(@"经度:%f,纬度:%f",mapView.region.center.longitude,mapView.region.center.latitude);
    
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        
        SPAnnotationView *spView = (SPAnnotationView*) [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        
        if (!spView) {
            
            spView = [[SPAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            
        }
        
        spView.image = [UIImage imageNamed:@"SportPoint@2x"];
        
        spView.centerOffset = CGPointMake(0, -18);
        
        return spView;
        
    }
    
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        
        MAUserLocation *userLocation = (MAUserLocation *)annotation;
        
        userLocation.title = @"当前位置";
        
    }
    
    
    return nil;
    
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
    MAUserLocationRepresentation *represention = [[MAUserLocationRepresentation alloc]init];
    represention.showsAccuracyRing = NO;
    represention.showsHeadingIndicator = NO;
    
    [mapView updateUserLocationRepresentation:represention];
    
    
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    
    SPAnnotation *annotation = (SPAnnotation *)view.annotation;
    
    //    annotation.coordinate;
    [mapView setCenterCoordinate:annotation.coordinate animated:YES];
    
    self.currentAnnotation = annotation;
    
}
/**
 *      mapView.showsUserLocation = NO 时调用
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView {
    
    NSLog(@"%s",__func__);
    
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    
    NSLog(@"%@",error);
    
}

#pragma mark -
#pragma mark TableViewDelegate & DateSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ArrangeCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    return cell;
    
}
#pragma mark -
#pragma mark TextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

        return YES;
    
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {
    
    NSLog(@"%s",__func__);

    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    
    self.toolBarBottomConstraint.constant = keyboardHeight;
    
    // 更新约束
//    [self updateLayout];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        
        [self.view layoutIfNeeded];
        
    }];
    
}

- (void)keyboardWillHideFrameNotification:(NSNotification *)notification {
    
    NSLog(@"%s",__func__);
    
    self.toolBarBottomConstraint.constant = 0;
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        
        [self.view layoutIfNeeded];
        
    }];}

- (void)updateLayout {
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        
        [self.view layoutIfNeeded];
        
    }];
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

@end
