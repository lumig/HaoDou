//
//  WebViewController.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-11.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic,strong)NSString *urlStr;

@property(nonatomic,assign)NSUInteger index;
- (id)initWithIndex:(NSUInteger)index;
@end
