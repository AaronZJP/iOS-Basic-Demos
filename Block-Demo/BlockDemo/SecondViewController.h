//
//  SecondViewController.h
//  BlockDemo
//
//  Created by 张近坪 on 16/3/29.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import <UIKit/UIKit.h>

//给block定义一个别名
typedef void (^ReturnTextBlock) (NSString *showText);

@interface SecondViewController : UIViewController

@property (nonatomic,copy) NSString *name;

//声明一个block属性
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

//使用此方法回调，获取本控制器中输入的文字（也可以通过block属性来获取控制器中输入的文字）
- (void)returnText:(ReturnTextBlock)block;

@end
