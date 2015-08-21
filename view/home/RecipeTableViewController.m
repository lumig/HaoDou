//
//  RecipeTableViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-17.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "HomeModel.h"
#import "ListBtnTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "FoodMenuViewController.h"
#import "TagViewController.h"

#define kSize [UIScreen mainScreen].bounds.size

@interface RecipeTableViewController ()
{
    HomeModel *_homeModel;
    NSMutableArray *_dataArray;
    UITableView *_tableView;
    NSMutableArray *_listArray;
    NSMutableDictionary *_dict;
    NSArray *_afnArr;
    float _btnWidth;
}
@end

@implementation RecipeTableViewController

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
    
    _afnArr = @[@{@"Title":@"%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1",@"limit":@"15",@"offset":@"0",@"rid":@"826103",@"sign":@"33e3696577645da906cd6a378119b243",@"type":@"%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1",@"uid":@"6832623",@"uuid":@"17EF523E05B42597F70A95681590F28B"},@{@"Title":@"%E7%A7%81%E4%BA%BA%E5%AE%9A%E5%88%B6",@"limit":@"15",@"offset":@"0",@"rid":@"373606",@"sign":@"33e3696577645da906cd6a378119b243",@"type":@"%E7%A7%81%E4%BA%BA%E5%AE%9A%E5%88%B6",@"uid":@"6832623",@"uuid":@"17EF523E05B42597F70A95681590F28B"},@{@"Title":@"%E6%97%B6%E4%BB%A4%E4%BD%B3%E8%82%B4",@"limit":@"15",@"offset":@"0",@"rid":@"430459",@"sign":@"33e3696577645da906cd6a378119b243",@"type":@"%E6%97%B6%E4%BB%A4%E4%BD%B3%E8%82%B4",@"uid":@"6832623",@"uuid":@"17EF523E05B42597F70A95681590F28B"},@{@"Title":@"%E8%BE%BE%E4%BA%BA%E8%8F%9C%E8%B0%B1",@"limit":@"15",@"offset":@"0",@"rid":@"836922",@"sign":@"33e3696577645da906cd6a378119b243",@"type":@"%E8%BE%BE%E4%BA%BA%E8%8F%9C%E8%B0%B1",@"uid":@"6832623",@"uuid":@"17EF523E05B42597F70A95681590F28B"},@{@"Title":@"%E6%9C%80%E6%96%B0%E8%8F%9C%E8%B0%B1",@"limit":@"15",@"offset":@"0",@"rid":@"834919",@"sign":@"33e3696577645da906cd6a378119b243",@"type":@"%E6%9C%80%E6%96%B0%E8%8F%9C%E8%B0%B1",@"uid":@"6832623",@"uuid":@"17EF523E05B42597F70A95681590F28B"},@{@"Title":@"%E5%BF%AB%E4%B9%90%E7%9A%84%E7%83%98%E7%84%99",@"limit":@"15",@"offset":@"0",@"rid":@"195703",@"sign":@"33e3696577645da906cd6a378119b243",@"type":@"%E5%BF%AB%E4%B9%90%E7%9A%84%E7%83%98%E7%84%99",@"uid":@"6832623",@"uuid":@"17EF523E05B42597F70A95681590F28B"}];
    _dict = _afnArr[self.index];
    
    [_homeModel getTitleWithTitle:[_dict objectForKey:@"Title"]  andLimit:[_dict objectForKey:@"limit"] andOffset:[_dict objectForKey:@"offset"] andRid:[_dict objectForKey:@"rid"] andSign:[_dict objectForKey:@"sign"] andType:[_dict objectForKey:@"type"] andUid:[_dict objectForKey:@"uid"] andUuid:[_dict objectForKey:@"uuid"] andTitleBlock:^(BOOL isSucess, NSMutableArray *dataArr) {
        if (isSucess) {
            _dataArray = [dataArr mutableCopy];
            [_tableView reloadData];
        }
        
    }];
    
    
//    //Title=%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1&limit=15&offset=0&rid=776845&sign=&type=%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1&uid=&uuid=17EF523E05B42597F70A95681590F28B
//    [_homeModel getTitleWithTitle:@"%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1"  andLimit:@"15" andOffset:@"0" andRid:@"776845" andSign:@"" andType:@"%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1" andUid:@"" andUuid:@"17EF523E05B42597F70A95681590F28B" andTitleBlock:^(BOOL isSucess, NSMutableArray *dataArr) {
//        if (isSucess) {
//            _dataArray = [dataArr mutableCopy];
//            [_tableView reloadData];
//        }
//        
//    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 15;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
//    ListBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    ListBtnTableViewCell *cell = (ListBtnTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];//利用准确取出结局复用导致的残留属性
    if (cell == nil) {
        cell = [[ListBtnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //
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
    [cell.userNameLab setText:[NSString stringWithFormat:@"by  %@",info.userName]];
    //
    cell.tag = [info.recipeId integerValue];
    [UIView beginAnimations:nil context:nil];
    if (cell.likeBtn.isSelected == YES)
    {
        if ([info.likeCount integerValue] >= 999) {
            [cell.showLab setText:@"999+"];
        }else
            [cell.showLab setText:[NSString stringWithFormat:@"%ld",([info.likeCount integerValue] + 1)]];
        
        
    }else
    {
        if ([info.likeCount integerValue] >= 999) {
            [cell.showLab setText:@"999+"];
        }else
            [cell.showLab setText:[NSString stringWithFormat:@"%ld",[info.likeCount integerValue]]];
    }
    [UIView commitAnimations];
    NSArray *btnArr = info.tags;
    
    //创建按钮
    for (int i = 0; i < btnArr.count; i++) {
        //获取name
        
        NSString *name = [btnArr[i] objectForKey:@"Name"];
        NSString *idStr = [btnArr[i] objectForKey:@"Id"];
        if (name.length > 0) {
//            NSLog(@"lumig%@",name);
            CGSize titleSize = [name sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            btn.tag = [idStr integerValue];
//        NSLog(@"magi%f",titleSize.width);
            if (i == 0) {
                
                [btn setFrame:CGRectMake( 35 , 205, titleSize.width, 20)];
                [btn setTitle:name forState:UIControlStateNormal];
                [[cell contentView] addSubview:btn];
                _btnWidth = btn.frame.origin.x + btn.frame.size.width;
            }else if(i < 6)
            {
                [btn setFrame:CGRectMake(  _btnWidth + 20, 205, titleSize.width , 20)];
                [btn setTitle:name forState:UIControlStateNormal];
                _btnWidth = btn.frame.origin.x + btn.frame.size.width;
                [[cell contentView] addSubview:btn];
            }
            else
            {
                break;
            };
//        NSLog(@"magii%d",i);
       
        }
    }
    
    
    return cell;
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListBtnTableViewCell *cell = (ListBtnTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    
    FoodMenuViewController *foodMenuVC = [[FoodMenuViewController alloc] init];
    foodMenuVC.recipeId = cell.tag;
    [self.navigationController pushViewController:foodMenuVC animated:NO];
    
}

- (void)btnClick:(UIButton *)btn
{
    NSLog(@"btnClick:");
    //btn

    TagViewController *keyTagVC = [[TagViewController alloc] init];
    keyTagVC.title = btn.titleLabel.text;
    [self.navigationController pushViewController:keyTagVC animated:YES];

}


@end
