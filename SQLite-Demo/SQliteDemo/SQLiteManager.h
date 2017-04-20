//
//  SQLiteManager.h
//  SQliteDemo
//
//  Created by 张近坪 on 2016/9/21.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SQLiteManager : NSObject {
    NSString *dataBasePath;
}

//数据库管理器
+ (instancetype)sharedSQLiteManager;

//创建数据库并返回是否成功
- (BOOL)creatDB;

//储存数据到数据库，并返回是否成功

- (BOOL)saveName:(NSString *)name AndPhone:(NSString *)phone AndImage:(UIImage *)image WithAge:(NSString *)age;

//删除数据库数据，并返回是否成功
- (BOOL)deletePersonWithName:(NSString *)name;

//查找数据库，所有数据
- (NSArray *)findAllPerson;

@end
