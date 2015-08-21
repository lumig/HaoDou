//
//  ListTableViewCell.m
//  cellbtnDemo
//
//  Created by Lu Ming on 15-1-13.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "ListTableViewCell.h"


#define kSize [UIScreen mainScreen].bounds.size

@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //http://blog.csdn.net/swingpyzf/article/details/18093959
        
        [self initLayout];
        
    }
    return self;
    
}


- (void)initLayout
{
    _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, 200)];
    _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 150, kSize.width - 30, 20)];
    _titleLab.font = [UIFont systemFontOfSize:18];
    [_titleLab setTextColor:[UIColor whiteColor]];
    _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(25, 170, kSize.width - 30, 15)];
    _userNameLab.font = [UIFont systemFontOfSize:12];
    [_userNameLab setTextColor:[UIColor whiteColor]];
    _introLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 200, kSize.width - 30 ,                  0)];
//    [_introLab setBackgroundColor:[UIColor redColor]];
    _introLab.font = [UIFont systemFontOfSize:14];
    [_introLab setTextColor:[UIColor blackColor]];
    [_introLab setNumberOfLines:0];
    
    
    UIImage *bigLabImg = [UIImage imageNamed:@"yuan_03.png"];
    UIImage *showLabImg = [UIImage imageNamed:@"yuan_06.png"];
    UIImage *likeImg = [UIImage imageNamed:@"like_show@2x.png"];
    //show whitelove
    _bigLabView = [[UIImageView alloc] init];
    _bigLabView.frame = CGRectMake(15, 0,likeImg.size.width, likeImg.size.height);
    _bigLabView.center = CGPointMake((kSize.width - 30)/2.0f, 200/2.0f);
    [_bigLabView setImage:likeImg];
    [_bigLabView setAlpha:0];
    //show whitecircleImgView
    _likeImgView = [[UIImageView alloc] init];
    _likeImgView.frame = CGRectMake(kSize.width - 80, 150, 42, 42);
    [_likeImgView setImage:bigLabImg];
//    [_likeImgView setUserInteractionEnabled:YES];
    //show orangelab,likeview show
    _showLabView = [[UIImageView alloc] initWithFrame:CGRectMake(kSize.width - 50, 175, showLabImg.size.width, showLabImg.size.height)];
    [_showLabView setImage:showLabImg];
    //show likeCount
    _showLab = [[UILabel alloc] init];
    _showLab.frame = CGRectMake(kSize.width - 50, 180, showLabImg.size.width, 10);
    [_showLab setTextAlignment:NSTextAlignmentCenter];
    _showLab.font = [UIFont systemFontOfSize:8];
    [_showLab setTextColor:[UIColor whiteColor]];
    
    //click likebtn
    _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btnNor = [UIImage imageNamed:@"ico_orange_love.png"];
    [_likeBtn setFrame:CGRectMake(kSize.width - 68, 162, 20, 20)];
    [_likeBtn setImage:btnNor forState:UIControlStateNormal];
    
    [_likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    ///计算高度
//    CGRect frame = [self frame];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    
//    CGSize constraint = CGSizeMake(300, 20000.0f);
//    //段落风格
//    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraphStyle.copy};
//    
//    CGSize labSize = [_introLab.text boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
//    frame.size.height = labSize.height+10 + 150;
//    self.frame = frame;
    
   //视图 添加会有顺序对后期UI显示有一定的影响
    [self.contentView addSubview:_coverView];
    [self.contentView addSubview:_titleLab];
    [self.contentView addSubview:_userNameLab];
    [self.contentView addSubview:_introLab];
    [self.contentView addSubview:_bigLabView];
    [self.contentView addSubview:_likeImgView];
    [self.contentView addSubview:_showLabView];
    [self.contentView addSubview:_showLab];
    [self.contentView addSubview:_likeBtn];
//    [self.contentView setUserInteractionEnabled:YES];
}

//ios7以上版本，这段代码没有用
- (void)setIntroLabTest:(NSString *)text
{
    CGRect frame = [self frame];
    _introLab.text = text;
    CGSize constraint = CGSizeMake(300, 20000.0f);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:12] forKey:NSFontAttributeName];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:_introLab.text
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               context:nil];
    CGSize size11 = rect.size;
    
    
    
    //计算出自适应的高度,150是imgview的高度
    frame.size.height = size11.height+10 + 150;
    
    self.frame = frame;
    NSLog(@"frame%@",NSStringFromCGRect(self.frame));
}


//老版本，
//- (void)setIntroLabText:(NSString *)text
//{
//    //获取当前cell的高度
//    CGRect frame = [self frame];
//    NSLog(@"frame %@",NSStringFromCGRect(frame));
//    self.introLab.text = text;
//    //设置label的最大行数
//    self.introLab.numberOfLines = 20;
//    CGSize size = CGSizeMake(kSize.width - 30, 1000);
//    CGSize labelSize = [self.introLab.text sizeWithFont:self.introLab.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
//    self.introLab.frame = CGRectMake(self.introLab.frame.origin.x, self.introLab.frame.origin.y, labelSize.width, labelSize.height);
//    
//    //计算出自适应的高度
//    frame.size.height = labelSize.height+10;
//    
//    self.frame = frame;
//    NSLog(@"frame%@",self.frame);
//}

//- (void)likeBtnClick:(UIButton *)btn
//{
//    if ([self respondsToSelector:@selector(likeBtnClickChange:)]) {
//        [_delegate likeBtnClickChange:btn];
//    }
//}
//点击按钮切换是否选中状态，实现图片的放大，改变背景等功能
- (void)likeBtnClick:(UIButton *)btn
{
    NSLog(@"likeBtnClick");
    if (self.isClick) {
        self.isClick = NO;
        [btn setSelected:NO];
        [UIView animateWithDuration:0.5 animations:^{
            [btn setImage:[UIImage imageNamed:@"ico_orange_love.png"] forState:UIControlStateSelected];
            [btn setAlpha:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        } completion:^(BOOL finished) {
            [btn setAlpha:1];
        }];
        
    }
    else
    {
        self.isClick = YES;
        [btn setSelected:YES];
        [UIView animateWithDuration:1 animations:^{
            [btn setImage:[UIImage imageNamed:@"ico_orange_love_on.png"] forState:UIControlStateSelected];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//            _bigLabView.frame = CGRectMake(0, 0,142 * 0.8f, 122 * 0.8f);
            _bigLabView.center = CGPointMake((kSize.width - 30)/2.0f, 200/2.0f);

            [_bigLabView setAlpha:1.0f];
        } completion:^(BOOL finished) {
            [_bigLabView setAlpha:0];
        }];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
