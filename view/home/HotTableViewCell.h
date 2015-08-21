//
//  HotTableViewCell.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-4.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *coverImgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *introLabel;
@property(nonatomic,strong)UILabel *likeCountLabel;
@property(nonatomic,strong)UILabel *viewCountLabel;
@end
