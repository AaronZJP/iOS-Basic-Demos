//
//  AddViewController.m
//  SQliteDemo
//
//  Created by 张近坪 on 2016/9/22.
//  Copyright © 2016年 张近坪. All rights reserved.
//

#import "AddViewController.h"
#import "SQLiteManager.h"

@interface AddViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;



@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerImageView.image = [UIImage imageNamed:@"default.png"];
    self.headerImageView.userInteractionEnabled = YES;
}

- (void)viewDidLayoutSubviews {
    self.headerImageView.layer.cornerRadius = CGRectGetWidth(self.headerImageView.frame) / 2;
    self.headerImageView.layer.masksToBounds = YES;
}

- (IBAction)headerImageViewClicked:(UITapGestureRecognizer *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}
- (IBAction)AddedClicked:(UIBarButtonItem *)sender {
    if ([self saveDataToDB]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}
- (IBAction)cancleCliked:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)saveDataToDB {
    if (_nameTextField.text.length != 0 && _phoneTextField.text.length != 0 && _ageTextField.text.length != 0) {
        
        SQLiteManager *sql = [SQLiteManager sharedSQLiteManager];
        [sql saveName:_nameTextField.text AndPhone:_phoneTextField.text AndImage:_headerImageView.image WithAge:_ageTextField.text];
        NSLog(@"数据添加成功！");
        return YES;
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"数据不能为空，请填写完整！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:action1];
        [self presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    return NO;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    self.headerImageView.image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
