//
//  ViewController.m
//  RunloopLoadTableViewDemo
//
//  Created by Aaron Zhang on 2017/5/6.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import "ViewController.h"
#import "RunloopDistribution.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

//cell identifier
static NSString *const cellIdentifier = @"CellIdentifer";
//cell 的高度
static CGFloat CellHight = 195;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    //tableView 注册 cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.currentIndexPath = indexPath;
    //先移除之前 cell 已经添加的子视图
    [ViewController removeViewSubViewsInCell:cell AtIndexPath:indexPath];
    
    //添加子视图到cell
    [ViewController addTitleInCell:cell AtIndexPath:indexPath];
    
    //通过 runloop 添加子视图到 cell
    [[RunloopDistribution sharedRunloopDistribution]addTask:^BOOL{
        if (![cell.currentIndexPath isEqual:indexPath]) {
            return NO;
        }
        [ViewController addImageViewToCell:cell AtIndexPath:indexPath];
        return YES;
    } withKey:indexPath];
    
    [[RunloopDistribution sharedRunloopDistribution]addTask:^BOOL{
        if (![cell.currentIndexPath isEqual:indexPath]) {
            return NO;
        }
        [ViewController addAnotherImageViewToCell:cell AtIndexPath:indexPath];
        return YES;
    } withKey:indexPath];
    
    [[RunloopDistribution sharedRunloopDistribution]addTask:^BOOL{
        if (![cell.currentIndexPath isEqual:indexPath]) {
            return NO;
        }
        [ViewController addOtherViewToCell:cell AtIndexPath:indexPath];
        return YES;
    } withKey:indexPath];
    
//    [ViewController addImageViewToCell:cell AtIndexPath:indexPath];
//    [ViewController addAnotherImageViewToCell:cell AtIndexPath:indexPath];
//    [ViewController addOtherViewToCell:cell AtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CellHight;
}

#pragma mark - TableViewCell add SubView

//移除之前被添加到 cell 上的子视图
+ (void)removeViewSubViewsInCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    for (NSInteger i = 1; i <= 5; i ++) {
        [[cell.contentView viewWithTag:i]removeFromSuperview];
    }
}

//添加 Title 到 cell
+ (void)addTitleInCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
    label.text = [NSString stringWithFormat:@"%ld - drawing in cell",(long)indexPath.row];
    label.textColor = [UIColor redColor];
    label.tag = 1;
    label.font = [UIFont systemFontOfSize:18];
    [cell.contentView addSubview:label];
}

//添加第一个 ImageView 到 cell
+ (void)addImageViewToCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50, 85, 85)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.tag = 2;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"spaceship" ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:path];
    //添加视图添加到 cell 上的过渡动画
    [UIView transitionWithView:cell.contentView duration:0.3 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [cell.contentView addSubview:imageView];
    } completion:^(BOOL finished) {
    }];
}

//添加第二个 ImageView 到 cell

+ (void)addAnotherImageViewToCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(105, 50, 85, 85)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.tag = 3;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"spaceship" ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:path];
    [UIView transitionWithView:cell.contentView duration:0.3 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [cell.contentView addSubview:imageView];
    } completion:^(BOOL finished) {
    }];
}

//添加剩下的视图到 cell

+ (void)addOtherViewToCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 50, 85, 85)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.tag = 4;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"spaceship" ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:path];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 145, 365, 40)];
    label.text = [NSString stringWithFormat:@"%ld - 同时加载多个高清图片的时候应该将其放在runloop的每一次循环中去加载图片！",indexPath.row];
    label.tag = 5;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont systemFontOfSize:13];
    label.numberOfLines = 0;
    label.textColor = [UIColor orangeColor];
    [cell.contentView addSubview:label];
    [UIView transitionWithView:cell.contentView duration:0.3 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:imageView];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - memoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
