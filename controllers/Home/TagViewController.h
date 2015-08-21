//
//  TagViewController.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-7.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)NSInteger tagId;

- (id)initWithTag:(NSUInteger)tageID;

@end
