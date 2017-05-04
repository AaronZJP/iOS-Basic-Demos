

//
//  FlowLayoutViewController.m
//  CollectionViewDemo
//
//  Created by Aaron Zhang on 2017/5/4.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import "FlowLayoutViewController.h"
#import "WaterFlow.h"
#import "CustomCollectionViewCell.h"

@interface FlowLayoutViewController ()<WaterFlowLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

static NSString *const cellIdentifier = @"CellIdentifier";

@implementation FlowLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WaterFlow *layout = [[WaterFlow alloc]init];
    layout.itemMargin = 20;
    layout.delegate = self;
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
//    [_collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    [self.view addSubview:_collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = (CustomCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        NSLog(@"......");
    }
    cell.picView.image = [UIImage imageNamed:@"galaxy.jpg"];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark WaterFlowDelegate 

- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(WaterFlow *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return CGSizeMake(200, 100);
    } else {
        return CGSizeMake(150, 300);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
