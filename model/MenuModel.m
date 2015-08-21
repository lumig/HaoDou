//
//  MenuModel.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-20.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "MenuModel.h"
#import "AFNetworking.h"
@implementation MenuModel

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _dataArray = [NSMutableArray array];
        _info = [[FoodMenuInfo alloc] init];
    }
    return self;
}

- (void)getFoodMenuWithRid:(NSString *)rid andMenuBlock:(MenuBlock)menuBlock

{
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=&method=Info.getInfo&sessionid=1421672639&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    
    //rid=66576&sign=&uid=&uuid=17EF523E05B42597F70A95681590F28B
    
    NSDictionary *dict = @{@"sign":@"", @"uid":@"", @"uuid":@"17EF523E05B42597F70A95681590F28B"};
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [parameters addEntriesFromDictionary:@{@"rid":rid}];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        NSLog(@"foodmenu%@",responseObject);
        NSDictionary *resultDict = [responseObject objectForKey:@"result"];
        NSDictionary *infoDict = [resultDict objectForKey:@"info"];
//        [self MenuInfoWithMenuDict:infoDict];
        NSArray *keyArr = [infoDict allKeys];
        
        for (NSString *str in keyArr) {
            
            if ([str isEqualToString:@"CommentList"]) {
                NSMutableArray *arr = [NSMutableArray array];
                _info.commentListArr = [[NSMutableArray alloc] init];
                arr = [infoDict objectForKey:@"CommentList"];
                for (NSDictionary *dict in arr) {
                    [_info.commentListArr addObject:[self CommentListInfoWithCommentListDict:dict]];
//                    [[infoDict objectForKey:@"CommentList"] addObject:[self CommentListInfoWithCommentListDict:dict]];
                }
                
            }else
                if ([str isEqualToString:@"MainStuff"])
                {
                    NSMutableArray *arr = [NSMutableArray array];
                    _info.mainStuffArr = [[NSMutableArray alloc]init];
                    
                    arr = [infoDict objectForKey:@"MainStuff"];
                    for (NSDictionary *dict in arr)
                    {
                        [_info.mainStuffArr addObject:[self MainStuffInfoWithMainStuffDict:dict]];
//                        [[infoDict objectForKey:@"MainStuff"] addObject:[self MainStuffInfoWithMainStuffDict:dict]];
                        
                    }
                    NSLog(@"mainStuffArr = %@",_info.mainStuffArr);
                    
                }
                else
                    if ([str isEqualToString:@"OtherStuff"]) {
                        NSMutableArray *arr = [NSMutableArray array];
                        arr = [infoDict objectForKey:@"OtherStuff"];
                        _info.otherStuffArr = [NSMutableArray array];
                        for (NSDictionary *dict in arr) {
                            [_info.otherStuffArr addObject:[self OtherStuffInfoWithOtherStuffDict:dict]];
                        }
                        
                    } else
                        if ([str isEqualToString:@"Product"]) {
                            NSMutableArray *arr = [NSMutableArray array];
                            _info.productArr = [[NSMutableArray alloc] init];
                            arr = [infoDict objectForKey:@"Product"];
                            for (NSDictionary *dict in arr) {
                                [_info.productArr addObject:[self ProductInfoWithProductDict:dict]];
                            }
                            
                        }
                        else
                            if ([str isEqualToString:@"Steps"]) {
                                NSMutableArray *arr = [NSMutableArray array];
                                _info.stepsArr = [[NSMutableArray alloc] init];
                                arr = [infoDict objectForKey:@"Steps"];
                                for (NSDictionary *dict in arr) {
                                    [_info.stepsArr addObject:[self StepsInfoWithStepsDict:dict]];
                                }
                                
                            }
                            else
                                if ([str isEqualToString:@"Stuff"]) {
                                    NSMutableArray *arr = [NSMutableArray array];
                                    _info.stepsArr = [[NSMutableArray alloc] init];
                                    arr = [infoDict objectForKey:@"Stuff"];
                                    for (NSDictionary *dict in arr) {
                                        [_info.stuffArr addObject:[self StuffInfoWithStuffDict:dict]];
                                    }
                                    
                                }else
                                    if ([str isEqualToString:@"Tags"]) {
                                        NSMutableArray *arr = [NSMutableArray array];
                                        _info.tagsArr = [[NSMutableArray alloc] init];
                                        arr = [infoDict objectForKey:@"Tags"];
                                        for (NSDictionary *dict in arr) {
                                            [_info.tagsArr addObject:[self TagsInfoWithTagsDict:dict]];
                                        }
                                        
                                    }
            
            
            
        }
        [self MenuInfoWithMenuDict:infoDict];
//        [_dataArray addObject:[self MenuInfoWithMenuDict:infoDict]];
        if (menuBlock)
        {
            menuBlock(YES,_info);
        }
        else
        {
            menuBlock(NO,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (FoodMenuInfo *)MenuInfoWithMenuDict:(NSDictionary *)dict
{
//    FoodMenuInfo *info = [[FoodMenuInfo alloc] init];
    _info.avatar = [dict objectForKey:@"Avatar"];
    _info.collection = [dict objectForKey:@"Collection"];
//    info.commentListArr = [dict objectForKey:@"CommentList"];
    _info.cookTime = [dict objectForKey:@"CookTime"];
    _info.cover = [dict objectForKey:@"Cover"];
    _info.durationStr = [dict objectForKey:@"Duration"];
    _info.favoriteCount = [dict objectForKey:@"FavoriteCount"];
    _info.intro = [dict objectForKey:@"Intro"];
    _info.likeCount = [dict objectForKey:@"LikeCount"];
//    info.otherStuffArr = [dict objectForKey:@"OtherStuff"];
//    info.mainStuffArr = [dict objectForKey:@"MainStuff"];
    _info.photoCount = [dict objectForKey:@"PhotoCount"];
    _info.photoList = [dict objectForKey:@"PhotoList"];
//    info.productArr = [dict objectForKey:@"product"];
    _info.productCount = [dict objectForKey:@"ProductCount"];
    _info.readyTime = [dict objectForKey:@"ReadyTime"];
    _info.recipeId = [dict objectForKey:@"RecipeId"];
    _info.reviewTime = [dict objectForKey:@"ReviewTime"];
//    info.stepsArr = [dict objectForKey:@"Steps"];
//    info.stuffArr = [dict objectForKey:@"Stuff"];
//    info.tagsArr = [dict objectForKey:@"Tags"];
    _info.tips = [dict objectForKey:@"Tips"];
    _info.titleStr = [dict objectForKey:@"Title"];
    _info.typeStr = [dict objectForKey:@"Type"];
    _info.userId = [dict objectForKey:@"UserId"];
    _info.userName = [dict objectForKey:@"UserName"];
    _info.viewCount = [dict objectForKey:@"ViewCount"];
    _info.userCount = [dict objectForKey:@"UserCount"];
//    info.adArr = [dict objectForKey:@"ad"];
    
    return _info;
}

- (CommentListInfo *)CommentListInfoWithCommentListDict:(NSDictionary *)dict
{
    CommentListInfo *info = [[CommentListInfo alloc] init];
    info.atUserId = [dict objectForKey:@"AtUserId"];
    info.atUserName = [dict objectForKey:@"AtUserName"];
    info.avatar = [dict objectForKey:@"Avatar"];
    info.cid = [dict objectForKey:@"Cid"];
    info.content = [dict objectForKey:@"Content"];
    info.createTime = [dict objectForKey:@"CreateTime"];
    info.userId = [dict objectForKey:@"UserId"];
    info.username = [dict objectForKey:@"UserName"];
    return info;
}

- (MainStuffInfo *)MainStuffInfoWithMainStuffDict:(NSDictionary *)dict
{
    MainStuffInfo *info = [[MainStuffInfo alloc] init];
    info.cate = [dict objectForKey:@"cate"];
    info.cateId = [dict objectForKey:@"cateId"];
    info.idStr = [dict objectForKey:@"id"];
    info.nameStr = [dict objectForKey:@"name"];
    info.typeStr = [dict objectForKey:@"type"];
    info.weightStr = [dict objectForKey:@"weight"];
    
    return info;

}

- (OtherStuffInfo *)OtherStuffInfoWithOtherStuffDict:(NSDictionary *)dict
{
    OtherStuffInfo *info = [[OtherStuffInfo alloc] init];
    info.cate = [dict objectForKey:@"cate"];
    info.cateId = [dict objectForKey:@"cateId"];
    info.idStr = [dict objectForKey:@"id"];
    info.nameStr = [dict objectForKey:@"name"];
    info.typeStr = [dict objectForKey:@"type"];
    info.weightStr = [dict objectForKey:@"weight"];
    
    return info;
}

- (ProductInfo *)ProductInfoWithProductDict:(NSDictionary *)dict
{
    ProductInfo *info = [[ProductInfo alloc] init];
    info.content = [dict objectForKey:@"Content"];
    info.Img = [dict objectForKey:@"Img"];
    info.pid = [dict objectForKey:@"Pid"];
    info.userId = [dict objectForKey:@"UserId"];
    info.userName = [dict objectForKey:@"UserName"];
    
    return info;
}

- (StepsInfo *)StepsInfoWithStepsDict:(NSDictionary *)dict
{
    StepsInfo *info = [[StepsInfo alloc] init];
    info.intro = [dict objectForKey:@"Intro"];
    info.stepPhoto = [dict objectForKey:@"StepPhoto"];
    return info;
}

- (StuffInfo *)StuffInfoWithStuffDict:(NSDictionary *)dict
{
    StuffInfo *info = [[StuffInfo alloc] init];
    info.cate = [dict objectForKey:@"cate"];
    info.cateId = [dict objectForKey:@"cateId"];
    info.idStr = [dict objectForKey:@"id"];
    info.nameStr = [dict objectForKey:@"name"];
    info.typeStr = [dict objectForKey:@"type"];
    info.weightStr = [dict objectForKey:@"weight"];
    
    return info;
}

- (TagsInfo *)TagsInfoWithTagsDict:(NSDictionary *)dict
{
    TagsInfo *info = [[TagsInfo alloc] init];
    info.idStr = [dict objectForKey:@"Id"];
    info.name = [dict objectForKey:@"Name"];
    return info;
}

- (AdInfo *)AdInfoWithAdDict:(NSDictionary *)dict
{
    AdInfo *info = [[AdInfo alloc] init];
    info.image = [dict objectForKey:@"Image"];
    info.title = [dict objectForKey:@"Title"];
    info.url = [dict objectForKey:@"Url"];
    return info;
}

@end
