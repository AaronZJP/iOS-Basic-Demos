//
//  PinchInteractiveTransition.m
//  Test
//
//  Created by Aaron Zhang on 12/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import "PinchInteractiveTransition.h"

@interface PinchInteractiveTransition ()
@property (nonatomic,strong) UIViewController *presentedVC;
@end

@implementation PinchInteractiveTransition

- (void)addGestureInViewController:(UIViewController *)controller {
    UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinchGesture:)];
    self.presentedVC = controller;
    [self.presentedVC.view addGestureRecognizer:gesture];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gesture {
    NSLog(@"%f",gesture.scale);
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.interacting = YES;
            [self.presentedVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            [self updateInteractiveTransition:1-gesture.scale];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            self.interacting = NO;
            if (gesture.scale < 0.5 ) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            break;
        default:
            break;
    }
}

@end
