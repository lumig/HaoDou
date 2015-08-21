//
//  LoginTableViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-20.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "LoginTableViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboApi.h"
#import "WeiboApiObject.h"
#import "WeiboSDK.h"
#import "RegisterViewController.h"

@interface LoginTableViewController ()
{
}
@end

@implementation LoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    UIImageView *nameImgV = [[UIImageView alloc] init];
    UIImage *nameImg = [UIImage imageNamed:@"ico_reg_user.png"];
    [nameImgV setImage:nameImg];
    nameImgV.frame = CGRectMake(30, 25, nameImg.size.width, nameImg.size.height);
    [self.view addSubview:nameImgV];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 30);
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:kGreen forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    //
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 30);
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn setTitleColor:kGreen forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    UITextField *nameText = [[UITextField alloc] init];
    nameText.frame = CGRectMake(60, 20, kSize.width - 60, 30);
    nameText.placeholder = @"请输入邮箱账号或手机号码";
    [self.view addSubview:nameText];
    
    UIImageView *passwordImgV = [[UIImageView alloc] init];
    UIImage *passwdImg = [UIImage imageNamed:@"ico_reg_password.png"];
    [passwordImgV setImage:passwdImg];
    passwordImgV.frame = CGRectMake(30, 75, passwdImg.size.width, passwdImg.size.height);
    [self.view addSubview:passwordImgV];
    
    UITextField *passwdText = [[UITextField alloc] init];
    passwdText.frame = CGRectMake(60, 70, kSize.width - 60, 30);
    passwdText.placeholder = @"请输入密码";
    [self.view addSubview:passwdText];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(0, 0, 200, 35);
    loginBtn.center = CGPointMake(kSize.width / 2.0f, 150);
    [loginBtn setTitle:@"登录好豆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:kGreen forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [loginBtn.layer setCornerRadius:5];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //102/255.0f green:153/255.0f blue:0.0f alpha:1
    CGColorRef colorRef = CGColorCreate(colorSpace,(CGFloat[]){ 102/255.0f, 153/255.0f, 0.0f, 1 });
    [loginBtn.layer setBorderColor:colorRef];
    [loginBtn.layer setBorderWidth:1.0f];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UILabel *showLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    showLab.center = CGPointMake(kSize.width / 2.0f, 190);
    [showLab setText:@"忘记密码？"];
    [showLab setTextColor:kGreen];
    [showLab setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:showLab];
    
    //
    UILabel *shareLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    shareLab.center = CGPointMake(kSize.width / 2.0f, 240);
    [shareLab setText:@"或使用第三方登录"];
    [shareLab setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:shareLab];
    
    //qq
    UIImage *qqImg = [UIImage imageNamed:@"bgico_tencentqq.png"];
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqBtn.frame = CGRectMake(100, 270, qqImg.size.width, qqImg.size.height+ 20);
    [qqBtn setImage:qqImg forState:UIControlStateNormal];
    [qqBtn setTitle:@"QQ" forState:UIControlStateNormal];
    [qqBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [qqBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [qqBtn addTarget:self action:@selector(qqclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];
    
    //weibo   bgico_microblog.png
    UIImage *winboImg = [UIImage imageNamed:@"bgico_microblog.png"];
    UIButton *winboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    winboBtn.frame = CGRectMake(kSize.width- 150, 270, winboImg.size.width, winboImg.size.height+ 20);
    [winboBtn setImage:winboImg forState:UIControlStateNormal];
    [winboBtn setTitle:@"wiebo" forState:UIControlStateNormal];
    [winboBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [winboBtn addTarget:self action:@selector(weiboClick) forControlEvents:UIControlEventTouchUpInside];
    [winboBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    [self.view addSubview:winboBtn];
    
    }

- (void)qqclick
{

    [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
    if (result) {
        NSLog(@"授权登陆成功，已获取用户信息");
        NSString *uid = [userInfo uid];
        NSString *nickname = [userInfo nickname];
        NSString *profileImage = [userInfo profileImage];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录成功" message:[NSString stringWithFormat:@"授权登陆成功,用户ID:%@,昵称:%@,头像:%@",uid,nickname,profileImage] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else{
        NSLog(@"分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"授权失败" message:@"授权失败，请看日记错误描述" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}];

}
- (void)weiboClick
{
    //
//    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
//                      authOptions:nil
//                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
//                               
//                           }];
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result) {
            NSLog(@"授权登陆成功，已获取用户信息");
            NSString *uid = [userInfo uid];
            NSString *nickname = [userInfo nickname];
            NSString *profileImage = [userInfo profileImage];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录成功" message:[NSString stringWithFormat:@"授权登陆成功,用户ID:%@,昵称:%@,头像:%@",uid,nickname,profileImage] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }else{
            NSLog(@"分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"授权失败" message:@"授权失败，请看日记错误描述" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];

    
    
}


- (void)cancelClick:(UIButton *)btn
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerClick:(UIButton *)btn
{
//    NSLog(@"registerClick");
    
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)loginBtnClick:(UIButton *)btn
{
    NSLog(@"loginBtnClick");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}



@end
