//
//  SQLiteManager.m
//  SQliteDemo
//
//  Created by 张近坪 on 2016/9/21.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import "SQLiteManager.h"
#import "Person.h"
#import <sqlite3.h>

#define DATA_BASE_NAME @"Person.sqlite"

@interface SQLiteManager () {
    sqlite3 *db;
    sqlite3_stmt *statment;
}

@end

@implementation SQLiteManager

static SQLiteManager *_sqliteManager = nil;

+ (instancetype)sharedSQLiteManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sqliteManager = [[super allocWithZone:NULL]init];
    });
    return _sqliteManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [SQLiteManager sharedSQLiteManager];
}

- (id)copyWithZone:(NSZone *)zone {
    return [SQLiteManager sharedSQLiteManager];
}

- (BOOL)creatDB {
    //拼接获取数据库的地址
    NSString *basePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    dataBasePath = [[NSString alloc]initWithString:[basePath stringByAppendingPathComponent:DATA_BASE_NAME]];
    NSLog(@"数据库地址---> %@",dataBasePath);
    
    //返回成功与否
    BOOL isSuccess = YES;
    
    //打开数据库
    //第一个参数是数据库完整的地址
    //第二个参数是SQLite数据库句柄
    //SQLITE_OK 是SQLite中的宏定义，表示当前对数据库的操作的状态
    if (sqlite3_open([dataBasePath UTF8String], &db) == SQLITE_OK) {
        
        char *erro;
        //数据库语法字符串
        //加入了图片等存储功能
        NSString *createSQLite = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS Person (name TEXT PRIMARY KEY, phone TEXT, image BLOB, age TEXT);"];
        
        //数据库建表函数
        if (sqlite3_exec(db, [createSQLite UTF8String], NULL, NULL, &erro) != SQLITE_OK) {
            //关闭数据库，释放资源
            sqlite3_close(db);
            NSAssert(NO, @"数据库建表失败！");
            return isSuccess = NO;
        } else {
            sqlite3_close(db);
            NSLog(@"数据库建表成功！");
            return isSuccess;
        }
    } else {
        //注意只要执行了数据库打开函数的操作，不管数据库是否打开成功或失败，为了安全起见都需要关闭数据库
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败!");
        return isSuccess = NO;
    }
    return isSuccess;
}

- (BOOL)saveName:(NSString *)name AndPhone:(NSString *)phone AndImage:(UIImage *)image WithAge:(NSString *)age {
    //返回成功与否
    BOOL isSuccess = YES;
    if (sqlite3_open([dataBasePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        isSuccess = NO;
        NSAssert(NO, @"数据库打开失败");
    } else {
        //将图片转换成NSData，以便存入数据库
        NSData *imageData = UIImagePNGRepresentation(image);
        //SQL语句
        NSString *insertSQLString = [NSString stringWithFormat:@"INSERT OR REPLACE INTO Person (name, phone, image, age) VALUES (?, ?, ?,?)"];
        //预处理函数
        int result = sqlite3_prepare_v2(db, [insertSQLString UTF8String], -1, &statment, NULL);
        if (result == SQLITE_OK) {
            //绑定数据
            sqlite3_bind_text(statment, 1, [name UTF8String], -1, NULL);
            sqlite3_bind_text(statment, 2, [phone UTF8String], -1, NULL);
            //图片数据等绑定
            sqlite3_bind_blob(statment, 3, [imageData bytes], (int)[imageData length], NULL);
            sqlite3_bind_text(statment, 4, [age UTF8String], -1, NULL);
            //插入数据
            if (sqlite3_step(statment) != SQLITE_DONE) {
                isSuccess = NO;
                NSAssert(NO, @"插入数据失败");
            } else {
                isSuccess = YES;
            }
        }
    }
    sqlite3_finalize(statment);
    sqlite3_close(db);
    return isSuccess;
}

- (NSArray *)findAllPerson {
    NSMutableArray *personArray = [NSMutableArray array];
    
    if (sqlite3_open([dataBasePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(NO, @"数据库打开失败");
    } else {
        NSString *findAllPersonSQLString = @"SELECT name,phone,image,age FROM Person";
        int result = sqlite3_prepare_v2(db, [findAllPersonSQLString UTF8String], -1, &statment, NULL);
        if (result == SQLITE_OK) {
            while (sqlite3_step(statment) == SQLITE_ROW) {
                // 获取记录中的字段值
                // 第一个参数是语句对象，第二个参数是字段的下标，从0开始
                NSString *name = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(statment, 0)];
                
                NSString *phone = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(statment, 1)];
                //取出数据后，把二进制数据转换成UIImage
                UIImage *image = [UIImage imageWithData:[NSData dataWithBytes:sqlite3_column_blob(statment, 2) length:sqlite3_column_bytes(statment, 2)]];
                
                NSString *age = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(statment, 3)];
    
                Person *person = [[Person alloc]init];
                person.name = name;
                person.phone = phone;
                person.age = age;
                person.headerImage = image;
                
                [personArray addObject:person];
            }
        }
        sqlite3_finalize(statment);
        sqlite3_close(db);
    }
    return [personArray copy];
}

- (BOOL)deletePersonWithName:(NSString *)name {
    BOOL isSucces = YES;
    if (sqlite3_open([dataBasePath UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        return NO;
        NSAssert(NO, @"数据库打开失败");
    } else {
        NSString *deletePersonSQLString = @"DELETE FROM Person WHERE name =?";
        //SQL语句预处理
        int result = sqlite3_prepare_v2(db, [deletePersonSQLString UTF8String], -1, &statment, NULL);
        if (result == SQLITE_OK) {
            //绑定参数
            sqlite3_bind_text(statment, 1, [name UTF8String], -1, NULL);
            //执行SQL语句
            if (sqlite3_step(statment) != SQLITE_DONE) {
                return isSucces = NO;
                NSAssert(NO, @"数据库删除失败");
            } else {
                NSLog(@"数据删除成功");
                return isSucces = YES;
            }
        }
    }
    sqlite3_finalize(statment);
    sqlite3_close(db);
    return isSucces;
}

@end
