//
//  PinchInteractiveTransition.h
//  Test
//
//  Created by Aaron Zhang on 12/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PinchInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic,assign) BOOL interacting;

- (void)addGestureInViewController:(UIViewController *)controller;

@end
