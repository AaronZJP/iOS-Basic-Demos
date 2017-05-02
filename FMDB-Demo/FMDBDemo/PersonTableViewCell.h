//
//  PersonTableViewCell.h
//  FMDBDemo
//
//  Created by 张近坪 on 2016/10/11.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
