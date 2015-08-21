//
//  RankTableViewCell.m
//  HaoDou
//
//  Created by Lu Ming on 14-12-31.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import "RankTableViewCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width

@implementation RankTableViewCell

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
        
        _introLabel = [[UILabel alloc] init];
        _introLabel.frame = CGRectMake(110, 25, kWidth - 130, 30);
        _introLabel.font = [UIFont systemFontOfSize:12];
        [_introLabel setNumberOfLines:3];
        
        [self.contentView addSubview:_coverImgView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_introLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
