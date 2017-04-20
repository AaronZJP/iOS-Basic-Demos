//
//  CustomPresentationController.m
//  Test
//
//  Created by Aaron Zhang on 12/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import "CustomPresentationController.h"

@interface CustomPresentationController ()
@property (nonatomic,strong) UIView *backView;
@end

@implementation CustomPresentationController

//- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
//    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)presentationTransitionWillBegin {
    
    self.backView = [[UIView alloc]init];
    self.backView.frame = self.containerView.bounds;
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.0;
    [self.containerView insertSubview:self.backView atIndex:0];
    [self.containerView addSubview:self.presentedView];
    
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _backView.alpha = 0.5;
        self.presentingViewController.view.transform = CGAffineTransformScale(self.presentingViewController.view.transform, 0.98, 0.98);
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
    
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [_backView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    id <UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        _backView.alpha = 0.0;
        self.presentingViewController.view.transform = CGAffineTransformIdentity;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [_backView removeFromSuperview];
    }
}

- (CGRect)frameOfPresentedViewInContainerView {
    return CGRectMake(10, self.containerView.bounds.size.height / 2, self.containerView.bounds.size.width - 20, self.containerView.bounds.size.height / 2 - 10);
}

//网上demo 只需要上面的方法即可，但是我这个demo不知道为啥必须加上这句才会生效。 难道是因为我把transitionDelegate 交给了 PrestingViewController 导致的？

- (void)containerViewWillLayoutSubviews {
    self.backView.frame = self.containerView.bounds;
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];
}

- (UIView *)presentedView {
    UIView *presentedView = self.presentedViewController.view;
    presentedView.layer.cornerRadius = 8;
    return presentedView;
}

@end
