//
//  LearnTableViewCell.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-8.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "LearnTableViewCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation LearnTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    //
        _recipeCoverImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, kSize.width - 30, 200)];
        
        _listImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 200 - (kSize.width - 30) / 4.0f, (kSize.width - 30), (kSize.width - 30) / 4.0f)];
        
        _userAvaterImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 40, 40)];
        _userAvaterImgView.layer.cornerRadius = 20;
        _userAvaterImgView.layer.masksToBounds = YES;
        
        _userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(70, 70, kSize.width - 100, 20)];
        [_userNameLab setFont:[UIFont systemFontOfSize:18]];
        [_userNameLab setTextColor:[UIColor whiteColor]];
        
        _introLab = [[UILabel alloc] initWithFrame:CGRectMake(70, 90, kSize.width - 100, 20)];
        [_introLab setFont:[UIFont systemFontOfSize:12]];
        [_introLab setTextColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:_recipeCoverImgView];
        [self.contentView addSubview:_listImgView];
        [self.contentView addSubview:_userAvaterImgView];
        [self.contentView addSubview:_introLab];
        [self.contentView addSubview:_userNameLab];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
