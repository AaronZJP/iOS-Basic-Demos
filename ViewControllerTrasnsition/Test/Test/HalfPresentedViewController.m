//
//  HalfPresentedViewController.m
//  Test
//
//  Created by Aaron Zhang on 13/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import "HalfPresentedViewController.h"

@interface HalfPresentedViewController ()

@end

@implementation HalfPresentedViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)dismissButtonClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
