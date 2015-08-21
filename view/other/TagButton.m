//
//  TagButton.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-1.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "TagButton.h"

#define kHeight 30
#define kWidth [UIScreen mainScreen].bounds.size.width

@implementation TagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
//        self.frame = CGRectMake(0, 0, (kWidth - 30) / 4.0f, 30);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        self.adjustsImageWhenHighlighted = NO;


    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 5;
   
    return CGRectMake(15, titleY, (kWidth - 30) / 4.0f - 15,  20);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 10, 10, 10);
}


@end
