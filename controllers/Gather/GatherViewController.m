//
//  GatherViewController.m
//  HaoDou
//
//  Created by Lu Ming on 14-12-23.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import "GatherViewController.h"
#import "LoginTableViewController.h"

@interface GatherViewController ()
{
    UITableView *_tableView;
    //标志使用哪个tableview
    int _isTblFlag;
}
@end

@implementation GatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isTblFlag = 0;
    [self setTitle:@"我的"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, kSize.height)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isTblFlag == 0) {
        return 3;
    }else
    {
        return 5;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isTblFlag == 0) {
        if (section == 1) {
            return 2;
        }
        else
        {
            return 1;
        }
    }else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    //
    if (_isTblFlag == 0) {
        if (indexPath.section == 0) {
            //
            UILabel *txtLab = [[UILabel alloc] init];
            txtLab.frame = CGRectMake(0, 80, 200, 60);
            txtLab.center = CGPointMake(kSize.width / 2.0f, 60);
            txtLab.numberOfLines = 0;
            txtLab.font = [UIFont systemFontOfSize:12];
            [txtLab setTextAlignment:NSTextAlignmentCenter];
            txtLab.text = @"登录后，你可以：\n签到领逗比，可以换厨房用具；\n秀厨艺，与美食达人共同成长；\n收藏美食菜谱，营养知识。";
            
            UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            loginBtn.frame = CGRectMake(0, 100, 200, 30);
            loginBtn.center = CGPointMake(kSize.width / 2.0f, 120);
            [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
            [loginBtn setTitleColor:kGreen forState:UIControlStateNormal];
            [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [loginBtn.layer setCornerRadius:5];
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            //102/255.0f green:153/255.0f blue:0.0f alpha:1
            CGColorRef colorRef = CGColorCreate(colorSpace,(CGFloat[]){ 102/255.0f, 153/255.0f, 0.0f, 1 });
            [loginBtn.layer setBorderColor:colorRef];
            [loginBtn.layer setBorderWidth:1.0f];
            [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:txtLab];
            [cell addSubview:loginBtn];
            
        }
        if (indexPath.section == 1) {
            //
            NSArray *array = @[@{@"img":@"ico_cnleft_download.png",@"title":@"本地下载"},@{@"img":@"ico_cnleft_list.png",@"title":@"购买清单"}];
            NSDictionary *dict = array[indexPath.row];
            
            [cell.imageView setImage:[UIImage imageNamed:[dict objectForKey:@"img"]]];
            [cell.textLabel setText:[dict objectForKey:@"title"]];
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        else if(indexPath.section == 2)
        {
            [cell.imageView setImage:[UIImage imageNamed:@"ico_cnleft_setting.png"]];
            [cell.textLabel setText:@"设置"];
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }
    else
    {
        
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isTblFlag == 0) {
        if (indexPath.section == 0) {
            return 180;
        }
        else
            return 44;
    }
    else
        return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)loginBtnClick:(UIButton *)btn
{
    NSLog(@"loginBtnClick");
//    _isTblFlag = 1;
    LoginTableViewController *loginVC = [[LoginTableViewController alloc] init];

    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    
    [self presentViewController:nav animated:YES completion:nil];
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
