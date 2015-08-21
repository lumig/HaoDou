//
//  StepImgViewController.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-25.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepImgViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *stepArray;
@property(nonatomic,assign)NSInteger index;
@end
