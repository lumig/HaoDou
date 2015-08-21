//
//  StepTableViewCell.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-24.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "StepTableViewCell.h"

@implementation StepTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 80, 60)];
        
        _numLab = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 20, 10)];
        [_numLab setFont:[UIFont systemFontOfSize:16]];
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(130, 0, kSize.width - 140, 60)];
        [_titleLab setFont:[UIFont systemFontOfSize:14]];
        [_titleLab setNumberOfLines:0];
        
        [self.contentView addSubview:_imgView];
        [self.contentView addSubview:_numLab];
        [self.contentView addSubview:_titleLab];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
