//
//  HomeViewController.m
//  HaoDou

//
//  Created by Lu Ming on 14-12-23.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "HomeModel.h"
#import "HomeInfo.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "HaveImgTableViewCell.h"
#import "HaveOneLabTableViewCell.h"
#import "HaveTwoLabTableViewCell.h"
#import "RankTableViewCell.h"
#import "TagButton.h"
#import "rankButton.h"
#import "TagViewController.h"
#import "EScrollerView.h"
#import "WebViewController.h"
#import "AlbumViewController.h"
#import "RecipeTableViewController.h"
#import "RankMoreTableViewController.h"
#import "RankDetailTableViewController.h"
#import "FeedBackTableViewController.h"
#import "CategoryViewController.h"

#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#define kGreen [UIColor colorWithRed:102/255.0f green:153/255.0f blue:0.0f alpha:1]

#define kCount [_dataArray count]
@interface HomeViewController ()
{
    UITableView *_tableView;
    HomeModel *_homeModel;
    NSMutableArray *_arrayData;
    //获取解析的数据
    NSMutableArray *_dataArray;
    //    HomeInfo *_info;
    UIPageControl *_pageController;
    EScrollerView *_scrollView;
    NSArray *_albumArray;
    NSArray *_recipeArray;
    NSArray *_wikiArray;
    NSArray *_tableArray;
    NSArray *_rankArray;
    NSArray *_tagArray;
    NSMutableArray *_imgArray;
}
@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置首页logo
    [self createHomeTitleView];
    //创建右边分类按钮
    [self createCategory];
    NSLog(@"bounds%f,%f",[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    
    //设置tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 108)];
    //    [_tableView addSubview:searchBar];
    
    //为了滑动是出现下面，是tableview的内容不会穿过导航栏
    self.navigationController.navigationBar.translucent = NO;
//    self.tabBarController.tabBar.translucent = NO;
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //不将它设为整个tableview的头部，这个不能随tableview一起滚动
    //设置整个tableview的header
//    _tableView.tableHeaderView = searchBar;
//    _tableView.tableFooterView = nil;
    //可以获取到数据了
    _homeModel = [[HomeModel alloc] init];
    [_homeModel refreshData:^(BOOL isSucess, NSMutableArray *dataDic) {
        if (isSucess) {
            _arrayData = [dataDic mutableCopy];
            [_tableView reloadData];
            
//            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];

            
        }
        NSLog(@"_arrayData%@",_arrayData);
        
    }];
    
    //info

    UIButton *adviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    adviceBtn.frame = CGRectMake(0, 0, kWidth -30, 60);
    [adviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [adviceBtn setTitle:@"意见反馈" forState:UIControlStateNormal];
    [adviceBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    //设置文本居中
    //        [adviceBtn setBackgroundColor:[UIColor blueColor]];
    adviceBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [adviceBtn addTarget:self action:@selector(clickAdviceBtn:) forControlEvents:UIControlEventTouchUpInside];
    _tableView.tableFooterView = adviceBtn;
   
    //调用数据
   
    
}


#pragma mark - tableView的代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell");
        UITableViewCell *cell1 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
        UITableViewCell *cell2 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
        UITableViewCell *cell3 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell4 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (cell1.tag == 5 || cell1.tag == 6) {
            WebViewController *webVC = [[WebViewController alloc] init];
            webVC.index =cell1.tag;
            [self.navigationController pushViewController:webVC animated:NO];
        }
        else if (cell1.tag == 1000) {
            AlbumViewController *albumVC = [[AlbumViewController alloc] init];
            [self.navigationController pushViewController:albumVC animated:NO];
        }
        else if( cell3.tag == 1)
        {
            RecipeTableViewController *recipeVC = [[RecipeTableViewController alloc] init];
            recipeVC.index = cell3.tag;
            
            [self.navigationController pushViewController:recipeVC animated:NO];
        }else if(cell2.tag == 0 || cell2.tag == 2 || cell2.tag == 3 || cell2.tag == 4)    {
            RecipeTableViewController *recipeVC = [[RecipeTableViewController alloc] init];
            recipeVC.index = cell2.tag;
            [self.navigationController pushViewController:recipeVC animated:NO];
        }else if(indexPath.row == 7)
        {
            RecipeTableViewController *recipeVC = [[RecipeTableViewController alloc] init];
            recipeVC.index = indexPath.row - 2;
            
            [self.navigationController pushViewController:recipeVC animated:NO];
        }

    }
    else
    {
        RankDetailTableViewController *detailVC = [[RankDetailTableViewController alloc] init];
        detailVC.idStr = cell4.tag;
        [self.navigationController pushViewController:detailVC animated:NO];
        
    }
    //    else if()
//    HaveImgTableViewCell *cell1 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
//    HaveOneLabTableViewCell *cell2 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
//    HaveTwoLabTableViewCell *cell3 = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
//    if (indexPath.row == 0) {
//        AlbumViewController *albumVC = [[AlbumViewController alloc] init];
//        albumVC.aid= cell1.aidStr;
//        albumVC.limit = cell1.limitStr;
//        albumVC.offset = cell1.offsetStr;
//        albumVC.sign = cell1.signStr;
//        albumVC.uidStr = cell1.uidStr;
//        albumVC.uuidStr = cell1.uuidStr;
//        [self.navigationController pushViewController:albumVC animated:NO];
//    }
//    else if (indexPath.row == 1 || indexPath.row == 8) {
//        WebViewController *webVC = [[WebViewController alloc] init];
//        webVC.urlStr = cell1.urlStr;
//        [self.navigationController pushViewController:webVC animated:NO];
//    }else if(indexPath.row == 3 || indexPath.row == 7 )
//    {
//        
//    }
    
    
 
}
//注意tableHeadView是指的整个table的HeadView, 你现在的需求是要自定义table中每个section的headView
//设置每个section的header
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{//写了没有
//    if (section == 0) {
//        return nil;
//    }
//    else
//    {
//        return @"榜单";
//    }
    
//    return nil;
//}
//这个方法有没有 对此方法viewForFooterInSection 无影响
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return nil;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    }
    else
        return 3;
    
}

//设置Header的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    NSLog(@"viewForHeaderInSection");
    if (section == 0)
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kWidth, 240)];
        
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [searchBar setPlaceholder:@"搜索菜谱、专辑、话题"];
        [headerView addSubview:searchBar];
        //设置searchBar的代理
        searchBar.delegate = self;
        
//        [headerView setUserInteractionEnabled:YES];
        //设置tag按钮
//        NSLog(@"magishow%@",_arrayData);
        for (NSDictionary *dic in _arrayData) {
            if ([@"tag" isEqualToString:[dic objectForKey:@"title"]]) {
                _tagArray = [dic objectForKey:@"array"];
            }
        }
        for (int i = 0; i < _tagArray.count; i++) {
            //
            HomeInfo *info = [[HomeInfo alloc] init];
            
            info = _tagArray[i];
            if (i < 4) {
                TagButton *tagBtn = [[TagButton alloc] init];
                [tagBtn setUserInteractionEnabled:YES];
                tagBtn.frame = CGRectMake(15 + i * (kWidth - 30) / 4.0f, 60, (kWidth - 30) / 4.0f, 30);
                //下面这种方法是获取不到数据的
                //                [tagBtn.imageView setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                //                tagBtn.titleLabel.text = info.title;
                [tagBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                
                [tagBtn setTitle:info.title forState:UIControlStateNormal];
//                tagBtn.tag = [tagIdArr[i] intValue];
                tagBtn.tag = [info.IdStr integerValue];
                NSLog(@"tag1=%ld",tagBtn.tag);
                NSLog(@"info.title%@",tagBtn.titleLabel.text);
                [headerView addSubview:tagBtn];
                [tagBtn addTarget:self action:@selector(clickTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                int j = i - 4;
                TagButton *tagBtn = [[TagButton alloc] init];
                tagBtn.frame = CGRectMake(15 + j * (kWidth - 30) / 4.0f, 90, (kWidth - 30) / 4.0f, 30);
                tagBtn.tag = i;
//                tagBtn.tag = [tagIdArr[i] intValue];
                tagBtn.tag = [info.IdStr integerValue];
                NSLog(@"tag2=%ld",tagBtn.tag);
                [tagBtn setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                
                [tagBtn setTitle:info.title forState:UIControlStateNormal];
                [headerView addSubview:tagBtn];
                [tagBtn addTarget:self action:@selector(clickTagBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            
        }
        
        
        
        //设置广告scrollview
        // 定时器 循环
        
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 130, kWidth -30, 100)];
 
        //    [_homeModel refreshData:^(BOOL isSucess, NSMutableArray *dataDic) {
        //        if (isSucess) {
        //            _arrayData = [dataDic mutableCopy];
        //无限调用是因为我不断的reloadData数据
        //            [_tableView reloadData];
        //        }
        //    }];
        for (NSMutableDictionary *dict in _arrayData) {
            if ([@"ad" isEqualToString:[dict objectForKey:@"title"]] ) {
                
                //获取解析后数组的数据
                _dataArray = [dict objectForKey:@"array"];
            }
        }
        NSLog(@"dataArray%@",_dataArray);
        
        //创建imgArr
        _imgArray = [NSMutableArray array];
        for (int i = 0; i < kCount; i++) {
            //
            HomeInfo *info = [[HomeInfo alloc] init];
            info = _dataArray[i];
            /*
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth - 30, 100)];
            
            
            [imgView setImageWithURL:[NSURL URLWithString:info.cover]
                    placeholderImage:nil];
            */
            [_imgArray addObject:info.cover];

        }
        if (_imgArray.count > 0) {
            _scrollView = [[EScrollerView alloc] initWithFrameRect:CGRectMake(15, 130, kWidth -30, 100) ImageArray:_imgArray TitleArray:nil autoPlay:YES];
        }
        
        _scrollView.delegate = self;
        [headerView addSubview:_scrollView];
        
//        _scrollView.contentSize = CGSizeMake((kCount + 2) * (kWidth - 30), 0);
//        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.bounces = YES;
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.userInteractionEnabled = YES;
//        _scrollView.delegate = self;
//        _scrollView.bounces = NO;
//        
//        for (int i = 0; i < kCount; i++) {
//            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i * (kWidth - 30) + (kWidth - 30), 0, (kWidth - 30), 100)];
//            [imgView setUserInteractionEnabled:YES];
//            HomeInfo *info = [[HomeInfo alloc] init];
//            info = _dataArray[i];
//            //后面是没有加载网络图片显示的图片
//            [imgView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
//            
//            [_scrollView addSubview:imgView];
//        }
//        //最后一张图片放在最前面0位置
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kWidth - 30), 100)];
//        HomeInfo *info = [[HomeInfo alloc] init];
//        info = _dataArray[kCount - 1];
//        [imgView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
//        [_scrollView addSubview:imgView];
//        // 取数组第一张图片放在最后1页
//        imgView.frame = CGRectMake((kCount + 1)* (kWidth - 30), 0, kWidth - 30, 100);
//        info = _dataArray[0];
//        [imgView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
//        [_scrollView addSubview:imgView];
//        //开启分页模式
//        _scrollView.pagingEnabled = YES;
//        [_scrollView setContentOffset:CGPointMake(0, 0)];
//        [_scrollView scrollRectToVisible:CGRectMake((kWidth - 30),0,kWidth - 30,100) animated:NO];
//        
//        //添加pageController
//        _pageController = [[UIPageControl alloc] init];
//        _pageController.bounds = CGRectMake(0, 0, 150, 20);
//        _pageController.center = CGPointMake((kWidth - 30) * 0.5, 215);
//        //        [self.view addSubview:pageController];
//        //        [self.view bringSubviewToFront:pageController];
//        //设置页码
//        _pageController.numberOfPages = kCount;
//        _pageController.currentPageIndicatorTintColor = kGreen;
//        _pageController.currentPage = 0;
//        //页码改变了，调用
//        [_pageController addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
        
        
        NSLog(@"_dataArray%@",_dataArray);
        
        
//        [headerView addSubview:_scrollView];
//        [headerView addSubview:_pageController];
//        [headerView bringSubviewToFront:_pageController];
        //    [headerView setBackgroundColor:[UIColor redColor]];102,153
        
        return headerView;
    }
    else
    {
        //创建榜单按钮
        rankButton *rankBtn = [rankButton buttonWithType:UIButtonTypeCustom];
        [rankBtn.textLabel setText:@"榜单"];
        [rankBtn.moreLabel setText:@"更多榜单"];
        [rankBtn addTarget:self action:@selector(clickRankMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        return rankBtn;
        
    }
}

-(void)EScrollerViewDidClicked:(NSUInteger)index;

{
    NSLog(@"EScrollerViewDidClicked%ld",index);
    WebViewController *webVC = [[WebViewController alloc] init];
    //    TagViewController *tagVC = [[TagViewController alloc] init];
    webVC.index = index - 1;
    [self.navigationController pushViewController:webVC animated:NO];
}

//// 定时器 绑定的方法
//- (void)runTimePage
//{
//    NSInteger page = _pageController.currentPage; // 获取当前的page
//    page++;
//    page = page > 4 ? 0 : page ;
//    _pageController.currentPage = page;
//    [self turnPage];
//}
//
//- (void)turnPage
//{
//    NSInteger page = _pageController.currentPage; // 获取当前的page
//    
////    [_scrollView setContentOffset:CGPointMake((_scrollView.frame.size.width)*(page), kWidth - 30) animated:NO];
//    
//    [_scrollView scrollRectToVisible:CGRectMake((_scrollView.frame.size.width)*(page),0,(kWidth - 30),100) animated:YES]; // 触摸pagecontroller那个点点 往后翻一页 +1
//}
//
//#pragma mark - 设置scroll的代理
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    //    int pageNo = scrollView.contentOffset.x / scrollView.frame.size.width;
//    //    _pageController.currentPage = pageNo;
//    
////    CGFloat pagewidth = _scrollView.frame.size.width;
////    int currentPage = floor(((_scrollView.contentOffset.x - pagewidth)/ ([_dataArray count]+2)) / pagewidth) + 1;
//    int currentPage= (int)_scrollView.contentOffset.x/(kWidth - 30); // 和上面两行效果一样
//        NSLog(@"currentPage==%d",currentPage);
//    if (currentPage==0)
//    {
//        [_scrollView scrollRectToVisible:CGRectMake((kWidth - 30) * [_dataArray count],0,kWidth - 30,100) animated:NO]; // 序号0 最后1页
//    }
//    else if (currentPage==([_dataArray count]+1))
//    {
//        [_scrollView scrollRectToVisible:CGRectMake((kWidth - 30),0,(kWidth - 30),100) animated:NO]; // 最后+1,循环第1页
//    }
//    
//}
//

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 250; //section的高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
}
//设置footer
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kWidth - 30, 60)];
//    
//    if (section == 0) {
//        return nil;
//    }
//    else
//    {
//        UIButton *adviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        adviceBtn.frame = CGRectMake(15, 0, kWidth -30, 60);
//        [adviceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [adviceBtn setTitle:@"意见反馈" forState:UIControlStateNormal];
//        [adviceBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
//  
//        //设置文本居中
////        [adviceBtn setBackgroundColor:[UIColor blueColor]];
//        adviceBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [adviceBtn addTarget:self action:@selector(clickAdviceBtn:) forControlEvents:UIControlEventTouchUpInside];
//        
//        
//        [footerView addSubview:adviceBtn];
//    }
//    return footerView;
//}
//
//cell定制
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //设置数据
    if(indexPath.section == 0)
    {
        
        static NSString *customCell1 = @"CustomCell1";
        static NSString *customCell2 = @"CustomCell2";
        static NSString *customCell3 = @"CustomCell3";
        
        HaveImgTableViewCell *cell1 = (HaveImgTableViewCell *)[tableView dequeueReusableCellWithIdentifier:customCell1];
        HaveOneLabTableViewCell *cell2 = (HaveOneLabTableViewCell *)[tableView dequeueReusableCellWithIdentifier:customCell2];
        HaveTwoLabTableViewCell *cell3 = (HaveTwoLabTableViewCell *)[tableView dequeueReusableCellWithIdentifier:customCell3];
        
        NSLog(@"indexPath.row %ld",indexPath.row);
        
        switch (indexPath.row)
        {
            case 0:
            {
                if (cell1 == nil) {
                    cell1 = [[HaveImgTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell1];
                }
                //设置数据
                for (NSDictionary *dict in _arrayData) {
                    if ([@"album" isEqualToString:[dict objectForKey:@"title"]]) {
                        _albumArray = [dict objectForKey:@"array"];
                    }
                }
                HomeInfo *info = [[HomeInfo alloc] init];
                info = _albumArray[0];
                [cell1.coverImgView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                [cell1.iconView setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                //设置下面的小图片
                NSArray *smallImgArray = info.smallCover;
                for (int i = 0; i < smallImgArray.count; i++) {
                    UIImageView  *subImgView=[[UIImageView alloc] init];
                    CGFloat smallImgWidth = (kWidth - 30) / 5.0f;
                    subImgView.frame = CGRectMake(i * smallImgWidth - 1, 0, smallImgWidth, smallImgWidth);
                    [subImgView setImageWithURL:[NSURL URLWithString:smallImgArray[i]] placeholderImage:nil];
                    [cell1.smallCoverImgView addSubview:subImgView];
                }
                cell1.titleLabel.text = info.title;
                cell1.introLabel.text = info.intro;
                //专辑没有利用传值
                cell1.tag = 1000;
                NSLog(@"cell1.titleLabel.text%@",cell1.titleLabel.text);
                //aid=4275308&limit=10&offset=0&sign=33e3696577645da906cd6a378119b243&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
//                cell1.aidStr = @"4275308";
//                cell1.limitStr = @"10";
//                cell1.offsetStr = @"0";
//                cell1.signStr = @"33e3696577645da906cd6a378119b243";
//                cell1.uidStr = @"6832623";
//                cell1.uuidStr = @"17EF523E05B42597F70A95681590F28B";
                
                return cell1;
            }
                break;
            case 1:
            {
                if (cell1 == nil) {
                    cell1 = [[HaveImgTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell1];
                }
                //设置数据
                for (NSDictionary *dict in _arrayData) {
                    if ([@"wiki" isEqualToString:[dict objectForKey:@"title"]]) {
                        _albumArray = [dict objectForKey:@"array"];
                    }
                }
                HomeInfo *info = [[HomeInfo alloc] init];
                info = _albumArray[0];
                [cell1.coverImgView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                [cell1.iconView setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                //设置下面的小图片
                cell1.imgIntroLabel.text = info.intro;
                cell1.titleLabel.text = info.title;
                cell1.introLabel.text = info.desc;
//                cell1.urlStr = @"http://group.haodou.com/topic-324608.html";
                cell1.tag = 5;
                return cell1;
                
            }
                break;
            case 2:
            {
                if (cell2 == nil) {
                    cell2 = [[HaveOneLabTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell2] ;
                }
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                
                HomeInfo *info = [[HomeInfo alloc] init];
                info = _recipeArray[0];
                if (info.icon.length == 0) {
                    [cell2.coverView  setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                    cell2.rTitleLabel.text = info.rTitle;
                    cell2.introLabel.text = info.intro;
                    cell2.titleLabel.text = info.title;
                    cell2.descLabel.text = info.desc;
                    cell2.tag = 0;
                    //Title=%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1&limit=15&offset=0&rid=826103&sign=33e3696577645da906cd6a378119b243&type=%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
//                    cell2.titleStr = @"%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1";
//                    cell2.limitStr = @"15";
//                    cell2.offsetStr = @"0";
//                    cell2.ridStr = @"826103";
//                    cell2.signStr = @"33e3696577645da906cd6a378119b243";
//                    cell2.typeStr = @"%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1";
//                    cell2.uidStr = @"6832623";
//                    cell2.uuidStr = @"17EF523E05B42597F70A95681590F28B";
                    
                }
                return cell2;
            }
                break;
                
            case 4:
            {
                if (cell2 == nil) {
                    cell2 = [[HaveOneLabTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell2] ;
                }
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                
                HomeInfo *info = [[HomeInfo alloc] init];
                info = _recipeArray[2];
                if (info.icon.length == 0) {
                    [cell2.coverView  setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                    cell2.rTitleLabel.text = info.rTitle;
                    cell2.introLabel.text = info.intro;
                    cell2.titleLabel.text = info.title;
                    cell2.descLabel.text = info.desc;
                    cell2.tag = 2;
                    //Title=%E6%97%B6%E4%BB%A4%E4%BD%B3%E8%82%B4&limit=15&offset=0&rid=373606&sign=33e3696577645da906cd6a378119b243&type=%E6%97%B6%E4%BB%A4%E4%BD%B3%E8%82%B4&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
//                    cell2.titleStr = @"%E6%97%B6%E4%BB%A4%E4%BD%B3%E8%82%B4";
//                    cell2.limitStr = @"15";
//                    cell2.offsetStr = @"0";
//                    cell2.ridStr = @"373606";
//                    cell2.signStr = @"33e3696577645da906cd6a378119b243";
//                    cell2.typeStr = @"%E6%97%B6%E4%BB%A4%E4%BD%B3%E8%82%B4";
//                    cell2.uidStr = @"6832623";
//                    cell2.uuidStr = @"17EF523E05B42597F70A95681590F28B";
                }
                return cell2;
            }
                break;
                
            case 5:
            {
                if (cell2 == nil) {
                    cell2 = [[HaveOneLabTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell2] ;
                }
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                
                HomeInfo *info = [[HomeInfo alloc] init];
                info = _recipeArray[3];
                if (info.icon.length == 0) {
                    [cell2.coverView  setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                    cell2.rTitleLabel.text = info.rTitle;
                    cell2.introLabel.text = info.intro;
                    cell2.titleLabel.text = info.title;
                    cell2.descLabel.text = info.desc;
                    cell2.tag = 3;
                    //Title=%E8%BE%BE%E4%BA%BA%E8%8F%9C%E8%B0%B1&limit=15&offset=0&rid=836922&sign=33e3696577645da906cd6a378119b243&type=%E8%BE%BE%E4%BA%BA%E8%8F%9C%E8%B0%B1&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
//                    cell2.titleStr = @"%E8%BE%BE%E4%BA%BA%E8%8F%9C%E8%B0%B1";
//                    cell2.limitStr = @"15";
//                    cell2.offsetStr = @"0";
//                    cell2.ridStr = @"836922";
//                    cell2.signStr = @"33e3696577645da906cd6a378119b243";
//                    cell2.typeStr = @"%E8%BE%BE%E4%BA%BA%E8%8F%9C%E8%B0%B1";
//                    cell2.uidStr = @"6832623";
//                    cell2.uuidStr = @"17EF523E05B42597F70A95681590F28B";
                    
                }
                return cell2;
            }
                break;
                
            case 6:{
                if (cell2 == nil) {
                    cell2 = [[HaveOneLabTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell2] ;
                }
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                HomeInfo *info = [[HomeInfo alloc] init];
                info = _recipeArray[4];
                if (info.icon.length == 0) {
                    [cell2.coverView  setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                    cell2.rTitleLabel.text = info.rTitle;
                    cell2.introLabel.text = info.intro;
                    cell2.titleLabel.text = info.title;
                    cell2.descLabel.text = info.desc;
                    ;cell2.tag = 4;
                    //Title=%E6%9C%80%E6%96%B0%E8%8F%9C%E8%B0%B1&limit=15&offset=0&rid=834919&sign=33e3696577645da906cd6a378119b243&type=%E6%9C%80%E6%96%B0%E8%8F%9C%E8%B0%B1&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
//                    cell2.titleStr = @"%E6%9C%80%E6%96%B0%E8%8F%9C%E8%B0%B1";
//                    cell2.limitStr = @"15";
//                    cell2.offsetStr = @"0";
//                    cell2.ridStr = @"834919";
//                    cell2.signStr = @"33e3696577645da906cd6a378119b243";
//                    cell2.typeStr = @"%E6%9C%80%E6%96%B0%E8%8F%9C%E8%B0%B1";
//                    cell2.uidStr = @"6832623";
//                    cell2.uuidStr = @"6832623&uuid=17EF523E05B42597F70A95681590F28B";
                    
                }
                
                return cell2;
            }
                break;
            case 3:
            {
                if (cell3 == nil)
                {
                    cell3 = [[HaveTwoLabTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell3];
                }
                
                
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                
                HomeInfo *info = [[HomeInfo alloc] init];
                info = _recipeArray[1];
                if (info.icon.length != 0) {
                    [cell3.coverView  setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                    [cell3.iconImgView setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                    cell3.rTitleLabel.text = info.rTitle;
                    cell3.introLabel.text = info.intro;
                    cell3.titleLabel.text = info.title;
                    cell3.descLabel.text = info.desc;
                  cell3.tag = 1;
                    
                    //Title=%E7%A7%81%E4%BA%BA%E5%AE%9A%E5%88%B6&limit=15&offset=0&rid=430459&sign=33e3696577645da906cd6a378119b243&type=%E7%A7%81%E4%BA%BA%E5%AE%9A%E5%88%B6&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
//                    cell3.titleStr = @"%E7%A7%81%E4%BA%BA%E5%AE%9A%E5%88%B6";
//                    cell3.limitStr = @"15";
//                    cell3.offsetStr = @"0";
//                    cell3.ridStr = @"430459";
//                    cell3.signStr = @"33e3696577645da906cd6a378119b243";
//                    cell3.typeStr = @"%E7%A7%81%E4%BA%BA%E5%AE%9A%E5%88%B6";
//                    cell3.uidStr = @"6832623";
//                    cell3.uuidStr = @"6832623&uuid=17EF523E05B42597F70A95681590F28B";
                    
                }
                return cell3;
            }
                break;
                
            case 7:{
                if (cell3 == nil) {
                    cell3 = [[HaveTwoLabTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell3];
                }
                
                
                
                for (NSDictionary *dict in _arrayData) {
                    if ([@"recipe" isEqualToString:[dict objectForKey:@"title"]]) {
                        _recipeArray = [dict objectForKey:@"array"];
                    }
                }
                
                
                HomeInfo *info = [[HomeInfo alloc] init];
                info = _recipeArray[5];
                //                if (info.icon.length != 0) {
                [cell3.coverView  setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                [cell3.iconImgView setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                cell3.rTitleLabel.text = info.rTitle;
                cell3.introLabel.text = info.intro;
                cell3.titleLabel.text = info.title;
                cell3.descLabel.text = info.desc;
                NSLog(@"case7");
//                cell3.tag = 5;
                //Title=%E6%9C%80%E6%96%B0%E8%8F%9C%E8%B0%B1&limit=15&offset=0&rid=834919&sign=33e3696577645da906cd6a378119b243&type=%E6%9C%80%E6%96%B0%E8%8F%9C%E8%B0%B1&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
                
//                cell3.titleStr = @"%E6%9C%80%E6%96%B0%E8%8F%9C%E8%B0%B1";
//                cell3.limitStr = @"15";
//                cell3.offsetStr = @"0";
//                cell3.ridStr = @"834919";
//                cell3.signStr = @"33e3696577645da906cd6a378119b243";
//                cell3.typeStr = @"%E6%9C%80%E6%96%B0%E8%8F%9C%E8%B0%B1";
//                cell3.uidStr = @"6832623";
//                cell3.uuidStr = @"6832623&uuid=17EF523E05B42597F70A95681590F28B";
                
                return cell3;
            }
                break;
            case 8:
            {
                if (cell1 == nil)
                {
                    cell1 = [[HaveImgTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCell1];
                }
                //设置数据
                for (NSDictionary *dict in _arrayData) {
                    if ([@"table" isEqualToString:[dict objectForKey:@"title"]]) {
                        _tableArray = [dict objectForKey:@"array"];
                    }
                }
                HomeInfo *info = [[HomeInfo alloc] init];
                info = _tableArray[0];
                [cell1.coverImgView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
                [cell1.iconView setImageWithURL:[NSURL URLWithString:info.icon] placeholderImage:nil];
                //设置下面的小图片
                cell1.titleLabel.text = info.title;
                cell1.introLabel.text = info.desc;
                
                
//                cell1.urlStr = @"http://group.haodou.com/topic-278170.html";
                cell1.tag = 6;
                return cell1;
            }
                break;
                //这里还有一点问题，不能返回空值
                //            default:
                //            return nil;
        }
    }
    else
    {
        static NSString *rankCell = @"RankCell";
        
        RankTableViewCell *cell4 = (RankTableViewCell *)[tableView dequeueReusableCellWithIdentifier:rankCell];
        if (cell4 == nil)
        {
            cell4 = [[RankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rankCell];
        }
        //
        for (NSDictionary *dict in _arrayData) {
            if ([@"rank" isEqualToString:[dict objectForKey:@"title"]]) {
                _rankArray = [dict objectForKey:@"array"];
            }
        }
        HomeInfo *info = [[HomeInfo alloc] init];
//        for (int i = 0; i < _rankArray.count; i++)
//        {
            info = _rankArray[indexPath.row];
            [cell4.coverImgView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
            cell4.titleLabel.text = info.title;
            cell4.introLabel.text = info.intro;
        if (indexPath.row == 0) {
            cell4.tag = 39;
        }else if(indexPath.row == 1)
        {
            cell4.tag = 30;
        }
        else
        {
            cell4.tag = 18;
        }
        
            return cell4;
            
//        }
        
    }
    
    return nil;
}
#pragma mark 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 270;
    }
    else
        return 65;
    
}



//设置header在不同section中的高度
#pragma mark 设置section的头部和尾部的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 250;
    }
    else
        return 45;
    //注释：
    //UITalbeView中的第一个section 为 0
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 250;
//    }
//    else
//        return 45;
//    //注释：
//    //UITalbeView中的第一个section 为 0
//}
//设置section里面的footer高度的设置
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 0;
//    }
//    else
//    {
//        return 0;
//    }
//}
#pragma mark - searchBar的代理方法


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    //设置动画效果
//    [UIView beginAnimations:NO context:NO];
//    [searchBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//    [self.view bringSubviewToFront:searchBar];
//    self.navigationController.navigationBarHidden = YES;
//    [UIView commitAnimations];
//    //
//    searchBar.showsScopeBar = YES;
//    searchBar.scopeButtonTitles= [NSArray arrayWithObjects:@"历史",@"热门",@"摇一摇", nil];
//    searchBar.selectedScopeButtonIndex = 0;
//    
    //push seachBar
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:NO];
    
    return NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
}





//
//- (void)pageChange
//{
//    //根据pageController的页码获得x的偏移值
//    CGFloat offsetX = _pageController.currentPage * (kCount - 30);
//    //    NSTimer *scrollTime = [NSTimer scheduledTimerWithTimeInterval:<#(NSTimeInterval)#> target:<#(id)#> selector:<#(SEL)#> userInfo:<#(id)#> repeats:<#(BOOL)#>];
//    [UIView beginAnimations:nil context:nil];
//    // 设置滚动位置
//    _scrollView.contentOffset = CGPointMake(offsetX, 0);
//    
//    [UIView commitAnimations];
//}



//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
//    [self.navigationController popViewControllerAnimated:searchBar];
    
    
}
//创建分类按钮
- (void)createCategory
{
    UIButton *categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryBtn setTitle:@"分类" forState:UIControlStateNormal];
    [categoryBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [categoryBtn setTitleColor:kGreen forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:categoryBtn];
    [categoryBtn addTarget:self action:@selector(clickCategory) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickCategory
{
    NSLog(@"clickCategory");
    CategoryViewController *categoryVC = [[CategoryViewController alloc] init];
    [self.navigationController pushViewController:categoryVC animated:YES];
    
}

- (void)createHomeTitleView
{
    UIImage *navImg = [UIImage imageNamed:@"system_logo.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, navImg.size.width, navImg.size.height)];
    imgView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height /2);
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [imgView setImage:navImg];
    self.navigationItem.titleView = imgView;
    
}

- (void)clickTagBtn:(TagButton *)btn
{
    NSLog(@"clickTagBtn");
    TagViewController *tagVC = [[TagViewController alloc] initWithTag:btn.tag];
    
//    NSLog(@"magiii%ld",btn.tag);
    
    tagVC.title = btn.titleLabel.text;
    tagVC.tagId = btn.tag;
    [self.navigationController pushViewController:tagVC animated:NO];
//    tagVC.tagId = btn.tag ;
}


#pragma mark - 点击了榜单按钮
- (void)clickRankMoreBtn:(rankButton *)btn
{
    NSLog(@"clickRankMoreBtn");
    RankMoreTableViewController *rankMoreVC = [[RankMoreTableViewController alloc] init];
    [self.navigationController pushViewController:rankMoreVC animated:NO];
}

#pragma mark - 点击了反馈意见按钮
- (void)clickAdviceBtn:(UIButton *)btn
{
    NSLog(@"clickAdviceBtn");
    FeedBackTableViewController *feedbackVC = [[FeedBackTableViewController alloc] init];
    [self.navigationController pushViewController:feedbackVC animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
