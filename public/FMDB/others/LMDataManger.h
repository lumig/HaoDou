//
//  LMDataManger.h
//  HaoDou
//
//  Created by Lu Ming on 15-1-3.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"


@interface LMDataManger : NSObject
+(NSString *)dbFilePath;
+(FMDatabase *)getDataBase;
+(void)createTable;
+(void)addHistoryData:(NSString *)title;
//获取所有数据
+(NSMutableArray *)getAllHistory;
+(void)deleteAllHistory;


@end
