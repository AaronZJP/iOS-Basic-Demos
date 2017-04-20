//
//  SwipInteractiveTransition.m
//  Test
//
//  Created by Aaron Zhang on 09/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import "SwipInteractiveTransition.h"

@interface SwipInteractiveTransition ()
@property (nonatomic,strong) UIViewController *pushingViewController;
@end

@implementation SwipInteractiveTransition

- (void)addGestureInViewController:(UIViewController *)controller {
    UIScreenEdgePanGestureRecognizer *gesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    gesture.edges = UIRectEdgeLeft;
    self.pushingViewController = controller;
    [self.pushingViewController.view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture {
    CGPoint traslation = [gesture translationInView:self.pushingViewController.view];
    CGFloat progress = traslation.x / CGRectGetWidth(self.pushingViewController.view.bounds);
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        [self.pushingViewController.navigationController popViewControllerAnimated:YES];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self updateInteractiveTransition:progress];
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        self.interacting = NO;
        if (progress > 0.5) {
            [self finishInteractiveTransition];
        } else {
            [self cancelInteractiveTransition];
        }
    } else {
        self.interacting = NO;
        [self cancelInteractiveTransition];
    }
}



@end
