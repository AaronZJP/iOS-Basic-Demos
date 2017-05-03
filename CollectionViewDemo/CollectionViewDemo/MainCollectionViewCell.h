//
//  MainCollectionViewCell.h
//  CollectionViewDemo
//
//  Created by Aaron Zhang on 2017/5/2.
//  Copyright © 2017年 张近坪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
