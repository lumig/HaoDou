//
//  LoginfModel.m
//  HaoDou
//
//  Created by Lu Ming on 15-2-20.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "LoginfModel.h"
#import "AFNetworking.h"


@implementation LoginfModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
        self.dataArray = [NSMutableArray array];
    }
    return self;
}


- (void)getLoginDataWithPhone:(NSString *)phone andLoginBlock:(LoginBlock)loginBlcok
{
    NSString *urlString = @"http://api.hoto.cn/index.php?appid=4&appkey=573bbd2fbd1a6bac082ff4727d952ba3&channel=appstore&deviceid=0F607264FC6318A92B9E13C65DB7CD3C%7CD7CF225C-9050-4985-A7A5-8A55FB4BD6AD%7C9A779B15-FDD5-47BC-BE72-50F4918325CE&format=json&loguid=&method=Common.sendCode&sessionid=1424355795&uuid=17EF523E05B42597F70A95681590F28B&vc=31&vn=v4.5.0";
    //phone=18321080085&sign=&uid=&uuid=17EF523E05B42597F70A95681590F28B
    NSDictionary *dict = @{@"sign":@"",@"uid":@"",@"uuid":@"17EF523E05B42597F70A95681590F28B"};
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:dict];
    [parameter addEntriesFromDictionary:@{@"phone":phone}];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

@end
