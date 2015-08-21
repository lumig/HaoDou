//
//  ListBtnTableViewCell.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-17.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListBtnTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *coverView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIImageView *likeImgView;
@property(nonatomic,strong)UIImageView *bigLabView;
@property(nonatomic,strong)UIImageView *showLabView;
@property(nonatomic,strong)UILabel *showLab;
@property(nonatomic,assign)BOOL isClick;
@property(nonatomic,strong)UIImageView *tagImgV;
@property(nonatomic,strong)UIButton *tagBtn;
@end
