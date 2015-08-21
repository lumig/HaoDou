//
//  DayCell.h
//  HaoDou
//
//  Created by Lu Ming on 15-2-13.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "contentInfo.h"
#import "listInfo.h"

@protocol DayCellDelegate <NSObject>

- (void)DayCellDidClicked:(NSInteger)index;
- (void)dayCellBtnDidClicked:(NSUInteger)index;

@end
@interface DayCell : UITableViewCell
@property(nonatomic,assign)id<DayCellDelegate> delegate;

@property(nonatomic,strong)UIImageView *photoImgView;
@property(nonatomic,strong)UIButton *titleBtn;
@property(nonatomic,strong)UIImageView *arrowRightImgView;
@property(nonatomic,strong)UIImageView *diggImgView;
@property(nonatomic,strong)UIButton *diggLabelBtn;
@property(nonatomic,strong)UIImageView *commentImgView;
@property(nonatomic,strong)UIButton *connentLabelBtn;
@property(nonatomic,strong)UILabel *introLab;//晚餐后面的文本
@property(nonatomic,strong)UILabel *allCommentLabel;
@property(nonatomic,strong)UIButton *userLabelBtn;
@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)UIButton *diggBtn;
@property(nonatomic,strong)UIButton *conntentBtn;
@property(nonatomic,strong)UIButton *shareBtn;


- (void)cellForFillListInfo:(listInfo *)info;
+ (CGFloat)heightForCommentInfo:(listInfo *)info;
+ (CGSize)stringBoundingRectWithSize:(CGSize)contentSize font:(UIFont *)font text:(NSString *)text;
@end
