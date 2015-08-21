//
//  SearchViewController.h
//  HaoDou
//
//  Created by Lu Ming on 14-12-25.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMDatabase;
@interface SearchViewController : UITabBarController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    FMDatabase *_db;
}
@end
