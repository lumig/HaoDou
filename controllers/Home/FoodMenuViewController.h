//
//  FoodMenuViewController.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-24.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,assign)NSUInteger recipeId;
@end
