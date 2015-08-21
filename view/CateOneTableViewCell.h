//
//  CateOneTableViewCell.h
//  HaoDou
//
//  Created by Lu Ming on 15-2-8.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CateView.h"
@protocol CateOneTableViewCellDelegate <NSObject>

- (void)CateOneTableViewCellDidClicked:(NSInteger)index;

@end
@interface CateOneTableViewCell : UITableViewCell
@property(nonatomic,assign)id<CateOneTableViewCellDelegate> delegate;

@property(nonatomic,strong)CateView *cateOneImgView;
@property(nonatomic,strong)CateView *cateTwoImgView;
@property(nonatomic,strong)CateView *cateThreeImgView;
@property(nonatomic,strong)CateView *cateFourImgView;

@end
