//
//  ViewController.m
//  racDemo
//
//  Created by xtc on 2018/1/19.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad] ;
    
//    1
//    [self.usernameTextField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"x1 : %@" , x) ;
//    }] ;
    
    
//    2
    [[self.usernameTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 3 ;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"x2 : %@" , x) ;
    }] ;
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
