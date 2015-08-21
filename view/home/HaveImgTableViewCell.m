//
//  HaveImgTableViewCell.m
//  HaoDou
//
//  Created by Lu Ming on 14-12-28.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import "HaveImgTableViewCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@implementation HaveImgTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //have small image in UIImageView
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //大图
        _coverImgView = [[UIImageView alloc] init];
        _coverImgView.frame = CGRectMake(15, 0,  kWidth- 30, 200);
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 64, 28)];
        _smallCoverImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 200 - (kWidth - 30) / 5.0f, kWidth - 30, (kWidth - 30) / 5.0f)];
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(15, 200, kWidth - 30, 20);
        //设置加粗的字体
//        _titleLabel.text = [UIFont boldSystemFontOfSize:16];
        //这个方式会报错
        _titleLabel.font = [UIFont fontWithName:@"bold" size:16];
        _introLabel = [[UILabel alloc] init];
        _introLabel.frame = CGRectMake(15, 210, kWidth - 30, 50);
        _introLabel.font = [UIFont systemFontOfSize:12];
        [_introLabel setNumberOfLines:3];
        [_introLabel setTextColor:[UIColor grayColor]];
        _imgIntroLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 140, kWidth - 50, 50)];
        _imgIntroLabel.font = [UIFont systemFontOfSize:14];
        [_imgIntroLabel setNumberOfLines:4];
        [_imgIntroLabel setTextColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:_coverImgView];
        [self.contentView addSubview:_iconView];
        [self.contentView addSubview:_smallCoverImgView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_introLabel];
        [self.contentView addSubview:_imgIntroLabel];
        
    }
    
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
