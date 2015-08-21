//
//  FeedBackTableViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-18.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "FeedBackTableViewController.h"
#import "AFNetworking.h"
#import "FeedBackHistoryTableViewController.h"
#define kSize [UIScreen mainScreen].bounds.size


@interface FeedBackTableViewController ()
{
    UITableView *_tableView;
    UILabel *_textLab;
    UIButton *_finishBtn;
    NSString *_content;
}
@end

@implementation FeedBackTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, kSize.height)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.title = @"意见反馈";
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [finishBtn setUserInteractionEnabled:NO];
    [finishBtn setTitleColor:kGreen forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:finishBtn];
    _finishBtn = finishBtn;
    [finishBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        UIWebView *callWebview =[[UIWebView alloc] init];
        NSURL *telURL =[NSURL URLWithString:@"tel:4006770760"];// 貌似tel:// 或者 tel: 都行
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.view addSubview:callWebview];
    }
    else if(indexPath.section == 2)
    {
        FeedBackHistoryTableViewController *feedbackHisVC = [[FeedBackHistoryTableViewController alloc] init];
        [self.navigationController pushViewController:feedbackHisVC animated:NO];
    }
   
}

//点击完成上传uitextview中的文本信息
- (void)finishBtnClick:(UIButton *)btn
{
    NSLog(@"finishBtnClick");
    //实现push到查看历史记录
    FeedBackHistoryTableViewController *feedbackHisVC = [[FeedBackHistoryTableViewController alloc] init];
    [self.navigationController pushViewController:feedbackHisVC animated:NO];
    
    //上传文本相关操作
    NSString *content = _content;
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=6832623&method=FeedBack.add&sessionid=1421552484&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    //channel_type=appstore&content=Magi&device_type=iPhone6%2C2&net_type=WiFi&sign=33e3696577645da906cd6a378119b243&soft_version=4.5.0&system_version=IOS%207.1.1&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
    NSDictionary *dict = @{@"channel_type":@"appstore", @"device_type":@"iPhone6%2C2", @"net_type":@"WiFi", @"sign":@"33e3696577645da906cd6a378119b243", @"soft_version":@"4.5.0", @"system_version":@"IOS%207.1.1", @"uid":@"6832623", @"uuid":@"17EF523E05B42597F70A95681590F28B"};
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [parameters addEntriesFromDictionary:@{@"content":content}];
//    NSLog(@"urlStr = %@",urlStr);
//    NSLog(@"parameters = %@ \n content = %@",parameters,content);
    
    [[AFHTTPRequestOperationManager manager] POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"文本上传成功!");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"文本上传失败!");
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else if (section ==1)
    {
        return 2;
    }else
        return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, 200)];
        [[cell contentView] addSubview:textView];
        UILabel *textLab = [[UILabel alloc] init];
        textLab.frame =CGRectMake(15, 10, kSize.width - 30 , 50);
        [textLab setNumberOfLines:0];
        textLab.text = @"亲，希望您能留下您的联系方式，若您的意见被采纳，我们会赠送精美礼品一份！";
        textLab.enabled = NO;//lable必须设置为不可用
        _textLab = textLab;
        [cell.contentView addSubview:textLab];
        textView.delegate = self;
    }else if(indexPath.section == 1)
    {
        NSArray *array = @[@"客服电话：",@"客服QQ：800077728"];
        if (indexPath.row == 0) {
            UILabel *telLab = [[UILabel alloc] initWithFrame:CGRectMake(100, 11, 250, 22)];
            [telLab setText:@"4006-770-760"];
            [telLab setTextColor:kGreen];
            [[cell contentView] addSubview:telLab];
             cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头  
            
        }
        [cell.textLabel setText:array[indexPath.row]];
    }else
    {
        [cell.textLabel setText:@"查看历史记录"];
         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }else
        return 44;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _textLab.text = @"亲，希望您能留下您的联系方式，若您的意见被采纳，我们会赠送精美礼品一份！";
    }else{
        _textLab.text = @"";
        [_finishBtn setUserInteractionEnabled:YES];
        _content = textView.text;
    }
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
