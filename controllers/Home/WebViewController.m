//
//  WebViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-11.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "WebViewController.h"
#import "CommentViewController.h"


#define kSize [UIScreen mainScreen].bounds.size


@interface WebViewController ()
{
    UIWebView *_webView;
    NSArray *_webArr;
}

@end

@implementation WebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.tintColor = kGreen ;

}


- (id)initWithIndex:(NSUInteger)index
{
    self = [super init];
    if (self) {
        self.index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"webindex%ld",self.index);
    
    [self creatRightBtns];
    

    _webView = [[UIWebView alloc] init];
    _webView.frame = CGRectMake(0, 0, kSize.width, kSize.height);
    [self.view addSubview:_webView];
    _webArr = [NSArray array];
    _webArr = @[@"http://m.haodou.com/topic-323324.html",@"http://group.haodou.com/topic-324153.html",@"http://group.haodou.com/topic-321447.html",@"http://m.haodou.com/topic-176619.html",@"http://m.haodou.com/topic-323072.html",@"http://group.haodou.com/topic-324608.html",@"http://group.haodou.com/topic-278170.html"];
    
    NSString *urlStr = (NSString *)[_webArr objectAtIndex:self.index];
//    NSString *urlStr = @"http://m.haodou.com/topic-323324.html";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    
}
- (void)creatRightBtns
{
//        UIBarButtonItem *favorBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ico_menu_favorites.png"] style:UITabBarSystemItemContacts target:self action:@selector(favorBtnClick:)];
    
//    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ico_topcomment.png"] style:UITabBarSystemItemContacts target:self action:@selector(commentBtnClick:)];
    
//    UIBarButtonItem *topshareBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ico_topshare.png"] style:UITabBarSystemItemContacts target:self action:@selector(topshareBtnClick:)];

    NSMutableArray *btnArr = [[NSMutableArray alloc] initWithCapacity:3];
    
    UIButton *favorBtn = [[UIButton alloc] init];
    UIImage *favorImg = [UIImage imageNamed:@"ico_menu_favorites.png"];
    [favorBtn setBackgroundImage:favorImg forState:UIControlStateNormal];
    //颜色在点击后修改
    [favorBtn setBackgroundImage:[UIImage imageNamed:@"ico_topfavorites_over.png"] forState:UIControlStateSelected];
    favorBtn.frame = CGRectMake(0, 0, favorImg.size.width, favorImg.size.height);
    [favorBtn addTarget:self action:@selector(favorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *favorBtnItem = [[UIBarButtonItem alloc] initWithCustomView:favorBtn];
    [btnArr addObject:favorBtnItem];
    
    UIButton *commentBtn = [[UIButton alloc] init];
    UIImage *commentImg = [UIImage imageNamed:@"ico_topcomment.png"];
    [commentBtn setBackgroundImage:commentImg forState:UIControlStateNormal];
    commentBtn.frame = CGRectMake(0, 0, commentImg.size.width, commentImg.size.height);
    [commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *commentBtnItem = [[UIBarButtonItem alloc] initWithCustomView:commentBtn];
    [btnArr addObject:commentBtnItem];
    
    UIButton *topshareBtn = [[UIButton alloc] init];
    UIImage *topshareImg = [UIImage imageNamed:@"ico_topshare.png"];
    [topshareBtn setBackgroundImage:topshareImg forState:UIControlStateNormal];
    topshareBtn.frame = CGRectMake(0, 0, topshareImg.size.width, topshareImg.size.height);
    [topshareBtn addTarget:self action:@selector(topshareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *topshareBtnItem = [[UIBarButtonItem alloc] initWithCustomView:topshareBtn];
    [btnArr addObject:topshareBtnItem];
    
    UIToolbar *customToolbar = [[UIToolbar alloc]
                                initWithFrame:CGRectMake(0.0f, 0.0f, 120, 44.0f)]; // 44.01 shifts it up 1px for some reason
    
    customToolbar.clearsContextBeforeDrawing = NO;
    customToolbar.clipsToBounds = NO;
    customToolbar.tintColor = [UIColor colorWithWhite:0.305f alpha:0.0f]; // closest I could get by eye to black, translucent style.
    customToolbar.barStyle = -1; // clear background
    [customToolbar setItems:btnArr animated:NO];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customToolbar];
    
//    self.navigationItem.rightBarButtonItems = @[topshareBtnItem,commentBtnItem,favorBtnItem];
    
//    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:topshareBtnItem, commentBtnItem, favorBtnItem,nil]];
}

- (void)favorBtnClick:(UIButton *)btn
{
    NSLog(@"favorBtnClick");
    [btn setImage:[UIImage imageNamed:@"ico_topfavorites_over.png"] forState:UIControlStateSelected];
    
    
}

- (void)commentBtnClick:(UIButton *)btn
{
    NSLog(@"commentBtnClick");
    //评论
    CommentViewController *commentVC = [[CommentViewController alloc] init];
    [self.navigationController pushViewController:commentVC animated:NO];
}

- (void)topshareBtnClick:(UIButton *)btn
{
    NSLog(@"topshareBtnClick");
    //shareSDK
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
