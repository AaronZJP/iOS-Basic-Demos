//
//  RunloopDistribution.m
//  RunloopLoadTableViewDemo
//
//  Created by Aaron Zhang on 2017/5/6.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import "RunloopDistribution.h"
#import <objc/runtime.h>

@interface RunloopDistribution ()

@property (nonatomic,strong) NSMutableArray *tasks;
@property (nonatomic,strong) NSMutableArray *tasksKeys;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation RunloopDistribution

- (instancetype)init {
    self = [super init];
    if (self) {
        _maximumQueueLength = 12;
        _tasks = [NSMutableArray array];
        _tasksKeys = [NSMutableArray array];
        //添加timer 是为了保证runloop不会进入睡眠状态，线程保活。其实在这个demo中实在主线程中进行的，所以不用创建该timer也可以的，但是在子线程中则需要该timer保证线程不会退出。线程保活也还有其他的方式 比如 port。
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFierd) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)timerFierd {
    //timer 添加的空方法，这里不需要做任何事情
}

+ (instancetype)sharedRunloopDistribution {
    static RunloopDistribution *sigleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sigleton = [[RunloopDistribution alloc]init];
    });
    [self registerRunloopDistributionMainRunloopObserve:sigleton];
    return sigleton;
}

- (void)removeAllTasks {
    [self.tasks removeAllObjects];
    [self.tasksKeys removeAllObjects];
}

- (void)addTask:(RunloopDistributionUnit)unit withKey:(id)key {
    [self.tasks addObject:unit];
    [self.tasksKeys addObject:key];
    if (self.tasks.count > self.maximumQueueLength) {
        [self.tasks removeObjectAtIndex:0];
        [self.tasksKeys removeObjectAtIndex:0];
    }
}

//注册runloop状态监听
+ (void)registerRunloopDistributionMainRunloopObserve:(RunloopDistribution *)runloopDistribution {
    static CFRunLoopObserverRef defualtObserve;
    CFRunLoopRef currentRunloop = CFRunLoopGetCurrent();
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(runloopDistribution),
        &CFRetain,
        &CFRelease,
        NULL
    };
    defualtObserve = CFRunLoopObserverCreate(NULL,
                                             kCFRunLoopBeforeWaiting,
                                             YES,
                                             NSIntegerMax - 999,
                                             &runloopCallBack,
                                             &context);
    CFRunLoopAddObserver(currentRunloop, defualtObserve, kCFRunLoopDefaultMode);
    CFRelease(defualtObserve);
}

//runloop状态监听的回调，在该回调中加载图片，这里监听的是runloop即将进入到睡眠状态的时候
static void runloopCallBack(CFRunLoopObserverRef obeserve, CFRunLoopActivity activity, void *info) {
    RunloopDistribution *runloopDistribution = (__bridge RunloopDistribution *)info;
    if (runloopDistribution.tasks.count == 0) {
        return;
    }
    BOOL result = NO;
    while (result == NO && runloopDistribution.tasks.count) {
        RunloopDistributionUnit unit = runloopDistribution.tasks.firstObject;
        NSIndexPath *indexPath = runloopDistribution.tasksKeys.firstObject;
        result = unit();
        NSLog(@"%ld ----- %d",(long)indexPath.row,result);
        [runloopDistribution.tasks removeObjectAtIndex:0];
        [runloopDistribution.tasksKeys removeObjectAtIndex:0];
    }
}

@end

@implementation UITableViewCell (RunloopDistribution)

@dynamic currentIndexPath;

- (NSIndexPath *)currentIndexPath {
    NSIndexPath *indexPath = objc_getAssociatedObject(self, @selector(currentIndexPath));
    return indexPath;
}

- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath {
    objc_setAssociatedObject(self, @selector(currentIndexPath), currentIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


