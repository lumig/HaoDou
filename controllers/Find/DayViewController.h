//
//  DayViewController.h
//  HaoDou
//
//  Created by Lu Ming on 15-2-11.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayCell.h"
#import "DaySectionView.h"

@interface DayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DayCellDelegate>

@property(nonatomic,strong)NSString *titleString;
@end
