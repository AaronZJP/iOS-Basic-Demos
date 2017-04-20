//
//  ThemeManager.h
//  ThemeManager
//
//  Created by 张近坪 on 16/3/16.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThemeManager : NSObject

@property (nonatomic,copy) NSString *themeName;

//创建theme单例
+ (ThemeManager *)sharedeThemeManager;

//获取主题的图片
- (UIImage *)getImageFromThemeWithName:(NSString *)imageName;

//获取主题的颜色
- (UIColor *)getColorFromThemeWithColorNmae:(NSString *)colorName;

//获取主题文字
- (NSString *)getStringFromThemeWithStringName:(NSString *)stringNmae;


@end
