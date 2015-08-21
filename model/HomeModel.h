//
//  HomeModel.h
//  HaoDou
//
//  Created by Lu Ming on 14-12-25.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeInfo.h"
//定义Block
//这里的Block可以设置为返回多个参数
typedef void (^TagBlock)(BOOL isSucess,NSMutableArray *dataDic);
typedef void (^HomeBlock)(BOOL isSucess, NSMutableArray *dataDic);
typedef void (^SearchBlock)(BOOL isSucess, NSMutableArray *dataDic);
typedef void (^AidBlock)(BOOL isSucess,NSMutableArray *dataArr);
typedef void (^TitleBlock)(BOOL isSucess, NSMutableArray *dataArr);

@interface HomeModel : NSObject

@property(nonatomic,assign)NSInteger offset;
@property(nonatomic, strong)NSMutableArray *dataArray;
//数组中存一个字典，字典中有两个key
- (void)refreshData:(HomeBlock)homeBlock;
- (void)getSearchData:(SearchBlock)searchBlock;
- (void)getHotData:(HomeBlock)homeBlock;
//返回点击tag后的数据
- (void)getTagDataWithLimit:(NSString *)limit andOffset:(NSString *)offset andScene:(NSString *)scene andSign:(NSString *)sign andTagid:(NSString *)tagid andUid:(NSString *)uid andUuid:(NSString *)uuid TagBlock:(TagBlock)tagBlock;

//获得专辑中的数据
- (void)getAidDataWithAid:(NSString *)aid andLimit:(NSString *)limit andOffset:(NSString *)offset andSign:(NSString *)sign andUid:(NSString *)uid andUuid:(NSString *)uuid andAidBlock:(AidBlock)aidBlock;

//获得热门等的数据
- (void)getTitleWithTitle:(NSString *)title andLimit:(NSString *)limit andOffset:(NSString *)offset andRid:(NSString *)rid andSign:(NSString *)sign andType:(NSString *)type andUid:(NSString *)uid andUuid:(NSString *)uuid andTitleBlock:(TitleBlock)titleBlock;
//这个是获得更多榜单下面的数据，后期只要改变一个id就能传值

//更多榜单,反馈意见


- (void)getRankMoreWithLimit:(NSString *)limit andOffset:(NSString *)offset andTagid:(NSString *)tagid andType:(NSString *)type andHomeBlock:(HomeBlock)homeBlock;

- (void)RefreshgetRankMoreWithLimit:(NSString *)limit andTagid:(NSString *)tagid andType:(NSString *)type andHomeBlock:(HomeBlock)homeBlock;
//- (HomeInfo *)getHomeDataWithMethod



//获取rankmore的相关数据
//- (void)getRankMoreWithMethod:(NSString *)method andLimit:(NSString *)limit andOffset:(NSString *)offset andTagid:(NSString *)tagid andType:(NSString *)type andHomeBlock:(HomeBlock)homeBlock;
//首页rankmore下的三个，后面会复用，统统id来传值
- (void)getRankDetailWithId:(NSString *)idStr andHomeBlock:(HomeBlock)homeBlock;
//keyword

- (void)getBtnDetailWithKeyWord:(NSString *)keyword andHomeBlock:(HomeBlock)homeBlock;

//rid=66576&sign=&uid=&uuid=17EF523E05B42597F70A95681590F28B

//- (void)getFoodMenuWithRid:(NSString *)rid andHomeBlock:(HomeBlock)homeBlock;
//反馈

- (void)getFeedBackWithContent:(NSString *)content andHomeBlock:(HomeBlock)homeBlock;

//将字典里的信息用一个对象保存Ad
- (HomeInfo *)homeInfoWithAdDic:(NSDictionary *)dict;
- (HomeInfo *)homeInfoWithAlbumDic:(NSDictionary *)dict;
- (HomeInfo *)homeInfoWithRankDic:(NSDictionary *)dict;
- (HomeInfo *)homeInfoWithRecipeDic:(NSDictionary *)dict;
- (HomeInfo *)homeInfoWithTableDic:(NSDictionary *)dict;
- (HomeInfo *)homeInfoWithTagDic:(NSDictionary *)dict;
- (HomeInfo *)homeInfoWithWikiDic:(NSDictionary *)dict;
- (HomeInfo *)homeInfoWithInfoDic:(NSDictionary *)dict;
- (HomeInfo *)homeInfoWithListDic:(NSDictionary *)dict;
//searcherBar
- (HomeInfo *)homeInfoWithSearchRecipeDic:(NSDictionary *)dict;
- (HomeInfo *)homeInfoWithSearchAlbumDIc:(NSDictionary *)dict;
- (HomeInfo *)homeInfoWithListInfoDic:(NSDictionary *)dict;
//tag
- (HomeInfo *)homeInfoWithTagDIc:(NSDictionary *)dict;


@end
