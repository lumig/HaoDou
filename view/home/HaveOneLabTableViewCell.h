//
//  HaveOneLabTableViewCell.h
//  HaoDou
//
//  Created by Lu Ming on 14-12-28.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
//HaveOneLabTableViewCell 指的是含有文本的图片和下面title和desc
//desc 是图片下面的描述
//intro 是图片里面的文字描述

//
@interface HaveOneLabTableViewCell : UITableViewCell
//厨房宝典

@property(nonatomic,strong)UIImageView *coverView;
@property(nonatomic,strong)UILabel *introLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *descLabel;
@property(nonatomic,strong)UILabel *rTitleLabel;

//Title=&limit=&offset&rid=&sign=33e3696577645da906cd6a378119b243&type=%E7%83%AD%E9%97%A8%E8%8F%9C%E8%B0%B1&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
//cell中afn得传值
//@property(nonatomic,strong)NSString *titleStr;
//@property(nonatomic,strong)NSString *limitStr;
//@property(nonatomic,strong)NSString *offsetStr;
//@property(nonatomic,strong)NSString *ridStr;
//@property(nonatomic,strong)NSString *signStr;
//@property(nonatomic,strong)NSString *typeStr;
//@property(nonatomic,strong)NSString *uidStr;
//@property(nonatomic,strong)NSString *uuidStr;

@end
