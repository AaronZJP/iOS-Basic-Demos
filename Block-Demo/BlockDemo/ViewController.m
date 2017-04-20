//
//  ViewController.m
//  BlockDemo
//
//  Created by 张近坪 on 16/3/29.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //声明一个block变量
    int multiplier = 7;
    int (^myBlock)(int) = ^(int num) {
        return num * multiplier;
    };
    
    //block变量可以像函数一样使用
    NSLog(@"%d",myBlock(8));
    
    //调用返回值为block的方法
    TextBlock block = [self returnAStringWithName];
    NSString *a = @"王八蛋";
    //使用返回的block
    block(a);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SecondViewController *tfVC = segue.destinationViewController;
    
    //通过回调方法获取控制器二block中的值
    [tfVC returnText:^(NSString *showText) {
        self.TestLabel.text = showText;
    }];

    //通过属性的方式获取控制器二block中的值
//    tfVC.returnTextBlock = ^(NSString *showText) {
//        self.TestLabel.text = showText;
//    };
}

//定义一个block
typedef void (^TextBlock) (NSString *str);

//把block作为函数的返回值
- (TextBlock)returnAStringWithName {
    TextBlock block = ^(NSString *str) {
        NSLog(@"他的名字叫%@",str);
    };
    return block;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
