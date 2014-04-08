//
//  EXDBCenter.m
//  DBHelper
//
//  Created by zhengyj on 14-4-8.
//  Copyright (c) 2014年 zhengyj. All rights reserved.
//

#import "EXDBCenter.h"

@implementation EXDBCenter

@synthesize dbHelper = _dbHelper;

- (id) init {
    //禁用 init
    NSAssert(NO, @"Cannot create instance of Singleton");
    //这里可以自己决定返回nil 还是 [self initSingleton]
    return nil;
}

- (id) initSingleton {
    self = [super init];
    if (self) {
        //初始化代码
        self.dbHelper = [[EXDBHelper alloc] init];
        NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *dbPath = [cachesDirectory stringByAppendingPathComponent:@"db22.sqlite1"];
        NSLog(@"%@",dbPath);
        [self.dbHelper openWithDBPath:dbPath];
        [self.dbHelper addDBModuleWithClassName:@"EXUserModle"];
        [self.dbHelper addDBModuleWithClassName:@"EXCarDB"];
    }
    return self;
}

+ (EXDBCenter *) sharedInstance {
    
    static EXDBCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initSingleton];
    });
    return instance;
}




@end
