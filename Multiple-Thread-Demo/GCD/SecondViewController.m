//
//  SecondViewController.m
//  GCD
//
//  Created by 张近坪 on 16/6/9.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic,strong) NSMutableArray *imageViewsArray;
@property (nonatomic,strong) NSMutableArray *images;
@property (nonatomic,strong) NSArray *imageURLs;

@end

static const NSInteger imageViewColumn = 3;
static const NSInteger imageViewRow = 4;


@implementation SecondViewController

- (NSMutableArray *)imageViewsArray {
    if (!_imageViewsArray) {
        _imageViewsArray = [NSMutableArray array];
    }
    return _imageViewsArray;
}

- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageURLs = @[@"http://d.3987.com/dyzgz_150818/008.jpg",@"http://bizhi.33lc.com/uploadfile/2015/1009/20151009020052284.jpg",@"http://pic.desk.orsoon.com/960x600/1603/5-160311153Q1.jpg",@"http://photo.880sy.com/4/2916/111821.jpg",@"http://photo.880sy.com/4/2916/111804.jpg",@"http://www.52desktop.cn/upimg/allimg/090529/2009529028117177801.jpg",@"http://tu1.desk.orsoon.com/960x600/1606/8-16060R15602.jpg",@"http://tu1.desk.orsoon.com/960x600/1606/9-16060G35100.jpg",@"http://tu1.desk.orsoon.com/960x600/1606/9-16060G34354.jpg",@"http://tu1.desk.orsoon.com/960x600/1606/9-16060G12618.jpg",@"http://tu1.desk.orsoon.com/960x600/1606/9-16060G12030.jpg",@"http://tu1.desk.orsoon.com/960x600/1606/9-16060G10556.jpg"];
    [self initializeView];
    [self loadImagesWithMultiThread];
}

- (void)initializeView {
    for (int i = 0; i < imageViewColumn; i++) {
        for (int j = 0 ; j < imageViewRow; j++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds) / imageViewColumn * i, CGRectGetMaxY(self.view.bounds) / imageViewRow * j, CGRectGetWidth(self.view.bounds) / imageViewColumn, CGRectGetHeight(self.view.bounds) / imageViewRow)];
            imageView.backgroundColor = [UIColor lightGrayColor];
            //            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.imageViewsArray addObject:imageView];
            [self.view addSubview:imageView];
        }
    }
}


- (void)loadImagesWithMultiThread {
    dispatch_queue_t serialQueue = dispatch_queue_create("zjp", DISPATCH_QUEUE_SERIAL);
        for (int i = 0; i < self.imageViewsArray.count; i++) {
            dispatch_async(serialQueue, ^{
               [self loadImageWithIndex:i];
            });
        }
}

- (void)loadImageWithIndex:(NSInteger)index {
    
            NSURL *URL = [NSURL URLWithString:self.imageURLs[index]];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self updateImage:image andIndex:index];
            });
}

- (void)updateImage:(UIImage *)image andIndex:(NSInteger)index {
    UIImageView *imageView = self.imageViewsArray[index];
    imageView.image = image;
}


@end
