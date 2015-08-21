//
//  HaveTwoLabTableViewCell.h
//  HaoDou
//
//  Created by Lu Ming on 14-12-28.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
//HaveTwoLabTableViewCell 指的是除了oneLab以外家里一个icon
//指的是大图上有两个label
@interface HaveTwoLabTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *coverView;
@property(nonatomic,strong)UILabel *introLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *descLabel;
@property(nonatomic,strong)UILabel *rTitleLabel;
@property(nonatomic,strong)UIImageView *iconImgView;

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
