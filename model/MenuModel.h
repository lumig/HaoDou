//
//  MenuModel.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-20.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodMenuInfo.h"
#import "CommentListInfo.h"
#import "OtherStuffInfo.h"
#import "MainStuffInfo.h"
#import "ProductInfo.h"
#import "StepsInfo.h"
#import "StuffInfo.h"
#import "TagsInfo.h"
#import "AdInfo.h"

//typedef void (^MenuBlock)(BOOL isSucess, NSMutableArray *dataArray);

typedef void (^MenuBlock)(BOOL isSucess, FoodMenuInfo *info);

@interface MenuModel : NSObject

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)FoodMenuInfo *info;

- (void)getFoodMenuWithRid:(NSString *)rid andMenuBlock:(MenuBlock)menuBlock;

- (FoodMenuInfo *)MenuInfoWithMenuDict:(NSDictionary *)dict;

- (CommentListInfo *)CommentListInfoWithCommentListDict:(NSDictionary *)dict;

- (OtherStuffInfo *)OtherStuffInfoWithOtherStuffDict:(NSDictionary *)dict;

- (MainStuffInfo *)MainStuffInfoWithMainStuffDict:(NSDictionary *)dict;

- (ProductInfo *)ProductInfoWithProductDict:(NSDictionary *)dict;

- (StepsInfo *)StepsInfoWithStepsDict:(NSDictionary *)dict;

- (StuffInfo *)StuffInfoWithStuffDict:(NSDictionary *)dict;

- (TagsInfo *)TagsInfoWithTagsDict:(NSDictionary *)dict;

- (AdInfo *)AdInfoWithAdDict:(NSDictionary *)dict;
@end
