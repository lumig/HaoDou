//
//  RankDetailTableViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-18.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "RankDetailTableViewController.h"
#import "HomeModel.h"
#import "HomeInfo.h"
#import "UIImageView+AFNetworking.h"
#import "ListTableViewCell.h"
#import "FoodMenuViewController.h"
#define kSize [UIScreen mainScreen].bounds.size


@interface RankDetailTableViewController ()
{
    HomeModel *_homeModel;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    NSArray *_listArray;
    NSArray *_infoArray;
}
@end

@implementation RankDetailTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _homeModel = [[HomeModel alloc] init];
    [_homeModel getRankDetailWithId: [NSString stringWithFormat:@"%ld",self.idStr]andHomeBlock:^(BOOL isSucess, NSMutableArray *dataDic) {
        if (isSucess) {
            _dataArray = [dataDic mutableCopy];
            [_tableView reloadData];
        }
    }];
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, kSize.width, kSize.height);
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}

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
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, kSize.width - 30, 20)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [titleLab setFont:[UIFont systemFontOfSize:18]];
    [titleLab setText:info.title];
    
    UILabel *introLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, kSize.width - 30, 50)];
    [introLab setText:info.intro];
    [introLab setFont:[UIFont systemFontOfSize:14]];
    [introLab setNumberOfLines:0];
    
    [headerV addSubview:titleLab];
    [headerV addSubview:introLab];
    return headerV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    for (NSDictionary *dict in _dataArray) {
        if ([@"list" isEqualToString:[dict objectForKey:@"title"]]) {
            _listArray = [dict objectForKey:@"array"];
        }
    }
    //
    HomeInfo *info = [[HomeInfo alloc] init];
    info = _listArray[indexPath.row];
    [cell.coverView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
    [cell.titleLab setText:info.title];
    [cell.titleLab setFrame:CGRectMake(60, 150, kSize.width - 30, 20)];
    [cell.userNameLab setText:[NSString stringWithFormat:@"by  %@",info.userName]];
    [cell.userNameLab setFrame:CGRectMake(60, 170, kSize.width - 30, 20)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 150, 27, 26)];
    [imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"bg_array_before_0%ld.png",indexPath.row + 1]]];
    [[cell contentView] addSubview:imgView];
    //用来传给foodmenu
    cell.tag = [info.recipeId intValue];
//    NSLog(@"");
    return cell;
}

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 100; //section的高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = (ListTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    FoodMenuViewController *foodMenuVC = [[FoodMenuViewController alloc] init];
//    foodMenuVC.recipeId = [NSString stringWithFormat:@"ld",cell.tag];
    foodMenuVC.recipeId = cell.tag;
    [self.navigationController pushViewController:foodMenuVC animated:NO];
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
