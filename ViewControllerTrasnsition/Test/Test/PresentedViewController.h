//
//  PresentedViewController.h
//  Test
//
//  Created by Aaron Zhang on 12/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PresentedDelegate <NSObject>

- (void)whenDisMissButtonClicked;

@end

@interface PresentedViewController : UIViewController
@property (nonatomic,weak) id <PresentedDelegate> delegate;
@end
