//
//  DayView.h
//  HaoDou
//
//  Created by Lu Ming on 15-2-8.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DayViewDelegate <NSObject>

- (void)DayViewDidClicked:(UITapGestureRecognizer *)sender;

@end


@interface DayView : UIView
@property(nonatomic,assign) id<DayViewDelegate> delegate;
@property(nonatomic,strong)UIImageView *themeCoverImgView;
@property(nonatomic,strong)UILabel *themeTitleLab;
@property(nonatomic,strong)UILabel *photoCountLab;

//
- (id)initWithDayViewFrame:(CGRect)frame ;
@end
