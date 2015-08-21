//
//  StepImgViewController.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-25.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "StepImgViewController.h"
#import "FoodMenuInfo.h"
#import "StepsInfo.h"
#import "UIImageView+AFNetworking.h"

@interface StepImgViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *numLab;
@property(nonatomic,strong)UITextView *txtView;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation StepImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    StepsInfo *info = [[StepsInfo alloc] init];
    info = self.stepArray[self.index];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImg = [UIImage imageNamed:@"ico_navback.png"];
    backBtn.frame = CGRectMake(kSize.width - 100, 44, backImg.size.width, backImg.size.height);
    [backBtn setImage:backImg forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:backBtn];
    //numLab
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(15, kSize.height / 2.0f - 130, 100, 20)];
    [numLab setFont:[UIFont systemFontOfSize:18]];
//    [numLab setText:[NSString stringWithFormat:@"%ld/%ld",self.index + 1, self.stepArray.count]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld/%ld",self.index + 1, self.stepArray.count]];
    NSInteger count = [NSString stringWithFormat:@"%ld",self.index + 1].length;
    [str addAttribute:NSForegroundColorAttributeName value:kGreen range:NSMakeRange(0, count)];
    numLab.attributedText = str;
    _numLab = numLab;
    [self.view addSubview:numLab];
    
    _txtView = [[UITextView alloc] initWithFrame:CGRectMake(15, kSize.height / 2.0f +120, kSize.width - 30, 100)];
    _txtView.userInteractionEnabled = NO;
    _txtView.text = info.intro;
    [_txtView setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:_txtView];
    
    //
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, 200)];
//    _imageView.center = CGPointMake(kSize.width / 2.0f, kSize.height / 2.0f);
//    [_imageView setImageWithURL:[NSURL URLWithString:info.stepPhoto] placeholderImage:nil];
//    [self.view addSubview:_imageView];
    
  
    //
    NSInteger kCount = self.stepArray.count;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, 200)];
    _scrollView.center = CGPointMake(kSize.width / 2.0f, kSize.height /2.0f);
    _scrollView.contentSize = CGSizeMake(kCount*kSize.width, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    for (int i = 0; i < kCount; i++) {
        StepsInfo *info = [[StepsInfo alloc] init];
        info = self.stepArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kSize.width, 0, kSize.width, 200)];
        
        [imageView setImageWithURL:[NSURL URLWithString:info.stepPhoto] placeholderImage:nil];
        _imageView = imageView;
        [_scrollView addSubview:imageView];
    }
    
    
    [self.view addSubview:_scrollView];
    //这句代码很关键，靠这个获取对应位置的值
    NSInteger current = self.index;
    _scrollView.contentOffset = CGPointMake(current *kSize.width, 0);
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPage = scrollView.contentOffset.x / kSize.width;

    [_numLab setText:[NSString stringWithFormat:@"%d/%ld",currentPage + 1,self.stepArray.count]];
    StepsInfo *info = [[StepsInfo alloc] init];
    info = self.stepArray[currentPage];
    [_txtView setText:info.intro];
}


- (void)backBtnClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
