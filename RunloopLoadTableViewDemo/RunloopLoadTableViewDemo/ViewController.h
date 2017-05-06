//
//  ViewController.h
//  RunloopLoadTableViewDemo
//
//  Created by Aaron Zhang on 2017/5/6.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

+ (void)removeViewSubViewsInCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath;

+ (void)addTitleInCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath;

+ (void)addImageViewToCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath;

+ (void)addAnotherImageViewToCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath;

+ (void)addOtherViewToCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath;

@end

