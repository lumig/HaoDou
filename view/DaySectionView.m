//
//  DaySectionView.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-13.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "DaySectionView.h"
#import "listInfo.h"
#import "UIImageView+AFNetworking.h"
@implementation DaySectionView

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
        _view = [[UIView alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, 44)];
        [self addSubview:_view];
        [_view setBackgroundColor:[UIColor whiteColor]];
        
        self.avaterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 6, 30, 30)];
        self.avaterIcon.layer.cornerRadius = 15;
        self.avaterIcon.layer.masksToBounds = YES;
        [_view addSubview:_avaterIcon];
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 6, 150, 17)];
        [_userNameLabel setFont:[UIFont systemFontOfSize:14]];
        [_view addSubview:_userNameLabel];
        
        _positionImgView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 23, 15, 15)];
        [_positionImgView setImage:[UIImage imageNamed:@"ico_prefix_position.png"]];
        [_view addSubview:_positionImgView];
        
        _positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 23, 100, 17)];
        _positionLabel.font = [UIFont systemFontOfSize:12];
        _positionLabel.textColor = [UIColor grayColor];
        [_view addSubview:_positionLabel];
        
        _createTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSize.width - 240, 10, 200, 22)];
        _createTimeLabel.font = [UIFont systemFontOfSize:14];
        _createTimeLabel.textColor = [UIColor grayColor];
        _createTimeLabel.textAlignment = NSTextAlignmentRight;
        [_view addSubview:_createTimeLabel];
        
        
        
    }
    return self;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    self.avaterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 6, 35, 35)];
//    self.avaterIcon.layer.cornerRadius = 15;
//    self.avaterIcon.layer.masksToBounds = YES;
//}

- (void)daySectionFillInfo:(listInfo *)info

{
    [self.avaterIcon setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:nil];
    if (info.position.length < 1) {
        [self.positionImgView setHidden:YES];
    }
    [self.positionLabel setText:info.position];
    [self.userNameLabel setText:info.userName];
    [self.positionLabel setText:info.position];
    [self.createTimeLabel setText:info.timeStr];
}

@end
