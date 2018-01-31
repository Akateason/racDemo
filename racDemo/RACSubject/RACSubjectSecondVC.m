//
//  RACSubjectSecondVC.m
//  racDemo
//
//  Created by xtc on 2018/1/31.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "RACSubjectSecondVC.h"
#import <ReactiveObjC.h>

@interface RACSubjectSecondVC ()

@end

@implementation RACSubjectSecondVC

- (IBAction)btBackOnClick:(id)sender {
    
    if (self.aSubject) [self.aSubject sendNext:@(87237111)] ;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
