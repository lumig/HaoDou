//
//  HotTableViewCell.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-4.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "HotTableViewCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
@implementation HotTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _coverImgView = [[UIImageView alloc] init];
        _coverImgView.frame = CGRectMake(15, 0, 80, 50);
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(110, 0, kWidth - 130, 30);
        _titleLabel.font = [UIFont fontWithName:@"bold" size:16];
        
        _likeCountLabel = [[UILabel alloc] init];
        _likeCountLabel.frame = CGRectMake(110, 25, (kWidth - 130) / 2.0f, 10);
        _likeCountLabel.font = [UIFont systemFontOfSize:12];
        
        _viewCountLabel = [[UILabel alloc] init];
        _viewCountLabel.frame = CGRectMake((kWidth - 150) / 2.0f + 110, 25, (kWidth - 130) / 2.0f, 10);
        _viewCountLabel.font = [UIFont systemFontOfSize:12];
        _introLabel = [[UILabel alloc] init];
        _introLabel.frame = CGRectMake(110, 40, kWidth - 130, 10);
        _introLabel.font = [UIFont systemFontOfSize:12];
        [_introLabel setNumberOfLines:1];
        
        [self.contentView addSubview:_coverImgView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_introLabel];
        [self.contentView addSubview:_likeCountLabel];
        [self.contentView addSubview:_viewCountLabel];
        
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
