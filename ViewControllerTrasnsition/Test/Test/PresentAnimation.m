//
//  PresentAnimation.m
//  Test
//
//  Created by Aaron Zhang on 12/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import "PresentAnimation.h"
#import "PresentedViewController.h"

@interface PresentAnimation ()
@property (nonatomic,assign) AnimationType type;
@end

@implementation PresentAnimation

+ (instancetype)animationUseAnimationType:(AnimationType)type {
    return [[self alloc]initWithAnimationType:type];
}

- (instancetype)initWithAnimationType:(AnimationType)type {
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.type) {
        case AnimationTypeOfPresent:
            [self doPresentAnimation:transitionContext];
            break;
        case AnimationTypeOfPop:
            [self doDisMissAnimation:transitionContext];
            break;
        default:
            break;
    }
}

- (void)doPresentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.01, 0.01);
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)doDisMissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toView belowSubview:fromVC.view];
    [containerView addSubview:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.01, 0.01);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
