//
//  RankMoreTableViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-18.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "RankMoreTableViewController.h"
#import "HomeInfo.h"
#import "HomeModel.h"
#import "RankTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MJRefresh.h"
#import "RankDetailTableViewController.h"

#define kSize [UIScreen mainScreen].bounds.size
@interface RankMoreTableViewController ()
{
    HomeModel *_homeModel;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    
}
    
@end

@implementation RankMoreTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, kSize.height)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //集成刷新
    
    _homeModel = [[HomeModel alloc] init];
    [self setupREfresh];
//    [_homeModel getRankMoreWithLimit:@"10" andOffset:@"0" andTagid:@"0" andType:@"4" andHomeBlock:^(BOOL isSucess, NSMutableArray *dataDic) {
//        if (isSucess) {
//            _dataArray = [dataDic mutableCopy];
//            [_tableView reloadData];
//        }
//    }];
    
    
}

- (void)setupREfresh
{
    [_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //进入程序就下拉刷新
    [_tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    _tableView.headerPullToRefreshText = @"下拉更新…";
    _tableView.headerReleaseToRefreshText = @"";
    _tableView.headerRefreshingText = @"数据刷新…";
    
    _tableView.footerPullToRefreshText = @"上拉加载数据…";
    _tableView.footerReleaseToRefreshText = @"";
    _tableView.footerRefreshingText = @"数据刷新…";
}

#pragma mark --开始进入刷新状态
- (void)headerRereshing
{
    
    [_homeModel getRankMoreWithLimit:@"10" andOffset:@"0" andTagid:@"0" andType:@"4" andHomeBlock:^(BOOL isSucess, NSMutableArray *dataDic) {
        if (isSucess) {
            //上拉刷新始终保持原始的数据条目个数
            [_dataArray removeAllObjects];
            _dataArray = [dataDic mutableCopy];
            [_tableView headerEndRefreshing];
            //            NSLog(@"magi%@",_dataArray);
            [_tableView reloadData];
        }
    }];
    
    
    
}

- (void)footerRereshing
{
    //网络请求后面的数据
    
    
    [_homeModel RefreshgetRankMoreWithLimit:@"10" andTagid:@"0" andType:@"4" andHomeBlock:^(BOOL isSucess, NSMutableArray *dataDic) {
        if (isSucess) {
            _dataArray = [dataDic mutableCopy];
            [_tableView footerEndRefreshing];
            //            NSLog(@"magi%@",_dataArray);
            [_tableView reloadData];
        }
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    HomeInfo *info = [[HomeInfo alloc] init];
    info = _dataArray[indexPath.row];
    cell.tag =  [info.IdStr integerValue];
    [cell.coverImgView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
    [cell.titleLabel setText:info.title];
    [cell.introLabel setText:info.intro];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankTableViewCell *cell = (RankTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    RankDetailTableViewController *detailVC = [[RankDetailTableViewController alloc] init];
    detailVC.idStr = cell.tag;
    [self.navigationController pushViewController:detailVC animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
