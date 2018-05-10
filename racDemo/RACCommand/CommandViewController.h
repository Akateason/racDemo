//
//  CommandViewController.h
//  racDemo
//
//  Created by teason23 on 2018/5/10.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommandViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfPwd;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *hud;
@property (weak, nonatomic) IBOutlet UIButton *btLogin;

@end
