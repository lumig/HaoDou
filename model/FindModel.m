//
//  FindModel.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-7.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "FindModel.h"
#import "AFNetworking.h"
#import "DayInfo.h"
#import "ActInfo.h"
#import "LearnInfo.h"
#import "FindUserInfo.h"
#import "CateInfo.h"
#import "InInfo.h"
#import "resultInfo.h"
#import "listInfo.h"
#import "contentInfo.h"

@implementation FindModel

 - (instancetype)init
{
    self = [super init];
    if (self) {
        //
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dayDataWithId:(NSString *)idStr andLimit:(NSString *)limit andOffset:(NSString *)offset andPid:(NSString *)pid andSign:(NSString *)sign andSort:(NSString *)sort andType:(NSString *)type andUid:(NSString *)uid andUuid:(NSString *)uuid andFindBlock:(FindBock)findBlock
{
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=&method=Recipephoto.getProducts&sessionid=1423662469&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    //id=3&limit=10&offset=0&pid=1704305&sign=&sort=1704305&type=1&uid=&uuid=17EF523E05B42597F70A95681590F28B
    NSDictionary *parameter = @{@"id":idStr ,@"limit": limit,@"offset":offset ,@"pid":pid ,@"sign":sign ,@"sort":sort ,@"type":type ,@"uid":uid ,@"uuid":uuid };
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    [manger POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSLog(@"dayData%@",responseObject);
        
        NSDictionary *resultDict = [responseObject objectForKey:@"result"];
        
        /// get allkeys
        NSArray *keyArr = [resultDict allKeys];
        for (NSString *str in keyArr) {
            //
            if ([str isEqualToString:@"count"]) {
//                [_dataArray addObject:[self resultInfoWithResultDict:[resultDict objectForKey:@"count"]]];
                [_dataArray addObject:[resultDict objectForKey:@"count"]];
            }
            
            if ([str isEqualToString:@"info"]) {
                [_dataArray addObject:[self infoWithInfoDic:[resultDict objectForKey:@"info"]]];
            }
            
            if ([str isEqualToString:@"list"]) {
                //
                NSArray *arr = [NSArray array];
                arr = [resultDict objectForKey:@"list"];
                
                for (NSMutableDictionary *dic in arr) {
//                    NSArray *commentArr = [NSArray array];
//                    NSMutableArray *commArr = [[NSMutableArray alloc] init];
//                    commentArr = [dic objectForKey:@"Comment"];
//                    if (commentArr.count > 0) {
//                        for (NSDictionary *commentDict in commentArr) {
//                            
//                           [commArr addObject: [self contentInfoWithContentDict:commentDict]];
//                            
//                        }
//                        
//                    }
//                    [dic setValue:commArr forKey:@"Comment"];
                   [_dataArray addObject:[self listInfoWithListDict:dic] ];
                }
            }
        }
        
        if (findBlock) {
            findBlock(YES,_dataArray);
        }
        else
        {
            findBlock(NO,nil);
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"%@",error);
    }];

}

- (void)getFindDataWithCacheKey:(NSString *)cacheKey andSign:(NSString *)sign andUid:(NSString *)uid andUuid:(NSString *)uuid andFindBlock:(FindBock)findBlock
{
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=&method=Recipe.getFindRecipe&sessionid=1423294980&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    //cacheKey=Recipe.getFindRecipe&sign=&uid=&uuid=17EF523E05B42597F70A95681590F28B

    NSDictionary *parameter = @{@"cacheKey":cacheKey,@"sign":sign,@"uid":uid,@"uuid":uuid};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        NSLog(@"magi%@",responseObject);
        NSDictionary *resultDic = [responseObject objectForKey:@"result"];
        
        NSArray *dayArr = [resultDic objectForKey:@"list"];

        for (int i = 0; i < 7; i++) {
            //
            NSDictionary *dict = [dayArr objectAtIndex:i];
            

            switch (i) {
                case 0:{
                    NSMutableArray *array = [NSMutableArray array];

                    //
//                    NSMutableArray *arr = [dict objectForKey:@"List"];
                    for (NSDictionary *dic in [dict objectForKey:@"List"]) {
                        [array addObject:[self dayInfoWithDayDic:dic]];
                        
                    }
                    [_dataArray addObject:array];
                }
                    break;
                   
                case 1:
                {
                    [_dataArray addObject:[self actInfoWithActDic:dict]];
                }
                    break;
                    
                case 2:
                {
                    [_dataArray addObject:[self learnInfoWithLearnDic:dict]];
                }
                    break;
                
                case 3:
                {
                    [_dataArray addObject:[self actInfoWithActDic:dict]];
                }
                    break;
                case 4:
                {
                    NSMutableArray *array = [NSMutableArray array];

                    for (NSDictionary *dic in [dict objectForKey:@"List"]) {
                        [array addObject:[self cateInfoWithCateDic:dic]];
                    }
                    [_dataArray addObject:array];
                }
                    break;
                case 5:
                {
                    NSMutableArray *array = [NSMutableArray array];
                    
                    for (NSDictionary *dic in [dict objectForKey:@"List"]) {
                        [array addObject:[self cateInfoWithCateDic:dic]];
                    }
                    [_dataArray addObject:array];
                }
                    break;
                case 6:
                {
                    NSMutableArray *array = [NSMutableArray array];
                    
                    for (NSDictionary *dic in [dict objectForKey:@"List"]) {
                        [array addObject:[self findUserInfoWithUserDic:dic]];
                    }
                    [_dataArray addObject:array];
                }
                    break;
                default:
                    break;
            }
        }
        
        
        if (findBlock) {
            findBlock(YES,_dataArray);
        }
        else
        {
            findBlock(NO,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (DayInfo *)dayInfoWithDayDic:(NSDictionary *)dict
{
    DayInfo *info = [[DayInfo alloc] init];
    info.openUrl = [dict objectForKey:@"OpenUrl"];
    info.photoCount = [dict objectForKey:@"PhotoCount"];
    info.photoFixCount = [dict objectForKey:@"PhotoFixCount"];
    info.pid = [dict objectForKey:@"Pid"];
    info.themeCover = [dict objectForKey:@"ThemeCover"];
    info.themeTitle = [dict objectForKey:@"ThemeTitle"];
    info.topicId = [dict objectForKey:@"TopicId"];
    return info;
}

- (LearnInfo *)learnInfoWithLearnDic:(NSDictionary *)dict
{
    LearnInfo *info = [[LearnInfo alloc] init];
    info.intro = [dict objectForKey:@"Intro"];
    info.itemType = [dict objectForKey:@"ItemType"];
    info.list = [dict objectForKey:@"List"];
    info.openUrl = [dict objectForKey:@"OpenUrl"];
    info.recipeCover = [dict objectForKey:@"RecipeCover"];
    info.recipeId = [dict objectForKey:@"RecipeId"];
    info.title = [dict objectForKey:@"Title"];
    info.topId = [dict objectForKey:@"TopicId"];
    info.userAvater = [dict objectForKey:@"UserAvatar"];
    info.userId = [dict objectForKey:@"UserId"];
    info.userName = [dict objectForKey:@"UserName"];
    return info;
}

- (ActInfo *)actInfoWithActDic:(NSDictionary *)dict
{
    ActInfo *info = [[ActInfo alloc] init];
    info.actImg = [dict objectForKey:@"ActImg"];
    info.itemType = [dict objectForKey:@"ItemType"];
    info.openUrl = [dict objectForKey:@"OpenUrl"];
    info.type = [dict objectForKey:@"Type"];
    return info;
}

- (ActInfo *)actSencondInfoWithActDic:(NSDictionary *)dict
{
    ActInfo *info = [[ActInfo alloc] init];
    info.actImg = [dict objectForKey:@"ActImg"];
    info.itemType = [dict objectForKey:@"ItemType"];
    info.openUrl = [dict objectForKey:@"OpenUrl"];
    info.type = [dict objectForKey:@"Type"];
    return info;
}

- (CateInfo *)cateInfoWithCateDic:(NSDictionary *)dict
{
    CateInfo *info = [[CateInfo alloc] init];
    info.count = [dict objectForKey:@"Count"];
    info.cover = [dict objectForKey:@"Cover"];
    info.idStr = [dict objectForKey:@"Id"];
    info.openUrl = [dict objectForKey:@"OpenUrl"];
    info.userName = [dict objectForKey:@"UserName"];
    return info;
}

- (FindUserInfo *)findUserInfoWithUserDic:(NSDictionary *)dict
{
    FindUserInfo *info = [[FindUserInfo alloc] init];
    info.avater = [dict objectForKey:@"Avater"];
    info.openUrl = [dict objectForKey:@"OpenUrl"];
    info.userId = [dict objectForKey:@"UserId"];
    info.userName = [dict objectForKey:@"UserName"];
    return info;
}
- (InInfo *)infoWithInfoDic:(NSDictionary *)dict
{
    InInfo *info1 = [[InInfo alloc] init];
    info1.content = [dict objectForKey:@"Content"];
    info1.count = [dict objectForKey:@"Count"];
    info1.cover = [dict objectForKey:@"Cover"];
    info1.date = [dict objectForKey:@"Date"];
    info1.idStr = [dict objectForKey:@"Id"];
    info1.titleStr = [dict objectForKey:@"Title"];
    return info1;
}

//warning
- (resultInfo *)resultInfoWithResultDict:(NSDictionary *)dict
{
    resultInfo *info = [[resultInfo alloc] init];
    info.countStr = [dict objectForKey:@"Count"];
    
    return info;
}

- (listInfo *)listInfoWithListDict:(NSDictionary *)dict
{
    listInfo *info = [[listInfo alloc] init];
    info.atUser = [dict objectForKey:@"AtUser"];
    info.avatar = [dict objectForKey:@"Avatar"];
    info.comment = [dict objectForKey:@"Comment"];
    info.commentCount = [dict objectForKey:@"CommentCount"];
    info.createTime = [dict objectForKey:@"CreateTime"];
    info.digg = [dict objectForKey:@"Digg"];
    info.hasVideo = [dict objectForKey:@"HasVideo"];
    info.intro = [dict objectForKey:@"Intro"];
    info.isDigg = [dict objectForKey:@"IsDigg"];
    info.photoUrl = [dict objectForKey:@"PhotoUrl"];
    info.pid = [dict objectForKey:@"Pid"];
    info.position = [dict objectForKey:@"Position"];
    info.rTitle = [dict objectForKey:@"RTitle"];
    info.rid = [dict objectForKey:@"Rid"];
    info.timeStr = [dict objectForKey:@"TimeStr"];
    info.titleStr = [dict objectForKey:@"Title"];
    info.topicId = [dict objectForKey:@"TopicId"];
    info.topicName = [dict objectForKey:@"TopicName"];
    info.userName = [dict objectForKey:@"UserName"];
    info.userId = [dict objectForKey:@"UserId"];
    return info;
}

- (contentInfo *)contentInfoWithContentDict:(NSDictionary *)dict
{
    contentInfo *info = [[contentInfo alloc] init];
    info.content = [dict objectForKey:@"Content"] ;
    info.userId = [dict objectForKey:@"UserId"];
    info.userName = [dict objectForKey:@"UserName"];
    return info;
}




@end
