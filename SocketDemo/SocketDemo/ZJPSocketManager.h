//
//  ZJPSocketManager.h
//  SocketDemo
//
//  Created by Aaron Zhang on 2017/5/8.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

enum{
    SocketOfflineByServer,// 服务器掉线，默认为0
    SocketOfflineByUser,  // 用户主动cut
};

@protocol ZJPSocketManagerDelegate <NSObject>

@optional
- (void)receviedString:(NSString *)string;

@end

@interface ZJPSocketManager : NSObject <GCDAsyncSocketDelegate>

@property (nonatomic,strong) GCDAsyncSocket *socket;
@property (nonatomic,copy) NSString *socketHost;
@property (nonatomic,assign) UInt16 socketPort;
@property (nonatomic,weak) id<ZJPSocketManagerDelegate> delegate;
@property (nonatomic,assign,readonly,getter=isConnect) BOOL connectState;
//心跳计时器
@property (nonatomic,strong) NSTimer *connerTimer;

+ (instancetype)sharedSocketManager;

- (BOOL)socketConnectHost;

- (void)cutOffSocket;

- (void)sendText:(NSString *)text;

@end
