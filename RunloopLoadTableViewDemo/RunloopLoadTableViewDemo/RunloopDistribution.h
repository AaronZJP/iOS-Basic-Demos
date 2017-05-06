//
//  RunloopDistribution.h
//  RunloopLoadTableViewDemo
//
//  Created by Aaron Zhang on 2017/5/6.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^RunloopDistributionUnit)(void);

@interface RunloopDistribution : NSObject

//runloop单例中最多加载的个数
@property (nonatomic,assign) NSInteger maximumQueueLength;

//runloop 单例
+ (instancetype)sharedRunloopDistribution;

//添加任务到runloop中
- (void)addTask:(RunloopDistributionUnit)unit withKey:(id)key;

//移除所有任务
- (void)removeAllTasks;

@end

@interface UITableViewCell (RunloopDistribution)

@property (nonatomic,strong) NSIndexPath *currentIndexPath;

@end
