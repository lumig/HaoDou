//
//  CateView.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-8.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "CateView.h"

@implementation CateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        _coverImgView = [[UIImageView alloc] init];
        _countLab = [[UILabel alloc] init];
        _userNameLab = [[UILabel alloc] init];
        
        [self addSubview:_countLab];
        [self addSubview:_coverImgView];
        [self addSubview:_userNameLab];
    }
    return self;
}

@end
