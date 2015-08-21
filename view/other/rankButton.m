//
//  rankButton.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-3.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "rankButton.h"


#define kWidth [UIScreen mainScreen].bounds.size.width
#define kGreen [UIColor colorWithRed:102/255.0f green:153/255.0f blue:0.0f alpha:1]

@implementation rankButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        _textLabel = [[UILabel alloc] init];
        _textLabel.frame = CGRectMake(15, 0, 100, 30);
        [_textLabel setTextColor:kGreen];
        [_textLabel setFont:[UIFont systemFontOfSize:16]];
        
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.frame = CGRectMake(kWidth -80, 0, 100, 30);
        [_moreLabel setFont:[UIFont systemFontOfSize:12]];
        
        [self addSubview:_textLabel];
        [self addSubview:_moreLabel];
        
        
    }
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
