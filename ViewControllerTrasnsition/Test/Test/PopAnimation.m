//
//  PopAnimation.m
//  Test
//
//  Created by Aaron Zhang on 09/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import "PopAnimation.h"
#import "RootTableViewController.h"
#import "RootDetailViewController.h"
#import "RootTableViewCell.h"

@implementation PopAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    RootDetailViewController *fromVC = (RootDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    RootTableViewController *toVC = (RootTableViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    RootTableViewCell *cell = [toVC.tableView cellForRowAtIndexPath:toVC.currentIndexPath];
    
    UIView *containerView = [transitionContext containerView];
    
    UIView *headerImageView = [fromVC.headerImageView snapshotViewAfterScreenUpdates:NO];
    headerImageView.frame = [fromVC.headerImageView convertRect:fromVC.headerImageView.bounds toView:containerView];
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    cell.headerView.hidden = YES;
    fromVC.headerImageView.hidden = YES;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:headerImageView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        headerImageView.frame = [cell.headerView convertRect:cell.headerView.bounds toView:containerView];
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        cell.headerView.hidden = NO;
        fromVC.headerImageView.hidden = NO;
        [headerImageView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
