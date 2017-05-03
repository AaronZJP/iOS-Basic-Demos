//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by Aaron Zhang on 2017/5/2.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import "ViewController.h"
#import "MainCollectionViewCell.h"
#import "SupplementaryView.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collection;
@end

static const NSInteger margin = 10;
static NSString *const cellIdentifier = @"CollectionCell";
static NSString *const supplementaryViewIdentifier = @"SupplementaryView";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    layout.itemSize = CGSizeMake(150, 160);
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 100);
    
    //初始化 CollectionView
    _collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([MainCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([SupplementaryView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:supplementaryViewIdentifier];
    _collection.dataSource = self;
    _collection.delegate = self;
    _collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collection];
}

#pragma mark UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

//CollectionView的cell的设置
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = (MainCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"test.png"];
    cell.desLabel.text = @"iPhone特价，速度来抢！";
    cell.priceLabel.text = @"￥100";
    return cell;
}

//CollectionView的 header 和 footer 设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SupplementaryView *header = (SupplementaryView *) [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:supplementaryViewIdentifier forIndexPath:indexPath];
        header.imageView.image = [UIImage imageNamed:@"banner.jpg"];
        reusableView = header;
    }
    return reusableView;
}


#pragma mark UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选中了第%ld个item",(long)indexPath.row + 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
