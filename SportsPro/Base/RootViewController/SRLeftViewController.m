//
//  SRLeftViewController.m
//  SportsPro
//
//  Created by zjsruxxxy3 on 15/6/3.
//  Copyright (c) 2015年 WRC. All rights reserved.
//

#import "SRLeftViewController.h"
#import "SPLeftItem.h"

@interface SRLeftViewController ()
{
    
}

@property (strong, readwrite, nonatomic)IBOutlet UITableView *tableView;

@property (strong,nonatomic)SPLeftItem *leftItem;

@property (strong, nonatomic)NSArray *itemArray;

@end

@implementation SRLeftViewController

- (NSArray *)itemArray {
    
    if (!_itemArray) {
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        NSString *filePath =[[NSBundle mainBundle]pathForResource:@"LeftMenuItems" ofType:@"plist"];
        
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
            
            SPLeftItem *item = [SPLeftItem leftItemWithDictionary:dic];
            
            [tempArray addObject:item];
            
            
        }];
        
        _itemArray = tempArray;
        
    }
    
    return _itemArray;
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor clearColor];
    
    self.tableView.delegate= self;
    self.tableView.dataSource = self;
    
    
}


#pragma mark -
#pragma mark UITableView Datasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"leftMenuOriginalCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    cell.textLabel.text = [self.itemArray[indexPath.row] menuTitle];
    
//    NSArray *titles = @[@"Home", @"Calendar", @"Profile", @"Settings", @"Log Out"];
//    NSArray *images = @[@"IconHome", @"IconCalendar", @"IconProfile", @"IconSettings", @"IconEmpty"];
//    cell.textLabel.text = titles[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}


#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.sideMenuViewController hideMenuViewController];
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"firstViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"secondViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        default:
            break;
     
    }
     */
    
    
}

@end
