//
//  FoodMenuViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-24.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "FoodMenuViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MenuModel.h"
#import "UIImageView+AFNetworking.h"
#import "FoodMenuInfo.h"
#import "MainStuffInfo.h"
#import "OtherStuffInfo.h"
#import "StepsInfo.h"
#import "StepTableViewCell.h"
#import "ShowImgView.h"
#import "ProductInfo.h"
#import "EScrollerView.h"
#import "StepImgViewController.h"
#import "CommentListInfo.h"
#import "CommentTableViewCell.h"


@interface FoodMenuViewController ()
{
    MenuModel *_menuModel;
    //    NSArray *_dataArray;
    UITableView *_tableView;
    FoodMenuInfo *_info;
    MainStuffInfo *_mainInfo;
    BOOL _isClick;
    UIImageView *_bigLabView;
    CGFloat _heightCell;
    NSMutableArray *_imgArray;
//    EScrollerView *_scrollView;
    UIScrollView *_scrollView;
    UIPageControl *_pageController;
    CGFloat _connHeight;
}
@end

@implementation FoodMenuViewController

- (void)setRecipeId:(NSUInteger)recipeId
{
    _recipeId = recipeId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, kSize.width, kSize.height-64);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _menuModel = [[MenuModel alloc] init];
    [_menuModel getFoodMenuWithRid:[NSString stringWithFormat:@"%ld",self.recipeId] andMenuBlock:^(BOOL isSucess, FoodMenuInfo *info) {
        if (isSucess) {
            //            _info = [info mutableCopy];
            _info = info;
            [_tableView reloadData];
            
            _mainInfo =_info.mainStuffArr[0];
            OtherStuffInfo *otherInfo = [[OtherStuffInfo alloc] init];
            otherInfo =_info.otherStuffArr[0];
            
        }
        
    }];
    
    //foot
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, 44)];
    _tableView.tableFooterView = footView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0 ) {
        return _info.mainStuffArr.count;
    }else
        if (section == 1) {
            return _info.otherStuffArr.count + 2;
        }
        else if(section == 2){
            return _info.stepsArr.count;
        }
    else if(section == 5)
    {
        return _info.commentListArr.count + 1;
    }
        else return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 ) {
        UIView *headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(0, 0, kSize.width, 400);
        //create cover ImgView
        
        UIImageView *coverImgV = [[UIImageView alloc] init];
        coverImgV = [self coverImgView];
        //
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 205, kSize.width, 30)];
        titleLab.text = _info.titleStr;
        [titleLab setFont:[UIFont systemFontOfSize:18]];
        
        //
        UIImageView *avatarImgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 235, 30, 30)];
        avatarImgV.layer.cornerRadius = 15;
        avatarImgV.layer.masksToBounds = YES;
//        [avatarImgV.layer setBorderColor:[UIColor whiteColor]];
        [avatarImgV setImageWithURL:[NSURL URLWithString:_info.avatar] placeholderImage:nil];
        //点击IMGVIEW
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarImgClick)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [avatarImgV setUserInteractionEnabled:YES];
        [avatarImgV addGestureRecognizer:tap];
        //
        UILabel *userLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 235,200, 15)];
        [userLab setFont:[UIFont systemFontOfSize:12]];
        [userLab setText:_info.userName];
        
        //
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 250, 200, 15)];
        [timeLab setFont:[UIFont systemFontOfSize:12]];
        [timeLab setText:[NSString stringWithFormat:@"原创于%@",_info.reviewTime]];
        [timeLab setTextColor:[UIColor grayColor]];
        //
        UILabel *introLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 270, kSize.width - 30, 100)];
        [introLab setNumberOfLines:0];
        [introLab setFont:[UIFont systemFontOfSize:14]];
        [introLab setText:_info.intro];
        
        UILabel *sectNameLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 380, 100, 20)];
//        [sectNameLab setFont:[UIFont systemFontOfSize:14]];
        [sectNameLab setText:@"食材" ];
        [sectNameLab setTextColor:kGreen];
        
        //MENU
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.frame = CGRectMake(kSize.width - 100 , 380, 80, 20);
        [menuBtn setTitle:@"+ 购买清单" forState:UIControlStateNormal];
        [menuBtn setTitleColor:kGreen forState:UIControlStateNormal];
        [menuBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [menuBtn.layer setCornerRadius:10];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        //102/255.0f green:153/255.0f blue:0.0f alpha:1
        CGColorRef colorRef = CGColorCreate(colorSpace,(CGFloat[]){ 102/255.0f, 153/255.0f, 0.0f, 1 });
        [menuBtn.layer setBorderColor:colorRef];
        [menuBtn.layer setBorderWidth:1.0f];
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:menuBtn];
        [headerView addSubview:sectNameLab];
        [headerView addSubview:introLab];
        [headerView addSubview:timeLab];
        [headerView addSubview:userLab];
        [headerView addSubview:avatarImgV];
        [headerView addSubview:titleLab];
        [headerView addSubview:avatarImgV];
        [headerView addSubview:coverImgV];
        return headerView;
    }else if(section == 2)
    {
        UIView *headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(15, 0, kSize.width, 44);
        UILabel *sectionLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 44)];
        [sectionLab setText:@"步骤"];
//        [sectionLab setFont:[UIFont systemFontOfSize:14]];
        [sectionLab setTextColor:kGreen];
        [headerView addSubview:sectionLab];
        return headerView;
    }
    else if(section == 3)
    {
        UIView *headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(15, 0, kSize.width, 44);
        UILabel *sectionLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 44)];
        [sectionLab setText:@"小贴士"];
        //        [sectionLab setFont:[UIFont systemFontOfSize:14]];
        [sectionLab setTextColor:kGreen];
        [headerView addSubview:sectionLab];
        return headerView;
    }
    else if(section == 4)
    {
        UIView *headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(15, 0, kSize.width, 44);
        UILabel *sectionLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 44)];
        [sectionLab setText:@"作品展示"];
        //        [sectionLab setFont:[UIFont systemFontOfSize:14]];
        [sectionLab setTextColor:kGreen];
        [headerView addSubview:sectionLab];
        return headerView;
    }
    else if(section == 5)
    {
        UIView *headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(15, 0, kSize.width, 44);
        UILabel *sectionLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 44)];
        [sectionLab setText:@"评论"];
        //        [sectionLab setFont:[UIFont systemFontOfSize:14]];
        [sectionLab setTextColor:kGreen];
        [headerView addSubview:sectionLab];
        return headerView;
    }
    else return nil;
}


- (void)avatarImgClick
{
    NSLog(@"avatarImgClick");
}

- (void)menuBtnClick:(UIButton *)btn
{
    NSLog(@"menuBtnClick");
}


//create coverImgView
- (UIImageView *)coverImgView
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, 0, kSize.width, 200);
    
    [imgView setUserInteractionEnabled:YES];
    if (_info != nil) {
        [imgView setImageWithURL:[NSURL URLWithString:_info.cover] placeholderImage:nil];
        
    }
    //给imgView添加tag手势
    
    UITapGestureRecognizer *Tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed)];
    //设置几个手指
    [Tap setNumberOfTapsRequired:1];
    [Tap setNumberOfTouchesRequired:1];
    [imgView addGestureRecognizer:Tap];
    
    UIImage *bigLabImg = [UIImage imageNamed:@"yuan_03.png"];
    UIImage *showLabImg = [UIImage imageNamed:@"yuan_06.png"];
    UIImage *likeImg = [UIImage imageNamed:@"like_show@2x.png"];
    //show whitelove
    UIImageView *bigLabView = [[UIImageView alloc] init];
    bigLabView.frame = CGRectMake(15, 0,likeImg.size.width, likeImg.size.height);
    bigLabView.center = CGPointMake((kSize.width - 30)/2.0f, 200/2.0f);
    [bigLabView setImage:likeImg];
    _bigLabView = bigLabView;
    [bigLabView setAlpha:0];
    //show whitecircleImgView
    UIImageView *likeImgView = [[UIImageView alloc] init];
    likeImgView.frame = CGRectMake(kSize.width - 80, 150, 42, 42);
    [likeImgView setImage:bigLabImg];
    //show orangelab,likeview show
    UIImageView *showLabView = [[UIImageView alloc] initWithFrame:CGRectMake(kSize.width - 50, 175, showLabImg.size.width, showLabImg.size.height)];
    [showLabView setImage:showLabImg];
    //show likeCount
    UILabel *showLab = [[UILabel alloc] init];
    showLab.frame = CGRectMake(kSize.width - 50, 180, showLabImg.size.width, 10);
    [showLab setTextAlignment:NSTextAlignmentCenter];
    showLab.font = [UIFont systemFontOfSize:8];
    [showLab setTextColor:[UIColor whiteColor]];
    
    //click likebtn
    UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnNor = [UIImage imageNamed:@"ico_orange_love.png"];
    [likeBtn setFrame:CGRectMake(kSize.width - 68, 162, 20, 20)];
    [likeBtn setImage:btnNor forState:UIControlStateNormal];
    
    [likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [imgView addSubview:bigLabView];
    [imgView addSubview:likeImgView];
    [imgView addSubview:showLabView];
    [imgView addSubview:showLab];
    [imgView addSubview:likeBtn];
    return imgView;
    
}

- (void)imagePressed
{
    NSLog(@"imagePressed");
}

//点击按钮切换是否选中状态，实现图片的放大，改变背景等功能
- (void)likeBtnClick:(UIButton *)btn
{
    NSLog(@"likeBtnClick");
    if (_isClick) {
        _isClick = NO;
        [btn setSelected:NO];
        [UIView animateWithDuration:0.5 animations:^{
            [btn setImage:[UIImage imageNamed:@"ico_orange_love.png"] forState:UIControlStateSelected];
            [btn setAlpha:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        } completion:^(BOOL finished) {
            [btn setAlpha:1];
        }];
        
    }
    else
    {
        _isClick = YES;
        [btn setSelected:YES];
        [UIView animateWithDuration:1 animations:^{
            [btn setImage:[UIImage imageNamed:@"ico_orange_love_on.png"] forState:UIControlStateSelected];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            //            _bigLabView.frame = CGRectMake(0, 0,142 * 0.8f, 122 * 0.8f);
            _bigLabView.center = CGPointMake((kSize.width - 30)/2.0f, 200/2.0f);
            
            [_bigLabView setAlpha:1.0f];
        } completion:^(BOOL finished) {
            [_bigLabView setAlpha:0];
        }];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    MainStuffInfo *mainInfo = [[MainStuffInfo alloc] init];
    OtherStuffInfo *otherInfo = [[OtherStuffInfo alloc] init];
//    StuffInfo *stuffInfo = [[StuffInfo alloc] init];
    if (indexPath.section == 0) {
        NSLog(@"indexPath%ld",indexPath.row);
        if (indexPath.row < _info.mainStuffArr.count) {
            mainInfo = _info.mainStuffArr[indexPath.row];
        }
        
        [cell.textLabel setText:mainInfo.nameStr];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        UILabel *weightLab = [[UILabel alloc] initWithFrame:CGRectMake(kSize.width / 2.0f, 0, 100, 44)];
        [weightLab setText:mainInfo.weightStr];
        [weightLab setFont:[UIFont systemFontOfSize:14]];
        [[cell contentView] addSubview:weightLab];
    }if (indexPath.section == 1) {
        if (indexPath.row < _info.otherStuffArr.count) {
            otherInfo = _info.otherStuffArr[indexPath.row];
            [cell.textLabel setText:otherInfo.nameStr];
            [cell.textLabel setTextColor:[UIColor grayColor]];
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
            UILabel *weightLab = [[UILabel alloc] initWithFrame:CGRectMake(kSize.width / 2.0f, 0, 100, 44)];
            [weightLab setText:otherInfo.weightStr];
            [weightLab setTextColor:[UIColor grayColor]];
            [weightLab setFont:[UIFont systemFontOfSize:14]];
            [[cell contentView] addSubview:weightLab];

        }
        
        
       else if (indexPath.row == _info.otherStuffArr.count) {
            [cell.textLabel setText:[NSString stringWithFormat:@"制作时间:%@",_info.cookTime]];
           [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        }
        else
        {
            [cell.textLabel setText:[NSString stringWithFormat:@"用餐人数:%@",_info.userCount]];
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        }
        
    }if (indexPath.section == 2) {
        //
        StepsInfo *stepInfo = [[StepsInfo alloc] init];
        if (indexPath.row < _info.stepsArr.count) {
            stepInfo = _info.stepsArr[indexPath.row];
        }
        static NSString *cellId = @"cell";
        
        StepTableViewCell *cellS = (StepTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        
        if (cellS == nil)
        {
            cellS = [[StepTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [cellS.imgView setImageWithURL:[NSURL URLWithString:stepInfo.stepPhoto] placeholderImage:nil];
        [cellS.numLab setText:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
        [cellS.titleLab setText:stepInfo.intro];
        cellS.tag = indexPath.row;
        return cellS;
        
    }
    if (indexPath.section == 3) {
//        cell.frame = CGRectMake(15, 0, kSize.width - 30, _heightCell);
        UILabel *txtLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, _heightCell)];
        NSLog(@"_heightCell%f",_heightCell);
        [txtLab setNumberOfLines:0];
        [txtLab setFont:[UIFont systemFontOfSize:14]];
        [txtLab setText:_info.tips];
        [[cell contentView] addSubview:txtLab];
    }
    if (indexPath.section == 4)
    {
        //
        if (_info.productArr.count > 0)
        {
            NSInteger kCount = _info.productArr.count;
            _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, 100)];
//                _scrollView.contentSize = CGSizeMake((kCount + 2) * (kSize.width - 30), 0);
                _scrollView.showsVerticalScrollIndicator = NO;
//                _scrollView.bounces = YES;
                _scrollView.showsHorizontalScrollIndicator = NO;
                _scrollView.userInteractionEnabled = YES;
                _scrollView.delegate = self;
//                _scrollView.bounces = NO;
                _scrollView.tag = 100;
        
                for (int i = 0; i < kCount; i++)
                {
                    ShowImgView *imgView = [[ShowImgView alloc] initWithFrame:CGRectMake(i * (kSize.width - 30) +kSize.width - 30, 0, (kSize.width - 30), 100)];
                    
                    [imgView setUserInteractionEnabled:YES];
                    ProductInfo *info = [[ProductInfo alloc] init];
                    info = _info.productArr[i];
                    //后面是没有加载网络图片显示的图片
                    [imgView.imgView setImageWithURL:[NSURL URLWithString:info.Img] placeholderImage:nil];
                    [imgView.userNameLab setText:info.userName];
                    [imgView.commentLab setText:info.content];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick)];
                    tap.numberOfTapsRequired = 1;
                    tap.numberOfTouchesRequired = 1;
                    [imgView addGestureRecognizer:tap];
                    [_scrollView addSubview:imgView];
                }
                //最后一张图片放在最前面0位置
                ShowImgView *imgView = [[ShowImgView alloc] initWithFrame:CGRectMake(0, 0, (kSize.width - 30), 100)];
                ProductInfo *info = [[ProductInfo alloc] init];
                info = _info.productArr[kCount -1];
                [imgView.imgView setImageWithURL:[NSURL URLWithString:info.Img] placeholderImage:nil];
                [imgView.userNameLab setText:info.userName];
                [imgView.commentLab setText:info.content];
                [_scrollView addSubview:imgView];
                // 取数组第一张图片放在最后1页
            
             ShowImgView *imgView2 = [[ShowImgView alloc] initWithFrame:CGRectMake(0, 0, (kSize.width - 30), 100)];

                imgView2.frame = CGRectMake((kCount + 1)* (kSize.width - 30), 0, kSize.width - 30, 100);
                info = _info.productArr[0];
                [imgView2.imgView setImageWithURL:[NSURL URLWithString:info.Img] placeholderImage:nil];
                [imgView2.userNameLab setText:info.userName];
                [imgView2.commentLab setText:info.content];
                [_scrollView addSubview:imgView2];
            
                _scrollView.contentSize = CGSizeMake((kCount + 2) * (kSize.width - 30), 0);

                //开启分页模式
                _scrollView.pagingEnabled = YES;
//                [_scrollView setContentOffset:CGPointMake(0, 0)];
//                [_scrollView scrollRectToVisible:CGRectMake((kSize.width - 30),0,kSize.width - 30,100) animated:NO];
        
                //添加pageController
                _pageController = [[UIPageControl alloc] init];
                _pageController.bounds = CGRectMake(0, 0, 150, 20);
                _pageController.center = CGPointMake(kSize.width * 0.5, 105);
                //        [self.view addSubview:pageController];
                //        [self.view bringSubviewToFront:pageController];
                //设置页码
                _pageController.numberOfPages = kCount;
                _pageController.currentPageIndicatorTintColor = kGreen;
            _pageController.pageIndicatorTintColor = [UIColor grayColor];
                _pageController.currentPage = 0;
                //页码改变了，调用
                [_pageController addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
        }
        [[cell contentView] addSubview:_scrollView];
        [[cell contentView] addSubview:_pageController];
        UIButton *selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectAllBtn.frame = CGRectMake(0, 110, 200, 20);
        selectAllBtn.center = CGPointMake(kSize.width / 2.0f, 130);
//        [selectAllBtn setBackgroundColor:kGreen];
        [selectAllBtn setTitle:@"查看全部9个作品" forState:UIControlStateNormal];
        [selectAllBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [selectAllBtn addTarget:self action:@selector(selectAllBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [[cell contentView] addSubview:selectAllBtn];
        
        UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        showBtn.frame = CGRectMake(0, 150, 200, 35);
        showBtn.center = CGPointMake(kSize.width / 2.0f, 170);
        [showBtn setTitle:@"晒晒我的作品" forState:UIControlStateNormal];
        [showBtn setTitleColor:kGreen forState:UIControlStateNormal];
        [showBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [showBtn.layer setCornerRadius:20];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        //102/255.0f green:153/255.0f blue:0.0f alpha:1
        CGColorRef colorRef = CGColorCreate(colorSpace,(CGFloat[]){ 102/255.0f, 153/255.0f, 0.0f, 1 });
        [showBtn.layer setBorderColor:colorRef];
        [showBtn.layer setBorderWidth:1.0f];
        [showBtn addTarget:self action:@selector(showBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:showBtn];
    }
    
    if (indexPath.section == 5) {
        //
        
        CommentListInfo *contentInfo = [[CommentListInfo alloc] init];
        if (indexPath.row < _info.commentListArr.count) {
            contentInfo = _info.commentListArr[indexPath.row];

            static NSString *cellContent = @"cellContent";
            CommentTableViewCell *cellComm = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellContent];
            if (cellComm == nil) {
                cellComm = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellContent];
            }
            else
            {
                //删除cell的所有子视图
                while ([cellComm.contentView.subviews lastObject] != nil)
                {
                    [(UIView*)[cellComm.contentView.subviews lastObject] removeFromSuperview];
                }
            }
            [cellComm.avatarImgView setImageWithURL:[NSURL URLWithString:contentInfo.avatar] placeholderImage:nil ];
            [cellComm.userNameLab setText:contentInfo.username];
            [cellComm.createTimeLab setText:contentInfo.createTime];
            if (contentInfo.content.length > 0) {
                //
                
                NSString *text = contentInfo.content;
                if (text.length >0) {
                    CGSize constraint = CGSizeMake(kSize.width - 100, 2000.0f);
                    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
                    CGSize textSize = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                    CGFloat connHeight = textSize.height;
                    
                    cellComm.contentLab.frame = CGRectMake(70, 25, kSize.width - 100, connHeight );
                    [cellComm.contentLab setNumberOfLines:0];
                    
                    NSLog(@"_connHeight%f,%ld",connHeight,indexPath.row);
                    [cellComm.contentLab setText:contentInfo.content];
//                    cellComm.contentLab.backgroundColor = [UIColor redColor];
                    
                    return cellComm;
                }
            }
        }
        else
        {
            //
            UIButton *connBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            connBtn.frame = CGRectMake(0, 10, 200, 40);
            connBtn.center = CGPointMake(kSize.width / 2.0f, 30);
            [connBtn setTitle:@"我也来说两句" forState:UIControlStateNormal];
            [connBtn setTitleColor:kGreen forState:UIControlStateNormal];
            [connBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [connBtn.layer setCornerRadius:15];
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            //102/255.0f green:153/255.0f blue:0.0f alpha:1
            CGColorRef colorRef = CGColorCreate(colorSpace,(CGFloat[]){ 102/255.0f, 153/255.0f, 0.0f, 1 });
            [connBtn.layer setBorderColor:colorRef];
            [connBtn.layer setBorderWidth:1.0f];
            [connBtn addTarget:self action:@selector(connBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:connBtn];
            return cell;
        }
    
 
    }
    return cell;
   
}

- (void)selectAllBtnClick
{
    NSLog(@"selectAllBtnClick");
}

- (void)showBtnClick:(UIButton *)btn
{
    NSLog(@"showBtnClick");
}
- (void)connBtnClick:(UIButton *)btn
{
    NSLog(@"connBtnClick");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     StepTableViewCell *cell = (StepTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section ==2) {
       
        
        StepImgViewController *stepVC = [[StepImgViewController alloc] init];
        stepVC.stepArray = _info.stepsArr;
        stepVC.index = cell.tag;
        [self presentViewController:stepVC animated:YES completion:nil];
        
        
    }
}

- (void)turnPage
{
    NSInteger page = _pageController.currentPage; // 获取当前的page

//    [_scrollView setContentOffset:CGPointMake((_scrollView.frame.size.width)*(page), kWidth - 30) animated:NO];

    [_scrollView setContentOffset:CGPointMake((_scrollView.frame.size.width)*(page),0)]; // 触摸pagecontroller那个点点 往后翻一页 +1
}

//#pragma mark - 设置scroll的代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //UITableView也是基于scrollciew的，所有最好要设置一个tag
    int currentPage= (int)scrollView.contentOffset.x/(kSize.width - 30); // 和上面两行效果一样
        NSLog(@"currentPage==%d",currentPage);
    if (scrollView.tag == 100) {
        
    
    if (currentPage == 0)
    {
        [_scrollView setContentOffset:CGPointMake((kSize.width - 30) * ([_info.productArr count]),0) ]; // 序号0 最后1页
    }
    else if (currentPage == [_info.productArr count] )
    {
        [_scrollView setContentOffset:CGPointMake(0,0)]; // 最后+1,循环第1页
    }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 400;

    }
    if (section == 1) {
        return 0;
    }
    else
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 80;
    }
    else if(indexPath.section == 3)
    {
    
        NSString *text = _info.tips;
        if (text.length >0) {
            CGSize constraint = CGSizeMake(kSize.width - 30, 2000.0f);
            NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
            CGSize textSize = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            _heightCell = textSize.height;
            
        }
        
        return _heightCell + 20 ;
    }else if(indexPath.section == 4)
    {
        return 200;
    }
    else if(indexPath.section == 5)
    {
       CommentListInfo *infoCom = [[CommentListInfo alloc] init];
        
        
            //
        if (indexPath.row < _info.commentListArr.count) {
            infoCom = _info.commentListArr[indexPath.row];
            if (infoCom.content.length > 0) {
                NSString *text = infoCom.content;
                
                CGSize constraint = CGSizeMake(kSize.width - 100, 2000.0f);
                NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
                CGSize textSize = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
                _connHeight = textSize.height;
                NSLog(@"magi%f",_connHeight);
            }
            if (_connHeight + 25 > 60) {
                return _connHeight + 25;
            }
            else
                return 60;
        }
        
        else
            return 60;
    }
    
    else
        return 44;
}

//去掉UItableview headerview黏性(sticky)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 400; //section的高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
    CGFloat pagewidth = _scrollView.frame.size.width;
//    int page = floor((_scrollView.contentOffset.x - pagewidth/([_info.productArr count]+ 0))/pagewidth)+1;
//    page --;  // 默认从第二页开始
    int page = floor(_scrollView.contentOffset.x/pagewidth);
    _pageController.currentPage = page;
}

- (void)imgClick
{
    NSLog(@"imgClick");
}

@end
