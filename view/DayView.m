//
//  DayView.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-8.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "DayView.h"

@implementation DayView



- (id)initWithDayViewFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _themeCoverImgView = [[UIImageView alloc] init];
        _themeTitleLab = [[UILabel alloc] init];
        _photoCountLab = [[UILabel alloc] init];
        
        //
        [_themeCoverImgView setUserInteractionEnabled:YES];
//        _themeCoverImgView.tag = index;
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tap];
        
        
        [self addSubview:_themeCoverImgView];
        [self addSubview:_themeTitleLab];
        [self addSubview:_photoCountLab];
    }
    return self;
}

- (void)imgClick:(UITapGestureRecognizer *)sender
{
    if ([_delegate respondsToSelector:@selector(DayViewDidClicked:)]) {
        [_delegate DayViewDidClicked:sender];
    }
}
@end
