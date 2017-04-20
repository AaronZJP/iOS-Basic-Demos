//
//  RootDetailViewController.h
//  Test
//
//  Created by Aaron Zhang on 09/04/2017.
//  Copyright © 2017 张近坪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootDetailViewController : UIViewController
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *textView;
@end
