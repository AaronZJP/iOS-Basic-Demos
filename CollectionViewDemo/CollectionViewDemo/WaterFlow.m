//
//  WaterFlow.m
//  CollectionViewDemo
//
//  Created by Aaron Zhang on 2017/5/4.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import "WaterFlow.h"

#define COLLECTIONWIDTH self.collectionView.bounds.size.width

@interface WaterFlow ()
@property (nonatomic,assign) CGFloat rightY;
@property (nonatomic,assign) CGFloat leftY;
@property (nonatomic,assign) CGFloat itemWidth;
@property (assign, nonatomic) NSInteger cellCount;
@end

@implementation WaterFlow

- (void)prepareLayout {
    [super prepareLayout];
    _itemWidth = (COLLECTIONWIDTH - _itemMargin * 3) / 2;
    _cellCount = [self.collectionView numberOfItemsInSection:0];
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(COLLECTIONWIDTH, MAX(_rightY, _leftY));
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    _rightY = _itemMargin;
    _leftY = _itemMargin;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSInteger cellCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [array addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = [self.delegate collectionView:self.collectionView collectionViewLayout:self sizeOfItemAtIndexPath:indexPath];
    CGFloat itemHeight = itemSize.width / _itemWidth * itemSize.height;
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    BOOL isLeft = _leftY < _rightY;
    if (isLeft) {
        CGFloat x = _itemMargin;
        attribute.frame = CGRectMake(x, _leftY, _itemWidth, itemHeight);
        _leftY += _itemMargin + itemHeight;
    } else {
        CGFloat x = _itemWidth + 2 * _itemMargin;
        attribute.frame = CGRectMake(x, _rightY, _itemWidth, itemHeight);
        _rightY += _itemMargin + itemHeight;
    }
    return attribute;
}

@end
