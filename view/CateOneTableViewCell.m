//
//  CateOneTableViewCell.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-8.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "CateOneTableViewCell.h"

@implementation CateOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _cateOneImgView = [[CateView alloc] initWithFrame:CGRectMake(15, 0, (kSize.width - 30)/2.0f - 5, 140)];
        _cateOneImgView.coverImgView.frame =CGRectMake(0, 0, (kSize.width - 30)/2.0f - 5, 100);
        _cateOneImgView.userNameLab.frame = CGRectMake(0, 105, (kSize.width - 30)/2.0f - 5, 10);
        _cateOneImgView.countLab.frame = CGRectMake(0, 120, (kSize.width - 30)/2.0f - 5, 10);
        [_cateOneImgView.userNameLab setTextColor:[UIColor blackColor]];
        _cateOneImgView.userNameLab.font = [UIFont systemFontOfSize:12];
        [_cateOneImgView.countLab setTextColor:[UIColor blackColor]];
        _cateOneImgView.countLab.font = [UIFont systemFontOfSize:12];
        [_cateOneImgView setUserInteractionEnabled:YES];
        _cateOneImgView.tag = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_cateOneImgView addGestureRecognizer:tap];
        
        _cateTwoImgView = [[CateView alloc] initWithFrame:CGRectMake((kSize.width - 30)/2.0f + 20, 0, (kSize.width - 30)/2.0f - 5, 170)];
        _cateTwoImgView.coverImgView.frame = CGRectMake(0, 0, (kSize.width - 30)/2.0f - 5, 130);
        _cateTwoImgView.userNameLab.frame = CGRectMake(0, 135, (kSize.width - 30)/2.0f - 5, 10);
        _cateTwoImgView.countLab.frame = CGRectMake(0, 150, (kSize.width - 30)/2.0f - 5, 10);
        [_cateTwoImgView.userNameLab setTextColor:[UIColor blackColor]];
        _cateTwoImgView.userNameLab.font = [UIFont systemFontOfSize:12];
        [_cateTwoImgView.countLab setTextColor:[UIColor blackColor]];
        _cateTwoImgView.countLab.font = [UIFont systemFontOfSize:12];
        [_cateTwoImgView setUserInteractionEnabled:YES];
        _cateTwoImgView.tag = 2;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        tap1.numberOfTapsRequired = 1;
        tap1.numberOfTouchesRequired = 1;
        [_cateTwoImgView addGestureRecognizer:tap1];
        
        _cateThreeImgView = [[CateView alloc] initWithFrame:CGRectMake(15, 140, (kSize.width - 30)/2.0f - 5, 170)];
        _cateThreeImgView.coverImgView.frame = CGRectMake(0, 0, (kSize.width - 30)/2.0f - 5, 130);
        
        _cateThreeImgView.userNameLab.frame = CGRectMake(0, 135, (kSize.width - 30)/2.0f - 5, 10);
        _cateThreeImgView.countLab.frame = CGRectMake(0, 150, (kSize.width - 30)/2.0f - 5, 10);
        [_cateThreeImgView.userNameLab setTextColor:[UIColor blackColor]];
        _cateThreeImgView.userNameLab.font = [UIFont systemFontOfSize:12];
        [_cateThreeImgView.countLab setTextColor:[UIColor blackColor]];
        _cateThreeImgView.countLab.font = [UIFont systemFontOfSize:12];
        [_cateThreeImgView setUserInteractionEnabled:YES];
        _cateThreeImgView.tag = 3;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        tap2.numberOfTapsRequired = 1;
        tap2.numberOfTouchesRequired = 1;
        [_cateThreeImgView addGestureRecognizer:tap2];
        
        _cateFourImgView = [[CateView alloc] initWithFrame:CGRectMake((kSize.width - 30)/2.0f + 20, 170, (kSize.width - 30)/2.0f - 5, 130)];
        _cateFourImgView.coverImgView.frame = CGRectMake(0, 0, (kSize.width - 30)/2.0f - 5, 100);
        _cateFourImgView.userNameLab.frame = CGRectMake(0, 105, (kSize.width - 30)/2.0f - 5, 10);
        _cateFourImgView.countLab.frame = CGRectMake(0, 120, (kSize.width - 30)/2.0f - 5, 10);
        [_cateFourImgView.userNameLab setTextColor:[UIColor blackColor]];
        _cateFourImgView.userNameLab.font = [UIFont systemFontOfSize:12];
        [_cateFourImgView.countLab setTextColor:[UIColor blackColor]];
        _cateFourImgView.countLab.font = [UIFont systemFontOfSize:12];
        [_cateFourImgView setUserInteractionEnabled:YES];
        _cateFourImgView.tag = 4;
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        tap3.numberOfTapsRequired = 1;
        tap3.numberOfTouchesRequired = 1;
        [_cateFourImgView addGestureRecognizer:tap3];
        
        [self.contentView addSubview:_cateFourImgView];
        [self.contentView addSubview:_cateOneImgView];
        [self.contentView addSubview:_cateTwoImgView];
        [self.contentView addSubview:_cateThreeImgView];

        
    }
    return self;
}

- (void)imgClick:(UITapGestureRecognizer *)sender
{
    if ([_delegate respondsToSelector:@selector(CateOneTableViewCellDidClicked:)]) {
        [_delegate CateOneTableViewCellDidClicked:sender.view.tag];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
