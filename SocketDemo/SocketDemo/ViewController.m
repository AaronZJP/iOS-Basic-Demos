//
//  ViewController.m
//  SocketDemo
//
//  Created by Aaron Zhang on 2017/5/8.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import "ViewController.h"
#import "ZJPSocketManager.h"

#define PORT 6666
#define HOST @"127.0.0.1"

@interface ViewController () <ZJPSocketManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *recevieLabel;
@property (weak, nonatomic) IBOutlet UITextField *sendTextField;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (nonatomic,strong) ZJPSocketManager *socketManager;
@end

@implementation ViewController

- (IBAction)sendString:(id)sender {
    [self.socketManager sendText:self.sendTextField.text];
}

- (IBAction)connectButton:(id)sender {
    if (![sender isSelected]) {
        if ([_socketManager socketConnectHost]) {
            [sender setSelected:YES];
        }
    } else {
        [_socketManager cutOffSocket];
        [sender setSelected:NO];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _socketManager = [ZJPSocketManager sharedSocketManager];
    _socketManager.socketPort = PORT;
    _socketManager.socketHost = HOST;
    _socketManager.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)receviedString:(NSString *)string {
    self.recevieLabel.text = string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
