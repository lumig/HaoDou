//
//  LoginfModel.h
//  HaoDou
//
//  Created by Lu Ming on 15-2-20.
//  Copyright (c) 2015年 Lu Ming. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LoginBlock)(BOOL isSucess, NSMutableArray *dataArray);
@interface LoginfModel : NSObject

@property(nonatomic,strong)NSMutableArray *dataArray;

//phone=18321080085&sign=&uid=&uuid=17EF523E05B42597F70A95681590F28B
- (void)getLoginDataWithPhone:(NSString *)phone andLoginBlock:(LoginBlock)loginBlcok;
@end
