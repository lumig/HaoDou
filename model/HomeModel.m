//
//  HomeModel.m
//  HaoDou
//
//  Created by Lu Ming on 14-12-25.
//  Copyright (c) 2014年 Lu Ming. All rights reserved.
//
#import "HomeModel.h"
#import "AFNetworking.h"
@implementation HomeModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)getHotData:(HomeBlock)homeBlock
{

    NSString *urlString = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=&method=Search.getHotSearch&sessionid=1422278993&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    
    //sign=&uid=&uuid=17EF523E05B42597F70A95681590F28B

    NSDictionary *parameters = @{@"sign":@"",@"uid":@"",@"uuid":@"17EF523E05B42597F70A95681590F28B"};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //健脾胃
//        NSLog(@"HotData%@",responseObject);
        NSDictionary *resultDict = [responseObject objectForKey:@"result"];
        _dataArray = [resultDict objectForKey:@"list"];
        if (homeBlock) {
            homeBlock(YES,_dataArray);
        }else
        {
            homeBlock(NO,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",[error localizedDescription]);
    }];
    
}



- (void)getSearchData:(SearchBlock)searchBlock
{
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=6832623&method=Search.getSearchIndex&sessionid=1420377506&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
//        NSLog(@"responseObject%@", responseObject);
        
        NSDictionary *resultDict = [responseObject objectForKey:@"result"];
        NSArray *keyArray = [resultDict allKeys];
        
        for (NSString *str in keyArray) {
            if ([str isEqualToString:@"list"]) {
                NSArray *listArr = [resultDict objectForKey:@"list"];
                
                for (NSDictionary *dict in listArr) {
                    
                    [_dataArray addObject:[self homeInfoWithSearchAlbumDIc:dict]];
                }
                //
                //                [_dataArray addObject:@{@"title":@"ad",@"array":array}];
            }else if ([str isEqualToString:@"recipe"]) {
                NSDictionary *albumDict = [resultDict objectForKey:@"recipe"];
                NSDictionary *listDict = [albumDict objectForKey:@"list"];
//                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dict in listDict) {
                    
                    [_dataArray addObject:[self homeInfoWithSearchRecipeDic:dict]];
                }
                //
                //                [_dataArray addObject:@{@"title":@"ad",@"array":array}];
            }
        }
        
        if (searchBlock) {
            searchBlock(YES,_dataArray);
        }
        else
        {
            if (searchBlock) {
                searchBlock(NO, nil);
            }
        }
        

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        if (searchBlock) {
            searchBlock(NO, nil);
        }
        NSLog(@"error:%@",[error localizedDescription]);
    }];

}

- (void)getFeedBackWithContent:(NSString *)content andHomeBlock:(HomeBlock)homeBlock
{
//    NSString *urlStr = @" http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=6832623&method=FeedBack.add&sessionid=1421552484&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0 HTTP/1.1";
    //channel_type=appstore&content=Magi&device_type=iPhone6%2C2&net_type=WiFi&sign=33e3696577645da906cd6a378119b243&soft_version=4.5.0&system_version=IOS%207.1.1&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
    
    
    
}
- (void)getBtnDetailWithKeyWord:(NSString *)keyword andHomeBlock:(HomeBlock)homeBlock
{
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=&method=Search.getList&sessionid=1422278331&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    
    //keyword=%E7%83%A4&limit=20&offset=0&scene=k2&sign=&uid=&uuid=17EF523E05B42597F70A95681590F28B

    NSDictionary *dict = @{@"limit":@"20",@"scene":@"k2",@"uid":@"",@"uuid":@"17EF523E05B42597F70A95681590F28B"};
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [parameters addEntriesFromDictionary:@{@"keyword":keyword,@"offset":@"0"}];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
//        NSLog(@"keywordmagi%@",responseObject);
        
        NSDictionary *resultDict = [responseObject objectForKey:@"result"];
        NSArray *keyArray = [resultDict allKeys];
        
        for (NSString *str in keyArray) {
            if ([str isEqualToString:@"list"]) {
                NSArray *listArr = [resultDict objectForKey:@"list"];
                
                for (NSDictionary *dict in listArr) {
                    
                    [_dataArray addObject:[self homeInfoWithSearchAlbumDIc:dict]];
                }
                
            }
        }
        
        if (homeBlock) {
            homeBlock(YES,_dataArray);
        }
        else
        {
            if (homeBlock) {
                homeBlock(NO, nil);
            }
        }
        

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"%@",[error localizedDescription]);
    }];
}


- (void)getRankDetailWithId:(NSString *)idStr andHomeBlock:(HomeBlock)homeBlock
{
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=6832623&method=Rank.getRankView&sessionid=1421504727&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    //id=27&sign=33e3696577645da906cd6a378119b243&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
    NSDictionary *dict = @{@"sign":@"33e3696577645da906cd6a378119b243",@"uid":@"6832623",@"uuid":@"17EF523E05B42597F70A95681590F28B"};
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [parameters addEntriesFromDictionary:@{@"id":idStr}];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"rankdetail%@",responseObject);
        
        
        NSDictionary *resultDic = [responseObject objectForKey:@"result"];
        NSArray *keyArr = [resultDic allKeys];
        for (NSString *str in keyArr) {
            if ([str isEqualToString:@"info"]) {
                NSDictionary *infoDict = [resultDic objectForKey:@"info"];
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                //                for (NSDictionary *dict in infoDict) {
                //
                //                    [array addObject:[self homeInfoWithInfoDic:dict]];
                //                }
                [array addObject:[self homeInfoWithListDic:infoDict]];
                
                [_dataArray addObject:@{@"title":@"info",@"array":array}];
            }
            
            
            else if ([str isEqualToString:@"list"]) {
                NSDictionary *listDict = [resultDic objectForKey:@"list"];
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dict in listDict) {
                    
                    [array addObject:[self homeInfoWithListDic:dict]];
                }
                //
                [_dataArray addObject:@{@"title":@"list",@"array":array}];
            }
            
        }
        if (homeBlock) {
            homeBlock(YES,_dataArray);
        }
        else
        {
            homeBlock(NO,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];

}

- (void)RefreshgetRankMoreWithLimit:(NSString *)limit andTagid:(NSString *)tagid andType:(NSString *)type andHomeBlock:(HomeBlock)homeBlock
{
    _offset += 10;
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=6832623&method=Rank.getRankList&sessionid=1421504727&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //
    NSDictionary *dict = @{@"sign":@"33e3696577645da906cd6a378119b243",@"uid":@"6832623",@"uuid":@"17EF523E05B42597F70A95681590F28B"};
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [parameters addEntriesFromDictionary:@{@"limit":limit,@"tagid":tagid,@"type":type,@"offset":[NSString stringWithFormat:@"%ld",_offset]}];
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"rankmore%@",responseObject);
        NSDictionary *resultDict = [responseObject objectForKey:@"result"];
        NSArray *keyArr = [resultDict allKeys];
        NSArray *array = [NSArray array];
        for (NSString *str in keyArr) {
            if ([str isEqualToString:@"list"]) {
                array = [resultDict objectForKey:@"list"];
            }
        }
        for (NSDictionary *dict in array) {
            [_dataArray addObject:[self homeInfoWithListDic:dict]];
        }
        
        if (homeBlock) {
            
            homeBlock(YES,_dataArray);
        }else
        {
            _offset -= 10;
            homeBlock(NO,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

}
- (void)getRankMoreWithLimit:(NSString *)limit andOffset:(NSString *)offset andTagid:(NSString *)tagid andType:(NSString *)type andHomeBlock:(HomeBlock)homeBlock
{
    _offset = 0;
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=6832623&method=Rank.getRankList&sessionid=1421504727&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //limit=10&offset=0&sign=33e3696577645da906cd6a378119b243&tagid=0&type=4&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
    NSDictionary *dict = @{@"sign":@"33e3696577645da906cd6a378119b243",@"uid":@"6832623",@"uuid":@"17EF523E05B42597F70A95681590F28B"};
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [parameters addEntriesFromDictionary:@{@"limit":limit,@"offset":offset,@"tagid":tagid,@"type":type}];
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"rankmore%@",responseObject);
        NSDictionary *resultDict = [responseObject objectForKey:@"result"];
        NSArray *keyArr = [resultDict allKeys];
        NSArray *array = [NSArray array];
        for (NSString *str in keyArr) {
            if ([str isEqualToString:@"list"]) {
                array = [resultDict objectForKey:@"list"];
            }
        }
        for (NSDictionary *dict in array) {
            [_dataArray addObject:[self homeInfoWithListDic:dict]];
        }
        
        if (homeBlock) {
            homeBlock(YES,_dataArray);
        }else
        {
            homeBlock(NO,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)getMethodWithMethod:(NSString *)method andLimit:(NSString *)limit andOffset:(NSString *)offset andSign:(NSString *)sign andUid:(NSString *)uid andUuid:(NSString *)uuid andHomeBlock:(HomeBlock)homeBlock
{
    
    
//    NSDictionary *dic = @{@"0":@"0"};
//    
//    NSMutableDictionary *aa = [[NSMutableDictionary alloc]initWithDictionary:dic];
//    [aa addEntriesFromDictionary:@{@"1":@"1"}];
//    
//    NSLog(@"aa = %@",aa);
//api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=6832623&method=Rank.getRankList&sessionid=1421504727&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0
//    limit=10&offset=0&sign=33e3696577645da906cd6a378119b243&tagid=0&type=4&uid=6832623&uuid=17EF523E05B42597F70A95681590F28B
    
}
- (void)getTagDataWithLimit:(NSString *)limit andOffset:(NSString *)offset andScene:(NSString *)scene andSign:(NSString *)sign andTagid:(NSString *)tagid andUid:(NSString *)uid andUuid:(NSString *)uuid TagBlock:(TagBlock)tagBlock
{
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=6832623&method=Search.getList&sessionid=1420855569&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"limit":limit,@"offset":offset,@"scene":scene,@"sign":sign,@"tagid":tagid,@"uid":uid,@"uuid":uuid};
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"posttagDAT%@",responseObject);
        
        NSDictionary *resultDict = [responseObject objectForKey:@"result"];
        NSArray *keyArray = [resultDict allKeys];
        
        for (NSString *str in keyArray) {
            if ([str isEqualToString:@"list"]) {
                NSArray *listArr = [resultDict objectForKey:@"list"];
                
                for (NSDictionary *dict in listArr) {
                    
                    [_dataArray addObject:[self homeInfoWithSearchAlbumDIc:dict]];
                }
        
            }
        }
        
        if (tagBlock) {
            tagBlock(YES,_dataArray);
        }
        else
        {
            if (tagBlock) {
                tagBlock(NO, nil);
            }
        }
        

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",[error localizedDescription]);
    }];

}
- (void)getFoodMenuWithRid:(NSString *)rid andHomeBlock:(HomeBlock)homeBlock

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
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)getAidDataWithAid:(NSString *)aid andLimit:(NSString *)limit andOffset:(NSString *)offset andSign:(NSString *)sign andUid:(NSString *)uid andUuid:(NSString *)uuid andAidBlock:(AidBlock)aidBlock
{
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=6832623&method=Info.getAlbumInfo&sessionid=1421153776&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    NSDictionary *parameters = @{@"aid":aid,@"limit":limit,@"offset":offset,@"sign":sign,@"uid":uid,@"uuid":uuid};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"aiddata%@",responseObject);
        NSDictionary *resultDic = [responseObject objectForKey:@"result"];
        NSArray *keyArr = [resultDic allKeys];
        for (NSString *str in keyArr) {
            if ([str isEqualToString:@"info"]) {
                NSDictionary *infoDict = [resultDic objectForKey:@"info"];
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
//                for (NSDictionary *dict in infoDict) {
//                    
//                    [array addObject:[self homeInfoWithInfoDic:dict]];
//                }
                [array addObject:[self homeInfoWithInfoDic:infoDict]];
                
                [_dataArray addObject:@{@"title":@"info",@"array":array}];
        }
            
            
            else if ([str isEqualToString:@"list"]) {
                    NSDictionary *listDict = [resultDic objectForKey:@"list"];
                    
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    
                    for (NSDictionary *dict in listDict) {
                        
                        [array addObject:[self homeInfoWithListDic:dict]];
                    }
                    //
                    [_dataArray addObject:@{@"title":@"list",@"array":array}];
                }
            
        }
        if (aidBlock) {
            aidBlock(YES,_dataArray);
        }
        else
        {
            aidBlock(NO,nil);
            [_dataArray removeAllObjects];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}
    

- (void)getTitleWithTitle:(NSString *)title andLimit:(NSString *)limit andOffset:(NSString *)offset andRid:(NSString *)rid andSign:(NSString *)sign andType:(NSString *)type andUid:(NSString *)uid andUuid:(NSString *)uuid andTitleBlock:(TitleBlock)titleBlock
{
    NSString *urlStr = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=6832623&method=Recipe.getCollectRecomment&sessionid=1421153776&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    NSDictionary *parameters = @{@"Title":title,@"limit":limit,@"offset":offset,@"rid":rid,@"sign":sign,@"type":type,@"uid":uid,@"uuid":uuid};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"titledata%@", responseObject);
        NSDictionary *resultDict = [responseObject objectForKey:@"result"];
        NSArray *keyArray = [resultDict allKeys];
        
        for (NSString *str in keyArray) {
            if ([str isEqualToString:@"list"]) {
                //ad
                NSDictionary *listDict = [resultDict objectForKey:@"list"];
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dict in listDict) {
                    
                    [array addObject:[self homeInfoWithListInfoDic:dict]];
                }
                //
                [_dataArray addObject:@{@"title":@"list",@"array":array}];
                
            }
        }
        if (titleBlock) {
            titleBlock(YES,_dataArray);
        }else
        {
            titleBlock(NO,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"eroor%@",error);
    }];
}

- (void)refreshData:(HomeBlock)homeBlock
{
    
    NSString *urlString = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=&method=Recipe.getCollectList&sessionid=1419587368&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    
    
//    NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //POST
//    NSDictionary *parameters = @{@"appid": @"4",@"appkey":@"573bbd2fbd1a6bac082ff4727d952ba3",@"channel":@"appstore", @"deviceid":@"0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE", @"format":@"json", @"loguid":@"", @"method":@"Recipe.getCollectList",@"sessionid":@"1419587368", @"uuid":@"17EF523E05B42597F70A95681590F28B", @"vc":@"31", @"vn":@"v4.5.0"};
//    
//    [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"responseObject = %@",responseObject);
//        
//        NSDictionary *dic = [responseObject objectForKey:@"result"];
//        NSLog(@"error%@",[dic objectForKeyedSubscript:@"errormsg"]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",[error localizedDescription]);
//        
//    }];
//    
    
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      NSLog(@"refreshData%@", responseObject);
        
        NSDictionary *resultDict = [responseObject objectForKey:@"result"];
        NSArray *keyArray = [resultDict allKeys];
        
        for (NSString *str in keyArray) {
            if ([str isEqualToString:@"ad"]) {
                //ad
                NSDictionary *adDict = [resultDict objectForKey:@"ad"];
                
                NSMutableArray *array = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dict in adDict) {
                    
                    [array addObject:[self homeInfoWithAdDic:dict]];
                }
                //
                [_dataArray addObject:@{@"title":@"ad",@"array":array}];
                
            }
              else  if ([str isEqualToString:@"album"]) {
                    //album
                    NSDictionary *albumDict = [resultDict objectForKey:@"album"];
                    NSMutableArray *array = [[NSMutableArray alloc] init];
                    for (NSDictionary *dict in albumDict)
                    {
                        
                        [array addObject:[self homeInfoWithAlbumDic:dict]];
                    }
                     [_dataArray addObject:@{@"title":@"album",@"array":array}];
                }
                
               else if ([str isEqualToString:@"rank"]) {
                    //rank
                    NSDictionary *rankDict = [resultDict objectForKey:@"rank"];
                    NSMutableArray *array = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in rankDict) {
                        
                        [array addObject:[self homeInfoWithRankDic:dict]];
                    }
                     [_dataArray addObject:@{@"title":@"rank",@"array":array}];
                }
              else  if ([str isEqualToString:@"recipe"]) {
                    //recipe
                    NSDictionary *recipeDict = [resultDict objectForKey:@"recipe"];
                    NSMutableArray *array = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in recipeDict) {
                        
                        [array addObject:[self homeInfoWithRecipeDic:dict]];
                    }
                     [_dataArray addObject:@{@"title":@"recipe",@"array":array}];
                }
               else if ([str isEqualToString:@"table"]) {
                //table
                NSDictionary *tableDict = [resultDict objectForKey:@"table"];
                NSMutableArray *array = [[NSMutableArray alloc]init];
                for (NSDictionary *dict in tableDict) {
                    
                    [array addObject:[self homeInfoWithTableDic: dict]];
                }
                    [_dataArray addObject:@{@"title":@"table",@"array":array}];
                }
            
              else  if ([str isEqualToString:@"tag"]) {
                    //tag
                    NSDictionary *tagDict = [resultDict objectForKey:@"tag"];
                    NSMutableArray *array = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in tagDict) {
                        
                        [array addObject:[self homeInfoWithTagDic: dict]];
                    }
                    [_dataArray addObject:@{@"title":@"tag",@"array":array}];
                }
                
                else{
                    //wiki
                    NSDictionary *wikiDict = [resultDict objectForKey:@"wiki"];
                    NSMutableArray *array = [[NSMutableArray alloc]init];
                    for (NSDictionary *dict in wikiDict) {
                        
                        [array addObject:[self homeInfoWithWikiDic: dict]];
                    }
                    [_dataArray addObject:@{@"title":@"wiki",@"array":array}];
                }
                
                
            }
     


        
        if (homeBlock) {
            homeBlock(YES,_dataArray);
        }
        else
        {
            if (homeBlock) {
                homeBlock(NO, nil);
            }
        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (homeBlock) {
            homeBlock(NO, nil);
        }
        NSLog(@"error:%@",[error localizedDescription]);
    }];
    
}
//desc 是图片下面的描述
//intro 是图片里面的文本描述


//adInfo
- (HomeInfo *)homeInfoWithAdDic:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];
   
//    NSDictionary *adDict = [resultDict objectForKey:@"ad"];

    info.cover = [dict objectForKey:@"Cover"];
    info.sortIndex = (long *)[[dict objectForKey:@"SortIndex"] integerValue];
    info.type = (kType *)[[dict objectForKey:@"Type"] integerValue];
    info.url = [dict objectForKey:@"Url"];
    
    return info;
    
}

//albumInfo
- (HomeInfo *)homeInfoWithAlbumDic:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];
 
//    NSDictionary *albumDict = [dict objectForKey:@"album"];
    
    info.cover = [dict objectForKey:@"Cover"];
    info.sortIndex = (long *)[[dict objectForKey:@"SortIndex"] integerValue];
    info.type = (kType *)[[dict objectForKey:@"Type"] integerValue];
    info.url = [dict objectForKey:@"Url"];
    info.icon = [dict objectForKey:@"Icon"];
    info.haodouId = [dict objectForKey:@"Id"];
    info.intro = [dict objectForKey:@"Intro"];
    info.smallCover = [dict objectForKey:@"SmallCover"];
    info.title = [dict objectForKey:@"Title"];
    info.urlToList = [dict objectForKey:@"UrlToList"];
    info.tags = [dict objectForKey:@"Tags"];
    
    return info;
}

//rankInfo
-(HomeInfo *)homeInfoWithRankDic:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];

//    NSDictionary *rankDict = [resultDict objectForKey:@"rank"];
    
    info.cover = [dict objectForKey:@"Cover"];
    info.sortIndex = (long *)[[dict objectForKey:@"SortIndex"] integerValue];
    info.type =(kType *)[[dict objectForKey:@"Type"] integerValue];
    info.url = [dict objectForKey:@"Url"];
    info.haodouId = [dict objectForKey:@"Id"];
    info.intro = [dict objectForKey:@"Intro"];
    info.title = [dict objectForKey:@"Title"];
    info.rankType = [dict objectForKey:@"RankType"];
    
    return info;
}

//recipeInfo
- (HomeInfo *)homeInfoWithRecipeDic:(NSDictionary *)dict
{
    
    HomeInfo *info = [[HomeInfo alloc] init];

//    NSDictionary *recipeDict = [resultDict objectForKey:@"recipe"];
    
    info.cover = [dict objectForKey:@"Cover"];
    info.desc = [dict objectForKey:@"Desc"];
    info.icon = [dict objectForKey:@"Icon"];
    info.sortIndex = (long *)[[dict objectForKey:@"SortIndex"]integerValue];
    info.keyWord = [dict objectForKey:@"KeyWord"];
    info.rTitle = [dict objectForKey:@"RTitle"];
    info.type = (kType *)[[dict objectForKey:@"Type"] integerValue];
    info.url = [dict objectForKey:@"Url"];
    info.haodouId = [dict objectForKey:@"Id"];
    info.intro = [dict objectForKey:@"Intro"];
    info.title = [dict objectForKey:@"Title"];
    info.userName = [dict objectForKey:@"UserName"];

    return info;
//Incompatible integer to pointer conversion assigning to 'kType *' from 'NSInteger' (aka 'long')

}

//tableInfo
- (HomeInfo *)homeInfoWithTableDic:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];
 
//    NSDictionary *tableDict = [resultDict objectForKey:@"table"];
    
    info.cover = [dict objectForKey:@"Cover"];
    info.icon = [dict objectForKey:@"Icon"];
    info.sortIndex = (long *)[[dict objectForKey:@"SortIndex"] integerValue];
    info.type = (kType *)[[dict objectForKey:@"Type"] integerValue];
    info.url = [dict objectForKey:@"Url"];
    info.haodouId = [dict objectForKey:@"Id"];
    info.intro = [dict objectForKey:@"Intro"];
    info.title = [dict objectForKey:@"Title"];
    info.urlToList = [dict objectForKey:@"UrlToList"];
    
    return info;
}

//tagInfo
- (HomeInfo *)homeInfoWithTagDic:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];
  
//    NSDictionary *tagDict = [resultDict objectForKey:@"tag"];
    
    info.icon = [dict objectForKey:@"Icon"];
    info.sortIndex = (long *)[[dict objectForKey:@"SortIndex"] integerValue];
    info.type =(kType *)[[dict objectForKey:@"Type"] integerValue];
    info.url = [dict objectForKey:@"Url"];
    info.haodouId = [dict objectForKey:@"Id"];
    info.title = [dict objectForKey:@"Title"];
    info.IdStr = [dict objectForKey:@"Id"];
    return info;
}

//wikiInfo
- (HomeInfo *)homeInfoWithWikiDic:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];

//    NSDictionary *wikiDict = [resultDict objectForKey:@"wiki"];
   
    info.cover = [dict objectForKey:@"Cover"];
    info.icon = [dict objectForKey:@"Icon"];
    info.sortIndex =(long *)[[dict objectForKey:@"SortIndex"] integerValue];
    info.type = (kType *)[[dict objectForKey:@"Type"] integerValue];
    info.intro = [dict objectForKey:@"Intro"];
    info.url = [dict objectForKey:@"Url"];
    info.haodouId = [dict objectForKey:@"Id"];
    info.title = [dict objectForKey:@"Title"];
    info.urlToList = [dict objectForKey:@"UrlToList"];
    
    return info;
}

//searchBarRecipe
- (HomeInfo *)homeInfoWithSearchRecipeDic:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];
    info.cover = [dict objectForKey:@"Cover"];
    info.likeCount = [dict objectForKey:@"LikeCount"];
    info.stuff = [dict objectForKey:@"Stuff"];
    info.title = [dict objectForKey:@"Title"];
    info.viewCount = [dict objectForKey:@"ViewCount"];
    
    return info;
}

- (HomeInfo *)homeInfoWithSearchAlbumDIc:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];
    info.cover = [dict objectForKey:@"Cover"];
    info.intro = [dict objectForKey:@"Intro"];
    info.likeCount = [dict objectForKey:@"LikeCount"];
    info.title = [dict objectForKey:@"Title"];
    info.viewCount = [dict objectForKey:@"ViewCount"];
    info.stuff = [dict objectForKey:@"Stuff"];
    info.recipeId = [dict objectForKey:@"RecipeId"];
    info.keyWord = [dict objectForKey:@"KeyWord"];
    info.IdStr = [dict objectForKey:@"Id"];
    return info;
}

- (HomeInfo *)homeInfoWithInfoDic:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];
    info.albumAvatarUrl = [dict objectForKey:@"AlbumAvatarUrl"];
    info.albumContent = [dict objectForKey:@"AlbumContent"];
    info.albumCover = [dict objectForKey:@"AlbumCover"];
    info.albumTitle = [dict objectForKey:@"AlbumTitle"];
    info.albumUserName = [dict objectForKey:@"AlbumUserName"];
    return info;
}

- (HomeInfo *)homeInfoWithListDic:(NSDictionary *)dict
        {
            HomeInfo *info = [[HomeInfo alloc] init];
            info.collection = [dict objectForKey:@"Collection"];
            info.cover = [dict objectForKey:@"Cover"];
            info.intro = [dict objectForKey:@"Intro"];
            info.likeCount = [dict objectForKey:@"LikeCount"];
            info.viewCount = [dict objectForKey:@"ViewCount"];
            info.stuff = [dict objectForKey:@"Stuff"];
            info.recipeId = [dict objectForKey:@"RecipeId"];
            info.title = [dict objectForKey:@"Title"];
            info.userId = [dict objectForKey:@"UserId"];
            info.userName = [dict objectForKey:@"UserName"];
            info.IdStr = [dict objectForKey:@"Id"];
            
            
            return info;
        }
- (HomeInfo *)homeInfoWithListInfoDic:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];
    info.cover = [dict objectForKey:@"Cover"];
    info.likeCount = [dict objectForKey:@"LikeCount"];
    info.title = [dict objectForKey:@"Title"];
    info.userName = [dict objectForKey:@"UserName"];
    info.tags = [dict objectForKey:@"Tags"];
    info.intro = [dict objectForKey:@"Intro"];
    info.recipeId = [dict objectForKey:@"RecipeId"];
    return info;
    
}

- (HomeInfo *)homeInfoWithTagDIc:(NSDictionary *)dict
{
    HomeInfo *info = [[HomeInfo alloc] init];
    info.icon = [dict objectForKey:@"Icon"];
    info.title = [dict objectForKey:@"Title"];
    info.IdStr = [dict objectForKey:@"Id"];
    return info;
    
}


@end
