//
//  LMDataManger.m
//  HaoDou
//
//  Created by Lu Ming on 15-1-3.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import "LMDataManger.h"

FMDatabase *db = nil;

@implementation LMDataManger
//创建db的路径
+(NSString *)dbFilePath
{
    NSLog(@"document%@",NSHomeDirectory());
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/historyData.sqlite"];
    
    
}


+(FMDatabase *)getDataBase
{
    //第一次打开数据库时，db对象不存在，需要创建
    if (db == nil) {
        db = [FMDatabase databaseWithPath:[self dbFilePath]] ;
    }
    return db;
    
}

+(void)createTable
{
    if (![db open]) {
        //抛出异常，并同时显示出错的文件、代码和调用函数等信息
        NSAssert(NO, @"数据库打开失败");
    }
    //设置是否缓存数据
    [db setShouldCacheStatements:YES];
    
    //判断表是否存在
    if (![db tableExists:@"history"])
    {
        //这里的TEXT是指文本的意思，integer 表示整型，如age  integer
        if (![db executeUpdate:@"create table if not exists history(id INTEGER PRIMARY KEY, title TEXT);"])
        {
            NSLog(@"数据表创建失败");
        }
    }
    
}

+ (void)addHistoryData:(NSString *)title
{
    if (![db open]) {
        NSAssert(NO, @"数据库打开失败");
    }
    
    if (![db tableExists:@"history"]) {
        [self createTable];
    }
    NSString *sql = [NSString stringWithFormat:@"select count(*) from history where title = '%@'",title];
    FMResultSet *result = [db executeQuery:sql];
    int count = 0;
    if ([result next]) {
        count = [result intForColumn:@"count(*)"];
        if (count < 1) {
            
            
            [db executeQuery:@"delect from history where title = '清空历史记录'"];
            
            if(![db executeUpdate:@"insert into history (title) values (?)",
                 title])
            {
                NSLog(@"插入数据失败");
            }
            if(![db executeUpdate:@"insert into history title = ‘清空历史记录’",
                 title])
            {
                NSLog(@"插入数据失败");
            }
            
            [db close];
        }else
        {
            [db close];
        }
    }
    
    //?对应的字段值必须是（OC中字符串）
    //简写了
//     if(![db executeUpdate:@"insert into history (title) values (?)",
//          title])
//    {
//        NSLog(@"插入数据失败");
//    }
//    [db close];
}

+(NSMutableArray *)getAllHistory
{
    if (![db open]) {
        NSAssert(NO, @"数据库打开失败");
    }
    
    if (![db tableExists:@"history"]) {
        return nil;
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    
    FMResultSet *rs = [db executeQuery:@"select * from history order by id desc;"];
    //遍历所有满足条件的好友记录
    
    while([rs next])
    {
        NSString * str = [[NSString alloc] init];
        str = [rs stringForColumn:@"title"];
      
        //保存好友记录
        [array addObject:str];
    }
    [db close];
    
    return array;
}

+(void)deleteAllHistory
{
    
    if (![db open]) {
        NSAssert(NO, @"数据库打开失败");
    }
    
    if (![db tableExists:@"history"]) {
        NSLog(@"数据表不存在，不要删除");
    }
    
    [db executeUpdate:@"delete from history "];
//    {
//        NSLog(@"删除历史记录成功！");
//    }
    
    [db close];
}

@end
