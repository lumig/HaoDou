//
//  FindViewController.m
//  HaoDou
//
//  Created by Lu Ming on 14-12-23.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import "FindViewController.h"
#import "FindModel.h"
#import "DayInfo.h"
#import "ActInfo.h"
#import "LearnInfo.h"
#import "CateInfo.h"
#import "FindUserInfo.h"
#import "DayTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "LearnTableViewCell.h"
#import "CateOneTableViewCell.h"
#import "CateTwoTableViewCell.h"
#import "DayViewController.h"
#import "DayView.h"
@interface FindViewController ()
@property(nonatomic,strong)FindModel *findModel;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, kSize.height - 44)];
    
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //
    _findModel = [[FindModel alloc] init];
    [_findModel getFindDataWithCacheKey:@"Recipe.getFindRecipe" andSign:@"" andUid:@"" andUuid:@"17EF523E05B42597F70A95681590F28B" andFindBlock:^(BOOL isSucess, NSMutableArray *dataArray) {
        if (isSucess) {
            _dataArr = [dataArray mutableCopy];
//            DayInfo *info = [[DayInfo alloc] init];
//            NSArray *arr = _dataArr[0];
//            info = arr[2];
//            NSLog(@"magi%@,%@",_dataArr, info.themeTitle);
//            NSLog(@"magi%@",_dataArr);
            
            [_tableView reloadData];
        }
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString *cellID = @"cell";
        DayTableViewCell *cell = (DayTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        static NSString *cellLearn = @"cellLearn";
    LearnTableViewCell *celllearn = (LearnTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellLearn];
    static NSString *cellCateId1 = @"cellcate1";
    static NSString *cellCateID2 = @"cellcate2";
    CateOneTableViewCell *celcate1= (CateOneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellCateId1];
    CateTwoTableViewCell *cellcate2 =(CateTwoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellCateID2];
    
        if (cell == nil) {
            cell = [[DayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
    if (indexPath.section == 0) {
        NSArray *arr = [NSArray array];
        if (_dataArr.count > 0) {
            arr = _dataArr[0];
//            NSLog(@"magiarr%@",arr);
            DayInfo *lunchInfo = [[DayInfo alloc] init];
            lunchInfo = arr[0];
            /// Format string is not a string literal (potentially insecure)
            [cell.lunchDView.themeCoverImgView setImageWithURL:[NSURL URLWithString:lunchInfo.themeCover] placeholderImage:nil];
            [cell.lunchDView.themeTitleLab setText:lunchInfo.themeTitle];
            [cell.lunchDView.photoCountLab setText:[NSString stringWithFormat:@"%@作品",lunchInfo.photoCount]];
            cell.lunchDView.tag = 11;
//            NSLog(@"magi%@",lunchInfo.photoCount );
            
            DayInfo *breakfastInfo = [[DayInfo alloc] init];
            breakfastInfo = arr[2];
            
            [cell.breakfastDView.themeCoverImgView setImageWithURL:[NSURL URLWithString:breakfastInfo.themeCover] placeholderImage:nil];
            [cell.breakfastDView.themeTitleLab setText:breakfastInfo.themeTitle];
            [cell.breakfastDView.photoCountLab setText:[NSString stringWithFormat:@"%@作品",breakfastInfo.photoCount]];
            cell.breakfastDView.tag = 22;
            DayInfo *supperInfo = [[DayInfo alloc] init];
            supperInfo = arr[1];
            
            [cell.supperDView.themeCoverImgView setImageWithURL:[NSURL URLWithString:supperInfo.themeCover] placeholderImage:nil];
            [cell.supperDView.themeTitleLab setText:supperInfo.themeTitle];
            [cell.supperDView.photoCountLab setText:[NSString stringWithFormat:@"%@作品",supperInfo.photoCount]];
            cell.supperDView.tag = 33;
            //
            cell.delegate = self;
            return cell;
        }
        
    }
    if (indexPath.section == 1) {
        //
        UITableViewCell *cell1 = [[UITableViewCell alloc] init];
        ActInfo *info = [[ActInfo alloc] init];
        info = _dataArr[1];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, kSize.width - 30, 90)];
        [imgView setImageWithURL:[NSURL URLWithString:info.actImg] placeholderImage:nil];
        [cell1.contentView addSubview:imgView];
        return cell1;
    }
    
    if (indexPath.section == 2) {
        //
        if (celllearn == nil) {
            celllearn = [[LearnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellLearn];
        }
        LearnInfo *info = [[LearnInfo alloc] init];
        info = _dataArr[2];
        [celllearn.recipeCoverImgView setImageWithURL:[NSURL URLWithString:info.recipeCover] placeholderImage:nil];
        [celllearn.userAvaterImgView setImageWithURL:[NSURL URLWithString:info.userAvater] placeholderImage:nil];
        [celllearn.introLab setText:info.intro];
        [celllearn.userNameLab setText:info.userName];
        NSArray *arr = info.list;
        for (int i = 0; i < arr.count; i++) {
            //
            UIImageView *imgView = [[UIImageView alloc] init];
            imgView.frame = CGRectMake(i * (kSize.width - 30) / 4.0f, 0, (kSize.width - 30) / 4.0f, (kSize.width - 30) / 4.0f);
            [imgView setImageWithURL:[NSURL URLWithString:arr[i]] placeholderImage:nil];
            [celllearn.listImgView addSubview:imgView];
        }
        
        return celllearn;
        
    }
    if (indexPath.section == 3) {
        //
        UITableViewCell *cell2 = [[UITableViewCell alloc] init];
        ActInfo *info = [[ActInfo alloc] init];
        info = _dataArr[3];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, kSize.width - 30, 90)];
        [imgView setImageWithURL:[NSURL URLWithString:info.actImg] placeholderImage:nil];
        [cell2.contentView addSubview:imgView];
        return cell2;
    }
    
    if (indexPath.section == 4) {
        if (celcate1 == nil) {
            celcate1 = [[CateOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellCateId1];
        }
        CateInfo *info1 = [[CateInfo alloc] init];
        CateInfo *info2 = [[CateInfo alloc] init];
        CateInfo *info3 = [[CateInfo alloc] init];
        CateInfo *info4 = [[CateInfo alloc] init];

        NSArray *arr = _dataArr[4];
        info1 = arr[0];
        info2 = arr[1];
        info3 = arr[2];
        info4 = arr[3];
        
        NSLog(@"info1.cover = %@",info1.cover);
        
        [celcate1.cateOneImgView.coverImgView setImageWithURL:[NSURL URLWithString:info1.cover] placeholderImage:[UIImage imageNamed:@"1111.jpg"]];
        
        [celcate1.cateOneImgView.countLab setText:[NSString stringWithFormat:@"%@个赞",info1.count]];
//        NSLog(@"countinfo%@%@,%@,%@",celcate1.cateOneImgView.coverImgView.image,info1.cover,info1.count,info1.userName);
        [celcate1.cateOneImgView.userNameLab setText:[NSString stringWithFormat:@"by %@",info1.userName]];
        celcate1.cateOneImgView.tag =1;
        
        [celcate1.cateTwoImgView.coverImgView setImageWithURL:[NSURL URLWithString:info2.cover] placeholderImage:nil];
        [celcate1.cateTwoImgView.countLab setText:[NSString stringWithFormat:@"%@个赞",info2.count]];
        [celcate1.cateTwoImgView.userNameLab setText:[NSString stringWithFormat:@"by %@",info2.userName]];
        celcate1.cateTwoImgView.tag =2;
        
        [celcate1.cateThreeImgView.coverImgView setImageWithURL:[NSURL URLWithString:info3.cover] placeholderImage:nil];
        [celcate1.cateThreeImgView.countLab setText:[NSString stringWithFormat:@"%@个赞",info3.count]];
        [celcate1.cateThreeImgView.userNameLab setText:[NSString stringWithFormat:@"by %@",info3.userName]];
        celcate1.cateThreeImgView.tag =3;
        
        [celcate1.cateFourImgView.coverImgView setImageWithURL:[NSURL URLWithString:info4.cover] placeholderImage:nil];
        [celcate1.cateFourImgView.countLab setText:[NSString stringWithFormat:@"%@个赞",info4.count]];
        [celcate1.cateFourImgView.userNameLab setText:[NSString stringWithFormat:@"by %@",info4.userName]];
        celcate1.cateFourImgView.tag =4;
        //
        celcate1.delegate = self;
        return celcate1;
    }
    if (indexPath.section == 5) {
        if (cellcate2 == nil) {
            cellcate2 = [[CateTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellCateID2];
        }
        CateInfo *info1 = [[CateInfo alloc] init];
        CateInfo *info2 = [[CateInfo alloc] init];
        CateInfo *info3 = [[CateInfo alloc] init];
        CateInfo *info4 = [[CateInfo alloc] init];
        
        NSArray *arr = _dataArr[5];
        info1 = arr[0];
        info2 = arr[1];
        info3 = arr[2];
        info4 = arr[3];
        
        NSLog(@"info1.cover = %@",info1.cover);
        
        [cellcate2.cateOneImgView.coverImgView setImageWithURL:[NSURL URLWithString:info1.cover] placeholderImage:[UIImage imageNamed:@"1111.jpg"]];
        
        [cellcate2.cateOneImgView.countLab setText:[NSString stringWithFormat:@"%@个赞",info1.count]];
        //        NSLog(@"countinfo%@%@,%@,%@",celcate1.cateOneImgView.coverImgView.image,info1.cover,info1.count,info1.userName);
        [cellcate2.cateOneImgView.userNameLab setText:[NSString stringWithFormat:@"by %@",info1.userName]];
        cellcate2.cateOneImgView.tag =1;
        
        [cellcate2.cateTwoImgView.coverImgView setImageWithURL:[NSURL URLWithString:info2.cover] placeholderImage:nil];
        [cellcate2.cateTwoImgView.countLab setText:[NSString stringWithFormat:@"%@个赞",info2.count]];
        [cellcate2.cateTwoImgView.userNameLab setText:[NSString stringWithFormat:@"by %@",info2.userName]];
        cellcate2.cateTwoImgView.tag =2;
        
        [cellcate2.cateThreeImgView.coverImgView setImageWithURL:[NSURL URLWithString:info3.cover] placeholderImage:nil];
        [cellcate2.cateThreeImgView.countLab setText:[NSString stringWithFormat:@"%@个赞",[NSString stringWithFormat:@"by %@",info3.userName]]];
        [cellcate2.cateThreeImgView.userNameLab setText:info3.userName];
        cellcate2.cateThreeImgView.tag =3;
        
        [cellcate2.cateFourImgView.coverImgView setImageWithURL:[NSURL URLWithString:info4.cover] placeholderImage:nil];
        [cellcate2.cateFourImgView.countLab setText:[NSString stringWithFormat:@"%@个赞",info4.count]];
        [cellcate2.cateFourImgView.userNameLab setText:[NSString stringWithFormat:@"by %@",info4.userName]];
        cellcate2.cateFourImgView.tag =4;
        //
        cellcate2.delegate = self;
        return cellcate2;
    }

    
    if (indexPath.section == 6) {
        //b 
    }

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return kSize.width * 0.55;
    }
    else if(indexPath.section == 1)
    {
        return 100;
    }
    else if(indexPath.section == 2)
    {
        return 200;
    }
    else if(indexPath.section == 3)
    {
        return 100;
    }
    else if(indexPath.section == 4 || indexPath.section == 5)
    {
        return 300;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, 44)];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kSize.width - 30, 20)];
        [titleLab setText:@"新手课堂（视频）"];
        [titleLab setFont:[UIFont systemFontOfSize:14]];
        [titleLab setTextColor:kGreen];
        
        [headView addSubview:titleLab];
        return headView;
    }
    else if(section == 4)
    {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, 44)];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kSize.width - 30, 20)];
        [titleLab setText:@"晒作品送爸爸2电影票"];
        [titleLab setFont:[UIFont systemFontOfSize:14]];
        [titleLab setTextColor:kGreen];
        
        [headView addSubview:titleLab];
        return headView;

    }
    else if(section == 5)
    {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, 44)];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kSize.width - 30, 20)];
        [titleLab setText:@"随手晒晒"];
        [titleLab setFont:[UIFont systemFontOfSize:14]];
        [titleLab setTextColor:kGreen];
        
        [headView addSubview:titleLab];
        return headView;
        
    }
    else if(section == 6)
    {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, 44)];
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kSize.width - 30, 20)];
        [titleLab setText:@"他的作品很被赞"];
        [titleLab setFont:[UIFont systemFontOfSize:14]];
        [titleLab setTextColor:kGreen];
        
        [headView addSubview:titleLab];
        return headView;
        
    }
    else
        return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0 || section == 2|| section == 4 || section == 5|| section == 6)
    {
        return 44;
        
    }
    
        return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (void)DayTableViewCellDidClicked:(NSInteger)index
{
    //
    DayView *view = [self.view viewWithTag:index];
    DayViewController *dayVC = [[DayViewController alloc] init];
    dayVC.titleString = view.themeTitleLab.text;
    [self.navigationController pushViewController:dayVC animated:YES];
}

- (void)CateOneTableViewCellDidClicked:(NSInteger)index
{
    NSLog(@"CateOneTableViewCellDidClicked%ld",index);

}

- (void)CateTwoTableViewCellDidClicked:(NSInteger)index
{
    NSLog(@"CateTwoTableViewCellDidClicked%ld",index);

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 44; //section的高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
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
