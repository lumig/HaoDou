//
//  FoodMenuInfo.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-20.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentListInfo.h"
#import "OtherStuffInfo.h"
#import "MainStuffInfo.h"
#import "ProductInfo.h"
#import "StepsInfo.h"
#import "StuffInfo.h"
#import "TagsInfo.h"
#import "AdInfo.h"
@interface FoodMenuInfo : NSObject
@property(nonatomic,strong)NSMutableArray *commentListArr;
@property(nonatomic,strong)NSMutableArray *otherStuffArr;
@property(nonatomic,strong)NSMutableArray *mainStuffArr;
@property(nonatomic,strong)NSMutableArray *productArr;
@property(nonatomic,strong)NSMutableArray *stuffArr;
@property(nonatomic,strong)NSMutableArray *stepsArr;
@property(nonatomic,strong)NSMutableArray *tagsArr;
@property(nonatomic,strong)NSMutableArray *adArr;

//@property(nonatomic,strong)CommentListInfo          *comListInfo;
//@property(nonatomic,strong)OtherStuffInfo           *otherStuffInfo;
//@property(nonatomic,strong)MainStuffInfo            *mainStuffInfo;
//@property(nonatomic,strong)ProductInfo              *productInfo;
//@property(nonatomic,strong)StepsInfo                *stepsInfo;
//@property(nonatomic,strong)StuffInfo                *stuffInfo;
//@property(nonatomic,strong)TagsInfo                 *tagsInfo;
//@property(nonatomic,strong)AdInfo                   *adInfo;

@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *collection;
@property(nonatomic,strong)NSString *commentCount;
@property(nonatomic,strong)NSArray *commentList;
//@property(nonatomic,strong)NSString *atUserId;
//@property(nonatomic,strong)NSString *atUserName;
//@property(nonatomic,strong)NSString *cid;
//@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *cookTime;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *durationStr;
@property(nonatomic,strong)NSString *favoriteCount;
@property(nonatomic,assign)BOOL hasVideo;
@property(nonatomic,strong)NSString *intro;
@property(nonatomic,assign)BOOL isLike;
@property(nonatomic,strong)NSString *likeCount;
//@property(nonatomic,strong)NSArray *mainStuff;
//@property(nonatomic,strong)NSString *cate;
//@property(nonatomic,strong)NSString *cateId;
//@property(nonatomic,assign)BOOL food_flag;
@property(nonatomic,strong)NSString *idStr;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *typeStr;
//@property(nonatomic,strong)NSString *weightStr;
//@property(nonatomic,strong)NSArray *otherStuff;
@property(nonatomic,strong)NSString *photoCount;
@property(nonatomic,strong)NSArray *photoList;
//@property(nonatomic,strong)NSArray *product;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *pid;
@property(nonatomic,strong)NSString *productCount;
@property(nonatomic,strong)NSString *readyTime;
@property(nonatomic,strong)NSString *recipeId;
@property(nonatomic,strong)NSString *reviewTime;
//@property(nonatomic,strong)NSArray *steps;
@property(nonatomic,strong)NSString *stepPhoto;
//@property(nonatomic,strong)NSArray *tags;
@property(nonatomic,strong)NSString *tips;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *viewCount;
//@property(nonatomic,strong)NSString *vip;
//@property(nonatomic,strong)NSString *image;
//@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString *userCount;
@end
