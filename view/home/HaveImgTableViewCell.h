//
//  HaveImgTableViewCell.h
//  HaoDou
//
//  Created by Lu Ming on 14-12-28.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
//也可以考虑将他们结合到一起

//这里将含有icon的归为一类
@interface HaveImgTableViewCell : UITableViewCell
//大图
@property(nonatomic,strong)UIImageView *coverImgView;
//左边图标
@property(nonatomic,strong)UIImageView *iconView;
//标题
@property(nonatomic,strong)UILabel *titleLabel;
//介绍文本
@property(nonatomic,strong)UILabel *introLabel;
//小图
@property(nonatomic,strong)UIImageView *smallCoverImgView;
//图片内部的文本介绍
@property(nonatomic,strong)UILabel *imgIntroLabel;

//cell中afnetworking传值所用
//@property(nonatomic,strong)NSString *urlStr;
//aid=4275308&limit=10&offset=0&sign=33e3696577645da906cd6a378119b243&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B

//@property(nonatomic,strong)NSString *aidStr;
//@property(nonatomic,strong)NSString *limitStr;
//@property(nonatomic,strong)NSString *offsetStr;
//@property(nonatomic,strong)NSString *signStr;
//@property(nonatomic,strong)NSString *uidStr;
//@property(nonatomic,strong)NSString *uuidStr;

@end
