//
//  PresentedViewController.m
//  Test
//
//  Created by Aaron Zhang on 12/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import "PresentedViewController.h"

@interface PresentedViewController ()
@property (nonatomic,strong) UIButton *dismissButton;
@end

@implementation PresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.dismissButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [_dismissButton setTitle:@"Dismiss me!" forState:UIControlStateNormal];
    [_dismissButton setTintColor:[UIColor blackColor]];
    _dismissButton.center = self.view.center;
    [_dismissButton addTarget:self action:@selector(dismissButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dismissButton];
}

- (void)dismissButtonClicked:(id)button {
    if ([self.delegate respondsToSelector:@selector(whenDisMissButtonClicked)]) {
        [self.delegate whenDisMissButtonClicked];
    }
}

@end
