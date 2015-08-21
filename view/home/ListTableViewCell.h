//
//  ListTableViewCell.h
//  cellbtnDemo
//
//  Created by Lu Ming on 15-1-13.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol ListTableViewCellDelegata <NSObject>
//
//- (void)likeBtnClickChange:(UIButton *)btn;
//
//@end

@interface ListTableViewCell : UITableViewCell

//@property(nonatomic,copy)id<ListTableViewCellDelegata>delegate;

@property(nonatomic,strong)UIImageView *coverView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIImageView *likeImgView;
@property(nonatomic,strong)UILabel *introLab;
@property(nonatomic,strong)UIImageView *bigLabView;
@property(nonatomic,strong)UIImageView *showLabView;
@property(nonatomic,strong)UILabel *showLab;
@property(nonatomic,assign)BOOL isClick;



@end
