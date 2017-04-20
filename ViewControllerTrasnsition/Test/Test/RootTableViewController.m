//
//  RootTableViewController.m
//  Test
//
//  Created by Aaron Zhang on 09/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import "RootTableViewController.h"
#import "RootTableViewCell.h"
#import "RootDetailViewController.h"
#import "PushAnimation.h"
#import "PopAnimation.h"
#import "SwipInteractiveTransition.h"
#import "PresentedViewController.h"
#import "PresentAnimation.h"
#import "PinchInteractiveTransition.h"
#import "CustomPresentationController.h"
#import "HalfPresentedViewController.h"

@interface RootTableViewController () <UINavigationControllerDelegate,UIViewControllerTransitioningDelegate,PresentedDelegate>
@property (nonatomic,copy) NSArray *imageArray;
@property (nonatomic,copy) NSArray *textArray;
@property (nonatomic,strong) PushAnimation *pushAnimation;
@property (nonatomic,strong) PopAnimation *popAnimation;
@property (nonatomic,strong) PinchInteractiveTransition *pinchInteractiveTransition;
@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = @[@"640-1.jpg",@"640-1.jpg",@"640-1.jpg"];
    self.textArray = @[@"上课就傻了肯德基看杀姐姐了杜莎空间的轮廓撒娇的轮廓时间啊你快点结束了卡简单了时间啊你看得见你看撒娇都能看见啥了肯德基看了撒娇的轮廓就傻了空间的路上看见的了啊控件的轮廓时间啊你快点结束了卡简单",@"点啥好的机会发地方几乎都是减肥护肤肯德基啊喝咖啡就好地方肯定会分开速度发货时间啊疯狂监督法 i 啊的肌肤轮廓史蒂夫哈尽快发货的卡手机号",@"fhjshakfdjshkfjhdsakjdfhkdjsafuhesalhfdjh9aewuhfdkjhfksjdhfuewhafadkjshfewiufhdsha",@"自定义present",@"TEST"];
    self.tableView.rowHeight = 100;
    self.pushAnimation = [PushAnimation new];
    self.popAnimation = [PopAnimation new];
    self.navigationController.delegate = self;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    static NSString *dfualtCellIdentifier = @"DefualtCell";
    if (indexPath.row <= 2) {
        RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.headerView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
        cell.textView.text = _textArray[indexPath.row];
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dfualtCellIdentifier];;
        cell.textLabel.text = _textArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row <= 2) {
        RootTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        _currentIndexPath = indexPath;
        [self performSegueWithIdentifier:@"pushDetailVC" sender:cell];
    } else if (indexPath.row == 3) {
        PresentedViewController *presentedVC = [[PresentedViewController alloc]init];
        self.pinchInteractiveTransition = [PinchInteractiveTransition new];
        [self.pinchInteractiveTransition addGestureInViewController:presentedVC];
        presentedVC.delegate = self;
        presentedVC.transitioningDelegate = self;
        [self presentViewController:presentedVC animated:YES completion:nil];
    } else if (indexPath.row == 4) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HalfPresentedViewController *presentVC = [board instantiateViewControllerWithIdentifier:@"customOfPresentattionVC"];
        presentVC.modalPresentationStyle = UIModalPresentationCustom;
        presentVC.transitioningDelegate = self;
        [self presentViewController:presentVC animated:YES completion:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushDetailVC"]) {
        RootDetailViewController *destinationVC =  (RootDetailViewController *) segue.destinationViewController;
        RootTableViewCell *cell = (RootTableViewCell *)sender;
        destinationVC.image = cell.headerView.image;
        destinationVC.text = cell.textView.text;
    }
}

#pragma mark - PresentedDelegate

- (void)whenDisMissButtonClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return _pushAnimation;
    }
    else if (operation == UINavigationControllerOperationPop) {
        return _popAnimation;
    }
    return nil;
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [PresentAnimation animationUseAnimationType:AnimationTypeOfPresent];
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [PresentAnimation animationUseAnimationType:AnimationTypeOfPop];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.pinchInteractiveTransition.interacting ? self.pinchInteractiveTransition : nil;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    CustomPresentationController *myPresentationController = [[CustomPresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
    return myPresentationController;
}

@end
