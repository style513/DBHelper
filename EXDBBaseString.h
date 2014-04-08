//
//  EXDBBaseString.h
//  DBHelper
//
//  Created by zhengyj on 14-4-4.
//  Copyright (c) 2014年 zhengyj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXDBBaseString : NSObject

+ (NSString *)createStringWithClassName:(NSString *)className  tableName:(NSString *)tableName unique:(NSString *)unique uniques:(va_list)argList;
+ (NSString *)insertStringWithClass:(id)object VOTableName:(NSString *)voTableName;
+ (NSString *)updateStringWithClass:(id)object value2Key:(NSDictionary *)dictionary;
+ (NSString *)getObjectStringWithObjectName:(NSString *)name value2KeyForAndCondition:(NSDictionary *)dictionary;
+ (NSString *)deleteObjectStringWithClassName:(NSString *)objectName value2Key:(NSDictionary *)dictionary;
+ (NSString *)getObjectWithObjectName:(NSString *)name orderBy:(NSString *)orderCondition isDesc:(BOOL)isDesc limitCount:(int)count condition:(NSArray *)conditions;
+ (NSString *)replaceStringWithClass:(id)object;
@end
