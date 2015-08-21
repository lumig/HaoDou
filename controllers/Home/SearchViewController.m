//
//  SearchViewController.m
//  HaoDou
//
//  Created by Lu Ming on 14-12-25.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import "SearchViewController.h"
#import "FMDatabase.h"
#import "LMDataManger.h"
#import "HomeModel.h"
#import "HomeInfo.h"
#import "TagViewController.h"

#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#define kGreen [UIColor colorWithRed:102/255.0f green:153/255.0f blue:0.0f alpha:1]


@interface SearchViewController ()
{
    UINavigationController *_searchNav;
    UIView *_view;
    UITableView *_tableView;
    NSArray *_hotArray;
    NSMutableArray *_historyArray;
    HomeModel *_homeModel;
    NSArray *_arrayData;
    UITableView *_hisTableView;
    UIImageView *_rockImgView ;
    UISearchBar *_searchBar;
    //用来判断哪个tableview的
    int  _isFlag;
}
@end

@implementation SearchViewController
#pragma mark

- (void)viewWillAppear:(BOOL)animated
{
    //隐藏导航栏
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    //viewDidAppear loadData
    _db = [LMDataManger getDataBase];
    //查询所有的好友信息
    _historyArray = [LMDataManger getAllHistory];
    //如果查询到好友信息，刷新显示列表
   
        [_tableView reloadData];
    [_hisTableView reloadData];
//    if(_isFlag == 2)
//    {
//        [self.view becomeFirstResponder];
//    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isFlag = 0;
    
    _homeModel = [[HomeModel alloc] init];
    [_homeModel getHotData:^(BOOL isSucess, NSMutableArray *dataDic) {
        if (isSucess) {
            //
            _hotArray = [dataDic mutableCopy];
            [_tableView reloadData];
        }
    }];
    
//     _hotArray = [NSArray arrayWithObjects:@"宴客菜", @"祛寒", @"羊肉", @"香菇", @"花菜",@"蛋挞", nil];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
//    NSLog(@"subViews=%@",[searchBar subviews]);
    
//    [searchBar setUserInteractionEnabled:NO];
    [searchBar setPlaceholder:@"搜索菜谱、专辑、话题"];
    
    [self.view addSubview:searchBar];

    UISegmentedControl *segController = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"历史",@"热门",@"摇一摇", nil]];
    segController.frame = CGRectMake(0, 64, kWidth - 30, 30);
    segController.center = CGPointMake(kWidth / 2.0f, 88);
    segController.selectedSegmentIndex = 0;
    //设置分度的背景色
    [segController setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:segController];
    [segController addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    
//    创建scopeBar,在真机调试中不能被显示
//    searchBar.showsScopeBar = YES;
//    searchBar.scopeButtonTitles= [NSArray arrayWithObjects:@"历史",@"热门",@"摇一摇", nil];
//    searchBar.selectedScopeButtonIndex = 0;
    
    //隐藏返回按钮
    //使之处于编辑状态
    _searchBar = searchBar;
    [_searchBar becomeFirstResponder];
//    [self.navigationController.view bringSubviewToFront:searchBar];
    searchBar.delegate = self;
    
    //设置scopeButton的背景颜色
    [[UISegmentedControl appearanceWhenContainedIn:[UISearchBar class], nil] setTintColor:[UIColor grayColor]];
//    [searchBar setScopeBarBackgroundImage:[UIImage imageNamed:<#(NSString *)#>]];
    
    //设置searchbar的背景颜色
    
//    [[searchBar.subviews objectAtIndex:0] removeFromSuperview];
//   searchBar.backgroundColor=[UIColor whiteColor];
//    NSLog(@"subViews=%@",[[searchBar.subviews objectAtIndex:0]subviews]);
//    [[[[searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
//    for (int i=0; i<[[searchBar.subviews objectAtIndex:0]subviews].count; i++) {
//        UIView *searchView = [[[searchBar.subviews objectAtIndex:0]subviews]objectAtIndex:i];
//        NSLog(@"searchView=%@",searchView);
//        if ([searchView isMemberOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//            searchView.backgroundColor = [UIColor redColor];
//            
//        }
//    }
//    
//    [searchBar setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1]];

    
    _hisTableView = [[UITableView alloc] init];
    _hisTableView.frame = CGRectMake(15, 108, kWidth - 30, kHeight);
    [self.view addSubview:_hisTableView];
    _hisTableView.dataSource = self;
    _hisTableView.delegate = self;
    
    _homeModel = [[HomeModel alloc] init];
    [_homeModel getSearchData:^(BOOL isSucess, NSMutableArray *dataDic) {
        if (isSucess)
        {
            _arrayData = [dataDic mutableCopy];
            [_tableView reloadData];
        }
        NSLog(@"_arrayData%@",_arrayData);
    }];
    
    searchBar.selectedScopeButtonIndex = 0;
}
- (void)segmentedAction:(UISegmentedControl *)seg
{
    NSInteger index = seg.selectedSegmentIndex;
    
    if (index  == 0)
    {
        
        _isFlag = 0;
        [_hisTableView reloadData];
        [_rockImgView setHidden:YES];
        return;
       
        
    }else if(index == 1)
    {
        _isFlag = 1;
//        [_searchBar resignFirstResponder];
        [_hisTableView reloadData];
        [_rockImgView setHidden:YES];
        return;
    }else
    {
        //
        _isFlag = 2;
//        [_searchBar resignFirstResponder];
        [self.view becomeFirstResponder];
        //
        _rockImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 108, kWidth, kHeight)];
        [_rockImgView setImage:[UIImage imageNamed:@"1111.jpg"]];
        [self.view addSubview:_rockImgView];
    }

}
#pragma mark searchBar的代理
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
    
    
    if (selectedScope  == 0)
    {
        
        _isFlag = 0;
        [_hisTableView reloadData];
        [_rockImgView setHidden:YES];
        return;
        //历史
//        _hisTableView = [[UITableView alloc] init];
//        _hisTableView.frame = CGRectMake(15, 108, kWidth - 30, kHeight);
//        [self.view addSubview:_hisTableView];
//        _hisTableView.dataSource = self;
//        _hisTableView.delegate = self;
        
    }else if(selectedScope == 1)
    {
        _isFlag = 1;
        [_hisTableView reloadData];
        [_rockImgView setHidden:YES];
       
        return;
//        //热门 ico_cell_search.png
//        _tableView = [[UITableView alloc] init];
//        _tableView.frame = CGRectMake(15, 108, kWidth - 30, kHeight);
//        [self.view addSubview:_tableView];
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
        
    }else
    {
        //
        _rockImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 108, kWidth, kHeight)];
        [_rockImgView setImage:[UIImage imageNamed:@"1111.jpg"]];
        [self.view addSubview:_rockImgView];
    }
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:NO];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //respondsToSelector:？
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [self.navigationController popToRootViewControllerAnimated:searchBar];
}

#pragma mark - 设置tableview的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (_isFlag == 0) {
        return _historyArray.count;

    }else
    {
        return _hotArray.count;

    }
    
//    if (tableView == _hisTableView) {
//        return _historyArray.count;
//    }else if (tableView == _tableView)
//    {
//        return _hotArray.count;
//    }else
//    {return 0;
//    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    
    if(_isFlag == 0)
    {
        
        [cell.imageView  setImage:[UIImage imageNamed:@"ico_cell_search.png"]];
        [cell.textLabel setText:_historyArray[indexPath.row]];
    }else
    {
        
        [cell.imageView  setImage:[UIImage imageNamed:@"ico_cell_search.png"]];
        [cell.textLabel setText:_hotArray[indexPath.row]];
    }
    /*
    //
    if (tableView == _hisTableView) {
        [cell.imageView  setImage:[UIImage imageNamed:@"ico_cell_search.png"]];
        [cell.textLabel setText:_historyArray[indexPath.row]];
    }
    
    //热门
//    if (tableView == _tableView) {
    else{
        [cell.imageView  setImage:[UIImage imageNamed:@"ico_cell_search.png"]];
        [cell.textLabel setText:_hotArray[indexPath.row]];
    }
    */
    
    return cell;
}

//点击cell触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //得到FMDataBase数据库对象
    _db = [LMDataManger getDataBase];
    if (_isFlag == 0) {
        if ([@"清空历史记录" isEqualToString:_historyArray[indexPath.row]]) {
            [_historyArray removeAllObjects];
            [LMDataManger deleteAllHistory];
            [_hisTableView reloadData];
            
        }else if ([@"宴客菜" isEqualToString:_historyArray[indexPath.row]] ) {
        }
        UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
        
        TagViewController *tagVC = [[TagViewController alloc] init];
        
        tagVC.title = cell.textLabel.text;
        [self.navigationController pushViewController:tagVC animated:NO];

    }
    else if(_isFlag == 1){
        UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
        
        TagViewController *tagVC = [[TagViewController alloc] init];
        
        tagVC.title = cell.textLabel.text;
        [self.navigationController pushViewController:tagVC animated:NO];
    
    if(_historyArray == nil)
    {
        [LMDataManger addHistoryData:@"清空历史记录"];
        [LMDataManger addHistoryData:_hotArray[indexPath.row]];
    }
    else{
        [LMDataManger addHistoryData:@"清空历史记录"];
        [LMDataManger addHistoryData:_hotArray[indexPath.row]];
        
    }
    NSLog(@"document%@",NSHomeDirectory());
    }
    
}


- (void)viewDidDisappear:(BOOL)animated
{
    if (_isFlag == 2) {
        [self.view resignFirstResponder];
        // 不要忘记去实现父类方法
        [super viewDidDisappear:animated];
    }
 
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (_isFlag == 2) {
        if (motion == UIEventSubtypeMotionShake) {
            NSLog(@"摇啊摇，摇到外婆桥！！！");
            TagViewController *tagVC = [[TagViewController alloc] init];
            
            tagVC.title = @"春饼";
            [self.navigationController pushViewController:tagVC animated:NO];
        }

    }
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
    
    
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
