//
//  CommentTableViewCell.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-11.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    if (isLight == 0) {
        //
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _avatarImgView = [[UIImageView alloc] init];
        _avatarImgView.frame = CGRectMake(15, 5, 50, 50);
        _avatarImgView.layer.cornerRadius = 25;
        _avatarImgView.layer.masksToBounds = YES;
        
        _userNameLab = [[UILabel alloc] init];
        _userNameLab.frame = CGRectMake(70, 5, 100, 15);
        _userNameLab.textColor = kGreen;
        _userNameLab.font = [UIFont systemFontOfSize:12];
        
        _createTimeLab = [[UILabel alloc] init];
        _createTimeLab.frame = CGRectMake(kSize.width - 180, 5, 150, 15);
        _createTimeLab.font = [UIFont systemFontOfSize:12];
        _createTimeLab.textAlignment = NSTextAlignmentRight;
        
        _contentLab = [[UILabel alloc] init];
        _contentLab.frame = CGRectMake(70, 20, kSize.width- 100, 20);
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.numberOfLines = 0;
        
        [self.contentView addSubview:_avatarImgView];
        [self.contentView addSubview:_userNameLab];
        [self.contentView addSubview:_createTimeLab];
        [self.contentView addSubview:_contentLab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
