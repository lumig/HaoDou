//
//  DayTableViewCell.h
//  HaoDou
//
//  Created by Lu Ming on 15-2-8.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayView.h"

@protocol DayTableViewCellDelegate <NSObject>

- (void)DayTableViewCellDidClicked:(NSInteger)index;

@end
@interface DayTableViewCell : UITableViewCell//<DayViewDelegate>
@property(nonatomic,assign)id<DayTableViewCellDelegate> delegate;
@property(nonatomic,strong)DayView *breakfastDView;
@property(nonatomic,strong)DayView *lunchDView;
@property(nonatomic,strong)DayView *supperDView;

@end
