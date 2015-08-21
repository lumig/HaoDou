//
//  HaveTwoLabTableViewCell.m
//  HaoDou
//
//  Created by Lu Ming on 14-12-28.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import "HaveTwoLabTableViewCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@implementation HaveTwoLabTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _coverView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, kWidth - 30, 200)];
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 200, 20, 20)];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 200, kWidth - 30, 20)];
        _titleLabel.font = [UIFont fontWithName:@"bold" size:16];
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 220, kWidth - 30, 30)];
        _descLabel.font = [UIFont systemFontOfSize:12];
        [_descLabel setNumberOfLines:3];
        
        //        _titleLabel.text = [UIFont boldSystemFontOfSize:16];
        _rTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 150, kWidth - 50, 20)];
        _rTitleLabel.font = [UIFont fontWithName:@"bold" size:16];
        [_rTitleLabel setTextColor:[UIColor whiteColor]];
        _introLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 160, kWidth - 50, 30)];
        [_introLabel setTextColor:[UIColor whiteColor]];
        _introLabel.font = [UIFont systemFontOfSize:12];
        [_introLabel setNumberOfLines:3];
        
        [self.contentView addSubview:_coverView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_introLabel];
        [self.contentView addSubview:_descLabel];
        [self.contentView addSubview:_rTitleLabel];
        [self.contentView addSubview:_iconImgView];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
