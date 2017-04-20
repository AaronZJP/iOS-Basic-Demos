//
//  Person.h
//  SQliteDemo
//
//  Created by 张近坪 on 2016/9/22.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *age;
@property (nonatomic,strong) UIImage *headerImage;

@end
