//
//  RootDetailViewController.m
//  Test
//
//  Created by Aaron Zhang on 09/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import "RootDetailViewController.h"
#import "PopAnimation.h"
#import "SwipInteractiveTransition.h"
#import "PushAnimation.h"

@interface RootDetailViewController () <UINavigationControllerDelegate>
@property (nonatomic,strong) SwipInteractiveTransition *swipInteractiveController;
@property (nonatomic,strong) PopAnimation *popAnimation;
@property (nonatomic,strong) PushAnimation *pushAnimation;
@end

@implementation RootDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _headerImageView.image = _image;
    _textView.text = _text;
    
    self.popAnimation = [PopAnimation new];
    self.pushAnimation = [PushAnimation new];
    
    self.swipInteractiveController = [SwipInteractiveTransition new];
    [self.swipInteractiveController addGestureInViewController:self];
    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return _popAnimation;
    } else if (operation == UINavigationControllerOperationPush) {
        return _pushAnimation;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return self.swipInteractiveController.interacting ? self.swipInteractiveController : nil;
}

@end
