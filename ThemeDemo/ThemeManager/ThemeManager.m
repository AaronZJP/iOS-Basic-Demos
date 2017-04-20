//
//  ThemeManager.m
//  ThemeManager
//
//  Created by 张近坪 on 16/3/16.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import "ThemeManager.h"
#import "UIColor+Hex.h"
#define THEME_BUNDLE_PATH @"Themes"
#define THEME_CONFIG @"ThemeConfig.plist"
#define DEFAULT_THEME @"Default"

static ThemeManager *themeManager = nil;

@interface ThemeManager ()

//主题路径
@property (nonatomic,copy) NSString *themePath;
//主题配置
@property (nonatomic,strong) NSDictionary *themeConfig;

@end

@implementation ThemeManager

+ (ThemeManager *)sharedeThemeManager
{
    if (!themeManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken,^{
            themeManager = [[super allocWithZone:NULL]init];
        });
    }
    return themeManager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [ThemeManager sharedeThemeManager];
}

//通过主题名字来设置主题的路径
- (NSString *)themePath {
    NSString *themePath = [[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:THEME_BUNDLE_PATH]stringByAppendingPathComponent:self.themeName ? : DEFAULT_THEME];
    return themePath;
}

//主题的颜色文字的配置
- (NSDictionary *)themeConfig {
    if (!_themeConfig) {
        _themeConfig = [NSDictionary dictionaryWithContentsOfFile:[self.themePath stringByAppendingPathComponent:THEME_CONFIG]];
    }
    return _themeConfig;
}

#pragma mark - 外部方法

//获取的图片的方法的实现
- (UIImage *)getImageFromThemeWithName:(NSString *)imageName {
    return [UIImage imageWithContentsOfFile:[self.themePath stringByAppendingPathComponent:imageName]];
}

//获取颜色的方法的实现
- (UIColor *)getColorFromThemeWithColorNmae:(NSString *)colorName {
    NSString *color = self.themeConfig[@"Color"][colorName];
    return [UIColor colorWithHexString:color];
}

//获取文字的方法的实现
- (NSString *)getStringFromThemeWithStringName:(NSString *)stringNmae {
    NSString *string = self.themeConfig[@"Text"][stringNmae];
    return string;
}

@end
