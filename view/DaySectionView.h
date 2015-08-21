//
//  DaySectionView.h
//  HaoDou
//
//  Created by Lu Ming on 15-2-13.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "listInfo.h"
@interface DaySectionView : UIView
@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong) UIImageView *avaterIcon;
@property(nonatomic,strong)UILabel *createTimeLabel;
@property(nonatomic,strong)UILabel *positionLabel;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UIImageView *positionImgView;

- (void)daySectionFillInfo:(listInfo *)info;
@end
