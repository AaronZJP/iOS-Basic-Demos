//
//  PresentAnimation.h
//  Test
//
//  Created by Aaron Zhang on 12/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,AnimationType) {
    AnimationTypeOfPresent = 0,
    AnimationTypeOfPop
};

@interface PresentAnimation : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)animationUseAnimationType:(AnimationType)type;
- (instancetype)initWithAnimationType:(AnimationType)type;

@end
