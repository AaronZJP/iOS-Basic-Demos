//
//  RWViewController.m
//  RWReactivePlayground
//
//  Created by Colin Eberhardt on 18/12/2013.
//  Copyright (c) 2013 Colin Eberhardt. All rights reserved.
//

#import "RWViewController.h"
#import "RWDummySignInService.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface RWViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *signInFailureText;

//@property (nonatomic) BOOL passwordIsValid;
//@property (nonatomic) BOOL usernameIsValid;
@property (strong, nonatomic) RWDummySignInService *signInService;

@end

@implementation RWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self updateUIState];1
    
    self.signInService = [RWDummySignInService new];
    
    // handle text changes for both text fields
//    [self.usernameTextField addTarget:self action:@selector(usernameTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
//    [self.passwordTextField addTarget:self action:@selector(passwordTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
    
//    [[self.usernameTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
//        return value.length > 3;
//    }] subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
    RACSignal *validUserNameSignal = [self.usernameTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([self isValidUsername:value]);
    }];
    
    RACSignal *validPassWordSignal = [self.passwordTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @([self isValidPassword:value]);
    }];
    
    
//    [[validUserNameSignal map:^id _Nullable(id  _Nullable value) {
//        return [value boolValue] ? [UIColor clearColor] :[UIColor orangeColor];
//    }]subscribeNext:^(id  _Nullable x) {
//        self.usernameTextField.backgroundColor = x;
//    }];
    
    RAC(self.passwordTextField,backgroundColor) = [validPassWordSignal map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? [UIColor clearColor] : [UIColor orangeColor];
    }];
    
    
//    [[validPassWordSignal map:^id _Nullable(id  _Nullable value) {
//        return [value boolValue] ? [UIColor clearColor] : [UIColor orangeColor];
//    }]subscribeNext:^(id  _Nullable x) {
//        self.passwordTextField.backgroundColor = x;
//    }];
    
    RAC(self.usernameTextField,backgroundColor) = [validUserNameSignal map:^id _Nullable(id  _Nullable value) {
        return [value boolValue] ? [UIColor clearColor] : [UIColor orangeColor];
    }];
    
//    [[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside]map:^id _Nullable(__kindof UIControl * _Nullable value) {
//        return [self signInsignal];
//    }]subscribeNext:^(id  _Nullable x) {
//        NSLog(@"sign in result : %@",x);
//    }];
    
    [[[[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside]doNext:^(__kindof UIControl * _Nullable x) {
        self.signInButton.enabled = NO;
        self.signInFailureText.hidden = YES;
    }] flattenMap:^__kindof RACSignal * _Nullable(__kindof UIControl * _Nullable value) {
        return [self signInsignal];
    }]subscribeNext:^(id  _Nullable x) {
        BOOL isSuccess = [x boolValue];
        self.signInFailureText.hidden = isSuccess;
        if (isSuccess) {
            [self performSegueWithIdentifier:@"signInSuccess" sender:self];
        }
        NSLog(@"sign in result : %@",x);
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validUserNameSignal, validPassWordSignal] reduce:^id (NSNumber *usernameValid, NSNumber *passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    
    [signUpActiveSignal subscribeNext:^(id  _Nullable x) {
        self.signInButton.enabled = [x boolValue];
    }];
                                     
    
    // initially hide the failure message
    self.signInFailureText.hidden = YES;
}

- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 3;
}

- (RACSignal *)signInsignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self.signInService signInWithUsername:self.usernameTextField.text password:self.passwordTextField.text complete:^(BOOL success) {
            [subscriber sendNext:@(success)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

//- (IBAction)signInButtonTouched:(id)sender {
//    // disable all UI controls
//    self.signInButton.enabled = NO;
//    self.signInFailureText.hidden = YES;
//
//    // sign in
//    [self.signInService signInWithUsername:self.usernameTextField.text
//                                  password:self.passwordTextField.text
//                                  complete:^(BOOL success) {
//                                      self.signInButton.enabled = YES;
//                                      self.signInFailureText.hidden = success;
//                                      if (success) {
//                                          [self performSegueWithIdentifier:@"signInSuccess" sender:self];
//                                      }
//                                  }];
//}


// updates the enabled state and style of the text fields based on whether the current username
// and password combo is valid
//- (void)updateUIState {
//    self.usernameTextField.backgroundColor = self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//    self.passwordTextField.backgroundColor = self.passwordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//    self.signInButton.enabled = self.usernameIsValid && self.passwordIsValid;
//}
//
//- (void)usernameTextFieldChanged {
//    self.usernameIsValid = [self isValidUsername:self.usernameTextField.text];
//    [self updateUIState];
//}
//
//- (void)passwordTextFieldChanged {
//    self.passwordIsValid = [self isValidPassword:self.passwordTextField.text];
//    [self updateUIState];
//}

@end
