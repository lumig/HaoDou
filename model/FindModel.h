//
//  FindModel.h
//  HaoDou
//
//  Created by Lu Ming on 15-2-7.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeInfo.h"
#import "DayInfo.h"
#import "ActInfo.h"
#import "LearnInfo.h"
#import "FindUserInfo.h"
#import "CateInfo.h"
#import "InInfo.h"
#import "resultInfo.h"
#import "listInfo.h"
#import "contentInfo.h"


typedef void (^FindBock)(BOOL isSucess , NSMutableArray *dataArray);
@interface FindModel : NSObject
@property(nonatomic,strong)NSMutableArray *dataArray;
//
- (void )getFindDataWithCacheKey:(NSString *)cacheKey andSign:(NSString *)sign andUid:(NSString *)uid andUuid:(NSString *)uuid andFindBlock:(FindBock)findBlock;


- (void)dayDataWithId:(NSString *)idStr andLimit:(NSString *)limit andOffset:(NSString *)offset andPid:(NSString *)pid andSign:(NSString *)sign andSort:(NSString *)sort andType:(NSString *)type andUid:(NSString *)uid andUuid:(NSString *)uuid andFindBlock:(FindBock)findBlock;

- (DayInfo *)dayInfoWithDayDic:(NSDictionary *)dict;
- (ActInfo *)actInfoWithActDic:(NSDictionary *)dict;
- (ActInfo *)actSencondInfoWithActDic:(NSDictionary *)dict;

- (LearnInfo *)learnInfoWithLearnDic:(NSDictionary *)dict;
- (CateInfo *)cateInfoWithCateDic:(NSDictionary *)dict;
- (FindUserInfo *)findUserInfoWithUserDic:(NSDictionary *)dict;

- (InInfo *)infoWithInfoDic:(NSDictionary *)dict;
- (resultInfo *)resultInfoWithResultDict:(NSDictionary *)dict;
- (listInfo *)listInfoWithListDict:(NSDictionary *)dict;
- (contentInfo *)contentInfoWithContentDict:(NSDictionary *)dict;
@end
