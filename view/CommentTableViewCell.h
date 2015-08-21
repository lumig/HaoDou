//
//  CommentTableViewCell.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-11.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *avatarImgView;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UILabel *createTimeLab;
@property(nonatomic,strong)UILabel *contentLab;



@end
