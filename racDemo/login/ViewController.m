//
//  ViewController.m
//  racDemo
//
//  Created by xtc on 2018/1/19.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "RWDummySignInService.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;

@property (strong, nonatomic) RWDummySignInService *signInService ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad] ;
    
//-------------------------C1-------------------------//
    /*
//    1
    [self.usernameTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"x1 : %@" , x) ;
    }] ;
    
//    2 filter ==> flatMap . 不改变signal返回值
    [[self.usernameTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 3 ;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"x2 : %@" , x) ;
    }] ;
    
//    3 map 会改变signal返回值
    [[[self.usernameTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length) ;
    }] filter:^BOOL(NSNumber *length) {
        return [length intValue] > 3 ;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"x3 : %@" , x) ;
    }] ;
*/
    
    
//-------------------------C2-------------------------//
    
    RACSignal *validUsernameSignal = [self.usernameTextField.rac_textSignal map:^id(NSString *text) {
         return @([self isValidUsername:text]) ;
     }];
    
    RACSignal *validPasswordSignal = [self.passwordTextField.rac_textSignal map:^id(NSString *text) {
         return @([self isValidPassword:text]) ;
     }];
    
//    [[validPasswordSignal map:^id(NSNumber *passwordValid) {
//          return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
//      }]
//     subscribeNext:^(UIColor *color) {
//         self.passwordTextField.backgroundColor = color;
//     }] ;
    
// 转换为宏, 简写.
    RAC(self.passwordTextField, backgroundColor) =
    [validPasswordSignal map:^id(NSNumber *passwordValid) {
         return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
     }] ;
    
    RAC(self.usernameTextField, backgroundColor) =
    [validUsernameSignal map:^id(NSNumber *passwordValid) {
         return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
     }] ;
    
    RACSignal *signupActiveSignal =
    [RACSignal combineLatest:@[validUsernameSignal,validPasswordSignal]
                      reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid) {
                          return @([usernameValid boolValue] && [passwordValid boolValue]) ;
                      }] ;
//    上面的代码使用combineLatest:reduce:方法获取validUsernameSignal和validPasswordSignal的最近一个信号值并组合成一个全新的信号。每当两个源信号的其中一个发送新值，reduce里的block代码块就会执行，其返回的值会作为合成信号的值发送出去。
    [signupActiveSignal subscribeNext:^(NSNumber *signupActive) {
        self.buttonLogin.enabled = [signupActive boolValue] ;
    }] ;
    
    
//
//    [[[self.buttonLogin rac_signalForControlEvents:UIControlEventTouchUpInside]
//      flattenMap:^__kindof RACSignal * _Nullable(__kindof UIControl * _Nullable value) {
//          return [self signInSignal] ;
//      }]
//     subscribeNext:^(NSNumber *signedIn) {
//         NSLog(@"Sign in result: %@", signedIn);
//         BOOL success = [signedIn boolValue] ;
//         // self.signInFailureText.hidden = success ;
//         if (success) {
//             [self performSegueWithIdentifier:@"signInSuccess" sender:self];
//         }
//     }] ;
    
//
    [[[[self.buttonLogin rac_signalForControlEvents:UIControlEventTouchUpInside]
       doNext:^(__kindof UIControl * _Nullable x) {
        self.buttonLogin.enabled = NO ;
        self.buttonLogin.backgroundColor = [UIColor lightGrayColor] ;
    }]
      flattenMap:^__kindof RACSignal * _Nullable(__kindof UIControl * _Nullable value) {
          return [self signInSignal] ;
      }]
     subscribeNext:^(NSNumber *signedIn) {
         NSLog(@"Sign in result: %@", signedIn);
         BOOL success = [signedIn boolValue] ;
         // self.signInFailureText.hidden = success ;
         self.buttonLogin.backgroundColor = [UIColor greenColor] ;
         if (success) {
             [self performSegueWithIdentifier:@"signInSuccess" sender:self];
         }
     }] ;

}

- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3 ;
}

- (BOOL)isValidPassword:(NSString *)pwd {
    return pwd.length > 3 ;
}

// racsignal .
- (RACSignal *)signInSignal {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {  //1
            [self.signInService signInWithUsername:self.usernameTextField.text
                                          password:self.passwordTextField.text
                                          complete:^(BOOL success) {
                                              [subscriber sendNext:@(success)] ; //2
                                              [subscriber sendCompleted] ; //3
                                          }] ;
        return nil ;
    }] ;
}

- (RWDummySignInService *)signInService {
    if (!_signInService) _signInService = [RWDummySignInService new] ;
    return _signInService ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
