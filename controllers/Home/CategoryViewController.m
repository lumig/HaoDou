//
//  CategoryViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-27.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation CategoryViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
    //
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kSize.width, 44)];
    _searchBar.placeholder = @"搜索菜谱、专辑、话题";
    [self.view addSubview:_searchBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, kSize.height)];
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = _searchBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
