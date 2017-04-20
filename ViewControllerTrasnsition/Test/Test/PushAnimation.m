//
//  PushAnimation.m
//  Test
//
//  Created by Aaron Zhang on 09/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import "PushAnimation.h"
#import "RootTableViewController.h"
#import "RootDetailViewController.h"
#import "RootTableViewCell.h"

@implementation PushAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    RootTableViewController *fromVC = (RootTableViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    RootDetailViewController *toVC = (RootDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    RootTableViewCell *cell = [fromVC.tableView cellForRowAtIndexPath:fromVC.currentIndexPath];
    
    UIView *containerView = [transitionContext containerView];
    UIView *cellImageView = [cell.headerView snapshotViewAfterScreenUpdates:NO];
    cellImageView.frame = [cell.headerView convertRect:cell.headerView.bounds toView:containerView];
    
    toVC.view.alpha = 0;
    cell.headerView.hidden = YES;
    toVC.headerImageView.hidden = YES;
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:cellImageView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //需要更新布局 否则在横屏状态下 cellImageView 位置不正确
        [containerView layoutIfNeeded];
        cellImageView.frame = [toVC.headerImageView convertRect:toVC.headerImageView.bounds toView:containerView];
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [cellImageView removeFromSuperview];
        toVC.headerImageView.hidden = NO;
        cell.headerView.hidden = NO;
       [transitionContext completeTransition:YES];
    }];
    
}

@end
