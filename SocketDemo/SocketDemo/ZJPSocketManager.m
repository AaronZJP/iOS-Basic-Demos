//
//  ZJPSocketManager.m
//  SocketDemo
//
//  Created by Aaron Zhang on 2017/5/8.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import "ZJPSocketManager.h"

@implementation ZJPSocketManager

+(instancetype)sharedSocketManager {
    static ZJPSocketManager *sharedSocketManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSocketManager = [[self alloc]init];
    });
    return sharedSocketManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

- (BOOL)isConnectState {
    return self.socket.isConnected;
}

//链接Socket服务器
- (BOOL)socketConnectHost {
    NSError *error = nil;
    if (self.socket.isConnected) {
        [self.socket disconnect];
    }
    BOOL connect =  [self.socket connectToHost:self.socketHost onPort:self.socketPort error:&error];
    return connect;
}

//心跳包发送
- (void)longConnectToSocket {
    NSString *longConnectSocket = @"longConnectSocket";
    NSData *dataStream = [longConnectSocket dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:dataStream withTimeout:-1 tag:0];
}

//手动断开链接
- (void)cutOffSocket {
    self.socket.userData = [NSNumber numberWithInt:SocketOfflineByUser];
    //销毁计时器
    [self.connerTimer invalidate];
    //断开与服务器的链接
    [self.socket disconnect];
    NSLog(@"已与服务器断开链接！");
}

//发送消息
- (void)sendText:(NSString *)text {
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:-1 tag:1];
    NSLog(@"发送消息中!");
}

- (void)receiveData:(NSData *)data {
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到消息-----%@", string);
    if ([self.delegate respondsToSelector:@selector(receviedString:)]) {
        [self.delegate receviedString:string];
    }
}

# pragma mark - GCDAsyncSocketDelegate


//连接Socket成功后回调 并发送心跳包给服务器，心跳包内容可以和服务器人员协商
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"Socket链接成功！");
    [self.socket readDataWithTimeout:-1 tag:2];
    self.connerTimer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];
}

//接受服务器消息，并读取数据
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    [self receiveData:data];
    [self.socket readDataWithTimeout:-1 tag:tag];
}

//发送消息成功的回调
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    //通过tag来处理消息发送成功的回调
    if (tag == 1) {
        NSLog(@"消息发送成功!");
    }
}

//Socket服务器断线回调
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    //判断如果非用户断开则进行重连
    if ((NSNumber *)self.socket.userData  != [NSNumber numberWithInt:SocketOfflineByUser]) {
        [self socketConnectHost];
    }
    NSError *erro = err;
    NSLog(@"链接已经断开%@",erro);
}



@end
