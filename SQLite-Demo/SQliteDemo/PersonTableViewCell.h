//
//  PersonTableViewCell.h
//  SQliteDemo
//
//  Created by 张近坪 on 2016/9/23.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
