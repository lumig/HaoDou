//
//  MainViewController.m
//  HaoDou
//
//  Created by Lu Ming on 14-12-23.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "CenterViewController.h"
#import "GatherViewController.h"
#import "FindViewController.h"
@interface MainViewController ()
{
    HomeViewController *_homeVC;
    CenterViewController *_centerVC;
    GatherViewController *_gatherVC;
    FindViewController *_findVC;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建tabBar
    [self createTabBarItems];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}

- (void)createTabBarItems
{
    //精选
    _homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:_homeVC];
    UIImage *selectedHomeImg = [UIImage  imageNamed:@"menu_ico_home_on.png"];
    selectedHomeImg = [selectedHomeImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _homeVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"精选" image:[UIImage  imageNamed:@"menu_ico_home.png"] selectedImage:selectedHomeImg];
    [self unselectedTabBarItem:_homeVC.tabBarItem];
    [self selectedTabBatItem:_homeVC.tabBarItem];
    
    //发现
    _findVC = [[FindViewController alloc] init];
    UINavigationController *findNav = [[UINavigationController alloc] initWithRootViewController:_findVC];
    UIImage *selectedFindImg = [UIImage  imageNamed:@"menu_ico_find_on.png"];
    selectedFindImg = [selectedFindImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _findVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage  imageNamed:@"menu_ico_find.png"] selectedImage:selectedFindImg];
    [self unselectedTabBarItem:_findVC.tabBarItem];
    [self selectedTabBatItem:_findVC.tabBarItem];
    
    //广场
    _centerVC = [[CenterViewController alloc] init];
    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:_centerVC];
    UIImage *selectedCenterImg = [UIImage  imageNamed:@"menu_ico_center_on.png"];
    selectedCenterImg = [selectedCenterImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _centerVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage  imageNamed:@"menu_ico_center.png"] selectedImage:selectedCenterImg];
    [self unselectedTabBarItem:_centerVC.tabBarItem];
    [self selectedTabBatItem:_centerVC.tabBarItem];
    
    //我的
    _gatherVC = [[GatherViewController alloc] init];
    UINavigationController *gatherNav = [[UINavigationController alloc] initWithRootViewController:_gatherVC];
    //设置选中的图片
    UIImage *selectedGatherImage = [UIImage  imageNamed:@"menu_ico_gather_on.png"];
    //声明这张图片用原图
    selectedGatherImage = [selectedGatherImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _gatherVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"广场" image:[UIImage  imageNamed:@"menu_ico_gather.png"] selectedImage:selectedGatherImage];
    [self unselectedTabBarItem:_gatherVC.tabBarItem];
    [self selectedTabBatItem:_gatherVC.tabBarItem];
    self.viewControllers = [NSArray arrayWithObjects:homeNav, findNav, centerNav, gatherNav, nil];

    
    
}

- (void)unselectedTabBarItem:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13], NSFontAttributeName, [UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
}

- (void)selectedTabBatItem:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateSelected];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
