//
//  FMDBManager.m
//  FMDBDemo
//
//  Created by 张近坪 on 2016/10/11.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import "FMDBManager.h"
#import <FMDatabase.h>
#import "Person.h"

@interface FMDBManager ()

@property (nonatomic,strong) FMDatabase *db;

@end

@implementation FMDBManager

static FMDBManager *_FMDBManager = nil;

+ (instancetype)sharedFMDBManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _FMDBManager = [[super allocWithZone:NULL]init];
    });
    return _FMDBManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [FMDBManager sharedFMDBManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return [FMDBManager sharedFMDBManager];
}


- (BOOL)creatFMDBWithName:(NSString *)name {
     NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [[NSString alloc]initWithString:[basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",name]]];
    NSLog(@"数据库地址：-----%@",path);
    self.db = [FMDatabase databaseWithPath:path];
    BOOL isSuccess = YES;
    if ([_db open]) {
        NSString *sqlString = [NSString stringWithFormat:@"create table if not exists %@ (name text  primary key, phone text, image BLOB, age text);",name];
        isSuccess = [_db executeUpdate:sqlString];
        NSLog(@"数据库创建成功");
//        isSuccess = YES;
    } else {
        NSLog(@"数据库建表失败");
        isSuccess = NO;
    }
    [_db close];
    return isSuccess;
}

- (BOOL)savaPersonInDBName:(NSString *)name Phone:(NSString *)phone Image:(UIImage *)image AndAge:(NSString *)age {
    NSData *imageData = UIImagePNGRepresentation(image);
    NSArray *dataArray = [NSArray arrayWithObjects:name,phone,imageData,age, nil];
    BOOL isSuccess;
    if ([_db open]) {
        if ([_db executeUpdate:@"insert into Person (name, phone, image, age) values (?, ?, ?, ?)" withArgumentsInArray:dataArray]) {
            NSLog(@"存储数据成功");
            isSuccess = YES;
            [_db close];
        } else {
            NSLog(@"存储数据失败");
            isSuccess = NO;
            [_db close];
        }
    } else {
        NSLog(@"数据存储失败-数据库未打开");
        isSuccess = NO;
        [_db close];
    }
    return isSuccess;
}

- (NSArray *)findAllPersonInDB {
    NSMutableArray *personArray = [NSMutableArray array];
    if ([_db open]) {
        FMResultSet *result = [_db executeQuery:@"select * from Person"];
        while ([result next]) {
            Person *person = [[Person alloc]init];
            person.name = [result stringForColumn:@"name"];
            person.phone = [result stringForColumn:@"phone"];
            NSData *imageData = [result dataForColumn:@"image"];
            person.headerImage = [UIImage imageWithData:imageData];
            person.age = [result stringForColumn:@"age"];
            [personArray addObject:person];
        }
        [_db close];
    } else {
        NSLog(@"获取数据失败-数据库未打开");
        [_db close];
    }
    return [personArray copy];
}

- (BOOL)deletePersonWithName:(NSString *)name {
    BOOL isSuccess;
    if  ([_db open]) {
//        [_db executeUpdate:@"delete from Person where name = ?",name];
        [_db executeUpdateWithFormat:@"delete from Person where name = %@",name];
        isSuccess = YES;
        NSLog(@"删除数据成功");
        [_db close];
    } else {
        NSLog(@"删除数据失败");
        isSuccess = NO;
        [_db close];
    }
    return isSuccess;
}

@end
