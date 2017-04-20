//
//  ViewController.m
//  ThemeManager
//
//  Created by 张近坪 on 16/3/16.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import "ViewController.h"
#import "ThemeManager.h"
#import "ThemeConfig.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UITextView *about;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ThemeManager *theme = [ThemeManager sharedeThemeManager];
    theme.themeName = @"Red";
    
    self.logo.image = [theme getImageFromThemeWithName:THEME_LOGO];
    
    self.view.backgroundColor = [theme getColorFromThemeWithColorNmae:THEME_COLOR];
    
    self.about.text = [theme getStringFromThemeWithStringName:ABOUT_STRING];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
