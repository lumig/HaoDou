//
//  RegisterViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-15.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    [self addCreateRegister];
}

- (void)addCreateRegister
{
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"phone number";
    phoneLabel.frame = CGRectMake(15, 100, 50, 44);
    [self.view addSubview:phoneLabel];
    
    UITextField *phoneText = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.frame.origin.x + phoneLabel.frame.size.width, 100, 200, 44)];
    [phoneText setPlaceholder:@"请输入手机号码"];
    [self.view addSubview:phoneText];
    
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
