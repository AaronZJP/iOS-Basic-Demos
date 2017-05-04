//
//  WaterFlow.h
//  CollectionViewDemo
//
//  Created by Aaron Zhang on 2017/5/4.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFlow;

@protocol WaterFlowLayoutDelegate <NSObject>
@required
- (CGSize)collectionView:(UICollectionView *)collectionView collectionViewLayout:(WaterFlow *)collectionViewLayout sizeOfItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface WaterFlow : UICollectionViewLayout

@property (nonatomic,assign) CGFloat itemMargin;
@property (nonatomic,weak) id<WaterFlowLayoutDelegate> delegate;

@end
