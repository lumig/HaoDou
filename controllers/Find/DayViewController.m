//
//  DayViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-11.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "DayViewController.h"
#import "DayInfo.h"
#import "FindModel.h"
#import "InInfo.h"
#import "resultInfo.h"
#import "listInfo.h"
#import "contentInfo.h"
#import "DaySectionView.h"
#import "UIImageView+AFNetworking.h"

@interface DayViewController ()

@property(nonatomic,strong)FindModel *findModel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation DayViewController

- (void)viewDidAppear:(BOOL)animated
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _findModel = [[FindModel alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSize.width , kSize.height - 50)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_findModel dayDataWithId:@"3" andLimit:@"10" andOffset:@"0" andPid:@"1704305" andSign:@"" andSort:@"1704305" andType:@"1" andUid:@"" andUuid:@"17EF523E05B42597F70A95681590F28B" andFindBlock:^(BOOL isSucess, NSMutableArray *dataArray) {
        //
        if (isSucess) {
            _dataArr = [dataArray mutableCopy];
            [_tableView reloadData];
            
            listInfo *info = [[listInfo alloc] init];
            info = _dataArr[11];
            contentInfo *connInfo = [[contentInfo alloc] init];
            NSArray *arr = [NSArray array];
            arr = info.comment;
            
            if (arr.count > 0) {
                connInfo = arr[0];
            }
            NSLog(@"dataArr%@,%@,%@,%@",_dataArr[0], info,info.titleStr,info.rTitle);
            //
            [self addTableHeaderView];

            
        }
    }];
    
    //add tableHeaderView
    

    
   
    //add
    
    
}

- (void)addTableHeaderView
{

    UIView *tblHeaderView = [[UIView alloc] init];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 150, 44)];
    titleLabel.center = CGPointMake(kSize.width / 2.0f, 32);
    titleLabel.text = self.titleString;
    titleLabel.font = [UIFont systemFontOfSize: 18];
    [tblHeaderView addSubview:titleLabel];
    
    UILabel *prodLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    prodLabel.center = CGPointMake((kSize.width- 30)/2.0f, 55);
    prodLabel.font = [UIFont systemFontOfSize:14];
    [prodLabel setTextAlignment:NSTextAlignmentCenter];
    prodLabel.textColor = [UIColor grayColor];
    if (_dataArr[0] != nil) {
        prodLabel.text = [NSString stringWithFormat:@"%@作品",[NSString stringWithFormat:@"%@",_dataArr[0]]];

    }
    [tblHeaderView addSubview:prodLabel];
    
    InInfo *info1 = [[InInfo alloc] init];
    
    info1 = _dataArr[1];
    if (info1 != nil) {
        UIImageView *coverImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
        coverImgView.center = CGPointMake((kSize.width - 30)/2.0f, 55);
        [coverImgView setImageWithURL:[NSURL URLWithString:info1.cover] placeholderImage:nil];
        
        [tblHeaderView addSubview:coverImgView];
        NSString *introString = info1.content;
        if (info1.content.length > 0) {
            CGSize constraint = CGSizeMake(kSize.width - 30, 2000.0f);
            NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:introString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
            CGSize introSize = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
            UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, kSize.width - 30, introSize.height)];
            contentLabel.font = [UIFont systemFontOfSize:12];
            [contentLabel setTextColor:[UIColor blackColor]];
            [contentLabel setText:introString];
            [tblHeaderView addSubview:contentLabel];
            tblHeaderView.frame = CGRectMake(0, 0, kSize.width - 30, 80 + introSize.height);
    }
        
    }
    
    else
    {
        tblHeaderView.frame = CGRectMake(0, 0, kSize.width - 30, 80 );
    }
    _tableView.tableHeaderView = tblHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _dataArr.count -2;
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count ;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *dayCellID = @"dayCellID";
    DayCell *cell = (DayCell *)[tableView cellForRowAtIndexPath:indexPath];
//    DayCell *cell = [tableView dequeueReusableCellWithIdentifier:dayCellID];
    if (cell == nil) {
        //
        cell = [[DayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dayCellID];
    }
    static int i = 2;
    listInfo *info = [[listInfo alloc] init];
    
    if (i < _dataArr.count - 2) {
        info = _dataArr[i];
        i++;
    }
    [cell cellForFillListInfo:info];

    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    listInfo *info = [[listInfo alloc] init];
    static int i = 2;
    if (i < _dataArr.count) {
        info = _dataArr[i];

    }
    i ++;
    CGFloat height = [DayCell heightForCommentInfo:info];
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DaySectionView *headerView = [[DaySectionView alloc] init];
    listInfo *info = [[listInfo alloc] init];
    if (section > _dataArr.count - 3) {
        return nil;
    }
    info = _dataArr[section + 2];
    if (info != nil) {
        [headerView daySectionFillInfo:info];

    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}



//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 44; //section的高度
//    if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)DayCellDidClicked:(NSInteger)index
{
    NSLog(@"DayCellDidClicked%ld",index);
}

- (void)dayCellBtnDidClicked:(NSUInteger)index
{
    NSLog(@"DayCellDidClicked%ld",index);

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
