//
//  TagViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-7.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "TagViewController.h"
#import "HomeModel.h"
#import "HotTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "FoodMenuViewController.h"

@interface TagViewController ()
{
    HomeModel *_homeModel;
    NSArray *_tagDataArray;
    UITableView *_tableView;
}
@end

@implementation TagViewController

//初始化传值
- (id)initWithTag:(NSUInteger)tageID
{
    self = [super init];
    
    if (self) {
        self.tagId = tageID;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏tabBar
    self.tabBarController.tabBar.hidden = YES;
   
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.navigationController.navigationBar.tintColor = kGreen ;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
   
    
    
    _homeModel = [[HomeModel alloc] init];
    if (self.tagId != 0) {
        [_homeModel getTagDataWithLimit:@"20" andOffset:@"0" andScene:@"t2" andSign:@"33e3696577645da906cd6a378119b243" andTagid:[NSString stringWithFormat:@"%d",(int)self.tagId] andUid:@"6832623" andUuid:@"17EF523E05B42597F70A95681590F28B" TagBlock:^(BOOL isSucess, NSMutableArray *dataDic) {
            
            NSLog(@"tagid%ld",self.tagId);
            if (isSucess) {
                _tagDataArray = [dataDic mutableCopy];
                [_tableView reloadData];
            }
            
        }];
    }
   else
   {
       [_homeModel getBtnDetailWithKeyWord:self.title andHomeBlock:^(BOOL isSucess, NSMutableArray *dataDic) {
           if (isSucess) {
               _tagDataArray = [dataDic mutableCopy];
               [_tableView reloadData];
           }
       }];
   }
    
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 0;
    return _tagDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    HotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    HomeInfo *info = [[HomeInfo alloc] init];
    info = _tagDataArray[indexPath.row];
    [cell.coverImgView setImageWithURL:[NSURL URLWithString:info.cover] placeholderImage:nil];
    cell.tag = [info.recipeId integerValue];
    [cell.titleLabel setText:info.title];
    [cell.introLabel setText:info.stuff];
    //注意这里是解决这个问题的 __NSCFNumber rangeOfCharacterFromSet:]:
    [cell.likeCountLabel setText:[NSString stringWithFormat:@"%@    %@",info.likeCount,@"喜欢"]];
    [cell.viewCountLabel setText:[NSString stringWithFormat:@"%@    %@",info.viewCount,@"浏览"]];
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotTableViewCell *cell = (HotTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
    FoodMenuViewController *foodMenuVC = [[FoodMenuViewController alloc] init];
    //    foodMenuVC.recipeId = [NSString stringWithFormat:@"ld",cell.tag];
    foodMenuVC.recipeId = cell.tag;
    [self.navigationController pushViewController:foodMenuVC animated:NO];
    
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
