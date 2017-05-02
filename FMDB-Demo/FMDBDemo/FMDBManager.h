//
//  FMDBManager.h
//  FMDBDemo
//
//  Created by 张近坪 on 2016/10/11.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FMDBManager : NSObject

+ (instancetype)sharedFMDBManager;

- (BOOL)creatFMDBWithName:(NSString *)name;

- (BOOL)savaPersonInDBName:(NSString *)name Phone:(NSString *)phone Image:(UIImage *)image AndAge:(NSString *)age;

- (NSArray *)findAllPersonInDB;

- (BOOL)deletePersonWithName:(NSString *)name;

@end
