//
//  RecipeTableViewController.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-17.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)NSInteger index;
@end
