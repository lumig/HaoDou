//
//  AlbumViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-11.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//


//专辑controller
#import "AlbumViewController.h"
#import "HomeInfo.h"
#import "HomeModel.h"
#import "ListTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MJRefresh.h"
#import "FoodMenuViewController.h"

#define kSize [UIScreen mainScreen].bounds.size
@interface AlbumViewController ()
{
    HomeModel *_homeModel;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    NSMutableArray *_infoArray;
    NSMutableArray *_listArray;
    CGFloat _heightCell;
    NSMutableDictionary *_dict;
    NSInteger _offset;
    NSMutableArray *_array;
}
@end

@implementation AlbumViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, kSize.width, kSize.height- 64);
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _homeModel = [[HomeModel alloc] init];
    
    //集成刷新
    [self setupREfresh];
    [_homeModel getAidDataWithAid:@"4275308" andLimit:@"10" andOffset:@"0" andSign:@"33e3696577645da906cd6a378119b243"  andUid:@"6832623" andUuid:@"17EF523E05B42597F70A95681590F28B" andAidBlock:^(BOOL isSucess, NSMutableArray *dataArr) {
        if (isSucess) {
            _dataArray = [dataArr mutableCopy];
            [_tableView headerEndRefreshing];
            //            NSLog(@"magi%@",_dataArray);
            [_tableView reloadData];
        }
    }];
//    [_tableView reloadData];
//aid=4275308&limit=10&offset=0&sign=33e3696577645da906cd6a378119b243&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
   
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
    _offset = 0;
    [_homeModel getAidDataWithAid:@"4275308" andLimit:@"10" andOffset:[NSString stringWithFormat:@"%ld",(long)_offset] andSign:@"33e3696577645da906cd6a378119b243"  andUid:@"6832623" andUuid:@"17EF523E05B42597F70A95681590F28B" andAidBlock:^(BOOL isSucess, NSMutableArray *dataArr) {
        if (isSucess) {
            //上拉刷新始终保持原始的数据条目个数
            [_dataArray removeAllObjects];
            _dataArray = [dataArr mutableCopy];
            [_tableView headerEndRefreshing];
//            NSLog(@"magi%@",_dataArray);
            [_tableView reloadData];
        }
    }];

    
    
}

- (void)footerRereshing
{
    //网络请求后面的数据
    _offset+= 10;
    
    [_homeModel getAidDataWithAid:@"4275308" andLimit:@"10" andOffset:[NSString stringWithFormat:@"%ld",(long)_offset] andSign:@"33e3696577645da906cd6a378119b243"  andUid:@"6832623" andUuid:@"17EF523E05B42597F70A95681590F28B" andAidBlock:^(BOOL isSucess, NSMutableArray *dataArr) {
        if (isSucess) {
            _dataArray = [dataArr mutableCopy];
            [_tableView footerEndRefreshing];
            //            NSLog(@"magi%@",_dataArray);
            [_tableView reloadData];
        }
    }];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

//    return _listArray.count ;
    NSInteger count = 0;
    for (NSDictionary *dict in _dataArray)
    {
        if ([@"list" isEqualToString:[dict objectForKey:@"title"]]) {
            
            _listArray = [dict objectForKey:@"array"];
             count+= _listArray.count;
            //获取到list的所有数据
//            [_array addObjectsFromArray:_listArray];
        }
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        for (NSDictionary *dict in _dataArray) {
            if ([@"list" isEqualToString:[dict objectForKey:@"title"]]) {
                _listArray = [dict objectForKey:@"array"];
                [_array addObjectsFromArray:_listArray];
            }
        }
        //
        HomeInfo *info = [[HomeInfo alloc] init];
    if (_array.count > 0) {
        info = _array[indexPath.row];
        

    }
        NSString *text = info.intro;
    if (text.length >0) {
        CGSize constraint = CGSizeMake(kSize.width - 30, 2000.0f);
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        CGSize textSize = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _heightCell = textSize.height;
        
    }
    
//    NSLog(@"magi%f",_heightCell);
    return _heightCell + 210;
        
    
    
}
//设置头部
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    for (NSDictionary *dict in _dataArray) {
        if ([@"info" isEqualToString:[dict objectForKey:@"title"]]) {
            _infoArray = [dict objectForKey:@"array"];
        }
    }
    //
    HomeInfo *info = [[HomeInfo alloc] init];
    info = _infoArray[0];
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, 200)];
    UIImageView *coverView = [[UIImageView alloc] init];
    coverView.frame = CGRectMake(0, 0, kSize.width, 120);
    [coverView  setImageWithURL:[NSURL URLWithString:info.albumCover] placeholderImage:nil];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    [titleLab setTextColor:[UIColor whiteColor]];
    [titleLab setFont:[UIFont systemFontOfSize:18]];
    titleLab.center = CGPointMake(kSize.width / 2.0f, 30);
    [titleLab setText:info.albumTitle];
    
    UIImageView *backImgV = [[UIImageView alloc] initWithFrame:CGRectMake(100, 60, 35, 35)];
    [backImgV setImage:[UIImage imageNamed:@"yuan_03.png"]];
    UIImageView *iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(105, 65, 25, 25)];
    [iconImgV setImageWithURL:[NSURL URLWithString:info.albumAvatarUrl] placeholderImage:nil];
    UILabel *userLab = [[UILabel alloc] initWithFrame:CGRectMake(140, 75, 100, 10)];
    [userLab setFont:[UIFont systemFontOfSize:14]];
    [userLab setTextColor:[UIColor whiteColor]];
    [userLab setText:info.albumUserName];
    
    UILabel *introLab = [[UILabel alloc] init];
    [introLab setFrame:CGRectMake(15, 115, kSize.width - 30, 80)];
    [introLab setText:info.albumContent];
    [introLab setNumberOfLines:0];
    [introLab setFont:[UIFont systemFontOfSize:14]];
 
    
    [headerV addSubview:coverView];
    [headerV addSubview:titleLab];
    [headerV addSubview:backImgV];
    [headerV addSubview:iconImgV];
    [headerV addSubview:userLab];
    [headerV addSubview:introLab];
    return headerV;

}
//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 200; //section的高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
   

    _array = [NSMutableArray array];

        for (NSDictionary *dict in _dataArray)
        {
            if ([@"list" isEqualToString:[dict objectForKey:@"title"]]) {
                
                _listArray = [dict objectForKey:@"array"];
                //获取到list的所有数据
                [_array addObjectsFromArray:_listArray];
                //不能写这句话，这里涉及到深拷贝和浅拷贝，这里只拷贝了数据，没有拷贝地址
//                [_listArray removeAllObjects];
            }
            
        }
    
    NSLog(@"_array = %@",_array);
        //
        HomeInfo *info = [[HomeInfo alloc] init];
    if (_array.count > 0) {
        info = _array[indexPath.row];

    }
        [cell.coverView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
        [cell.titleLab setText:info.title];
    cell.tag = [info.recipeId integerValue];
        cell.userNameLab.text = [NSString stringWithFormat:@"by  %@",info.userName];
    [UIView beginAnimations:nil context:nil];
        if (cell.likeBtn.isSelected == YES)
        {
            if ([info.likeCount integerValue] >= 999) {
                [cell.showLab setText:@"999+"];
            }
            else
            [cell.showLab setText:[NSString stringWithFormat:@"%ld",([info.likeCount integerValue] + 1)]];
            
            
        }else
        {
            if ([info.likeCount integerValue] >= 999) {
                [cell.showLab setText:@"999+"];
            }else
                [cell.showLab setText:[NSString stringWithFormat:@"%ld",[info.likeCount integerValue]]];
        }
    [UIView commitAnimations];
        NSString *text = info.intro;
    if (text.length > 0) {
        CGSize contraint = CGSizeMake(kSize.width - 30, 2000.f);
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        CGSize textSize = [attributedText boundingRectWithSize:contraint options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _heightCell = textSize.height;
//        NSLog(@"magi%f",_heightCell);
    }
    
        [cell.introLab setFrame:CGRectMake(15, 200, kSize.width - 30, _heightCell)];
    [cell.introLab setText:info.intro];
        return cell;

    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = (ListTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    FoodMenuViewController *foodMenuVC = [[FoodMenuViewController alloc] init];
    //    foodMenuVC.recipeId = [NSString stringWithFormat:@"ld",cell.tag];
    foodMenuVC.recipeId = cell.tag;
    [self.navigationController pushViewController:foodMenuVC animated:NO];

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
