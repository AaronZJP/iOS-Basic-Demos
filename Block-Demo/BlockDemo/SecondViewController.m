//
//  SecondViewController.m
//  BlockDemo
//
//  Created by 张近坪 on 16/3/29.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTF;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.inputTF.text = self.name;
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)returnText:(ReturnTextBlock)block {
    self.returnTextBlock = block;
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(self.inputTF.text);
    }
}

@end
