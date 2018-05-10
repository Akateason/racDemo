//
//  CommandViewController.m
//  racDemo
//
//  Created by teason23 on 2018/5/10.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "CommandViewController.h"
#import "MyViewModel.h"
#import <ReactiveObjC.h>

@interface CommandViewController ()
@property (strong,nonatomic) MyViewModel *viewModel ;
@end

@implementation CommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _hud.hidden = YES ;
    _viewModel = [[MyViewModel alloc] init] ;
    
    
    @weakify(self)
    RAC(self.viewModel, userName) = _tfName.rac_textSignal;
    RAC(self.viewModel, password) = _tfPwd.rac_textSignal;
    
    self.btLogin.rac_command = self.viewModel.loginCommand ;
    
    [[self.viewModel.loginCommand executionSignals]
        subscribeNext:^(RACSignal *x) {
        
            @strongify(self)
            self.hud.hidden = NO;
            
            [x subscribeNext:^(NSString *x) {
                self.hud.hidden = YES;
                NSLog(@"%@",x) ;
            }] ;
     }] ;
    
//    // or
//    [[[self.viewModel.loginCommand executionSignals] switchToLatest]
//     subscribeNext:^(id x) {
//         NSLog(@"x  %@",x) ;
//     }] ;

}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
