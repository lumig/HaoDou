//
//  ShowImgView.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-25.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "ShowImgView.h"

@implementation ShowImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 100, 100)];
        _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 100, 10)];
        [_userNameLab setFont:[UIFont systemFontOfSize:12]];
        [_userNameLab setTextColor:[UIColor grayColor]];
        
        _commentLab = [[UILabel alloc] initWithFrame:CGRectMake(120, 15, kSize.width - 140, 60)];
        [_commentLab setFont:[UIFont systemFontOfSize:14]];
        [_commentLab setNumberOfLines:0];
        
        [self addSubview:_imgView];
        [self addSubview:_userNameLab];
        [self addSubview:_commentLab];
    }
    return self;

}

//-(BOOL)hasPrefix:(NSString*)aString;
//
//{
//    return NO;
//}


@end
