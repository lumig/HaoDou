//
//  DayTableViewCell.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-8.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "DayTableViewCell.h"
#define kRatio 0.55
@implementation DayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _lunchDView = [[DayView alloc] initWithDayViewFrame:CGRectMake(15, 0 , kSize.width * kRatio, kSize.width * kRatio) ];
        _lunchDView.themeCoverImgView.frame = CGRectMake(0, 0 , kSize.width * kRatio, kSize.width * kRatio);
        _lunchDView.themeTitleLab.frame = CGRectMake(15, _lunchDView.frame.size.height - 50, 100, 20);
        _lunchDView.themeTitleLab.font = [UIFont systemFontOfSize:14];
        [_lunchDView.themeTitleLab setTextColor:[UIColor whiteColor]];
        [_lunchDView.themeTitleLab setTextAlignment:NSTextAlignmentLeft];
        _lunchDView.photoCountLab.frame = CGRectMake(15, _lunchDView.frame.size.height - 30, 100, 20);
        [_lunchDView.photoCountLab setTextAlignment:NSTextAlignmentLeft];
        _lunchDView.photoCountLab.font = [UIFont systemFontOfSize:12];
        [_lunchDView.photoCountLab setTextColor:[UIColor whiteColor]];
        [_lunchDView setUserInteractionEnabled:YES];
        _lunchDView.tag = 1;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_lunchDView addGestureRecognizer:tap];
        //
        _breakfastDView = [[DayView alloc] initWithDayViewFrame:CGRectMake(kSize.width * kRatio + 15 +1, 0 ,kSize.width - kSize.width * kRatio - 31, kSize.width * kRatio / 2.0f) ];
        _breakfastDView.themeCoverImgView.frame = CGRectMake(0, 0 ,kSize.width - kSize.width * kRatio - 31, kSize.width * kRatio / 2.0f);
        _breakfastDView.themeTitleLab.frame = CGRectMake(15, _breakfastDView.frame.size.height - 50, 100, 20);
        _breakfastDView.themeTitleLab.font = [UIFont systemFontOfSize:14];
        [_breakfastDView.themeTitleLab setTextColor:[UIColor whiteColor]];
        [_breakfastDView.themeTitleLab setTextAlignment:NSTextAlignmentLeft];
        _breakfastDView.photoCountLab.frame = CGRectMake(15, _breakfastDView.frame.size.height - 30, 100, 20);
        [_breakfastDView.photoCountLab setTextAlignment:NSTextAlignmentLeft];
        _breakfastDView.photoCountLab.font = [UIFont systemFontOfSize:12];
        [_breakfastDView.photoCountLab setTextColor:[UIColor whiteColor]];
        [_breakfastDView setUserInteractionEnabled:YES];
        _breakfastDView.tag = 2;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        tap1.numberOfTapsRequired = 1;
        tap1.numberOfTouchesRequired = 1;
        [_breakfastDView addGestureRecognizer:tap1];
        
        //
        _supperDView = [[DayView alloc] initWithDayViewFrame:CGRectMake(kSize.width * kRatio + 15 +1, kSize.width * kRatio / 2.0f +1 ,kSize.width - kSize.width * kRatio - 31, kSize.width * kRatio / 2.0f - 1) ];
        _supperDView.themeCoverImgView.frame = CGRectMake(0, 0 ,kSize.width - kSize.width * kRatio - 31, kSize.width * kRatio / 2.0f);
        _supperDView.themeTitleLab.frame = CGRectMake(15, _supperDView.frame.size.height - 50, 100, 20);
        _supperDView.themeTitleLab.font = [UIFont systemFontOfSize:14];
        [_supperDView.themeTitleLab setTextColor:[UIColor whiteColor]];
        [_supperDView.themeTitleLab setTextAlignment:NSTextAlignmentLeft];
        _supperDView.photoCountLab.frame = CGRectMake(15, _supperDView.frame.size.height - 30, 100, 20);
        [_supperDView.photoCountLab setTextAlignment:NSTextAlignmentLeft];
        _supperDView.photoCountLab.font = [UIFont systemFontOfSize:12];
        [_supperDView.photoCountLab setTextColor:[UIColor whiteColor]];
        [_supperDView setUserInteractionEnabled:YES];
        _supperDView.tag = 3;
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        tap2.numberOfTapsRequired = 1;
        tap2.numberOfTouchesRequired = 1;
        [_supperDView addGestureRecognizer:tap2];
        
        [self.contentView addSubview:_lunchDView];
        [self.contentView addSubview:_breakfastDView];
        [self.contentView addSubview:_supperDView];
    }
    return self;
}

- (void)imgClick:(UITapGestureRecognizer *)sender
{
    if ([_delegate respondsToSelector:@selector(DayTableViewCellDidClicked:)]) {
        [_delegate DayTableViewCellDidClicked:sender.view.tag];
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

//- (void)DayViewDidClicked:(UITapGestureRecognizer *)sender
//{
//    NSLog(@"DayViewDidClicked");
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
