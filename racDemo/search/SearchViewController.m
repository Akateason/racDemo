//
//  SearchViewController.m
//  racDemo
//
//  Created by xtc on 2018/1/22.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "SearchViewController.h"
#import <ReactiveObjC.h>


@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    @weakify(self)
    [[self.searchText.rac_textSignal
      map:^id(NSString *text) {
          @strongify(self)
          return [self isValidSearchText:text] ? [UIColor whiteColor] : [UIColor yellowColor];
      }]
     subscribeNext:^(UIColor *color) {
         @strongify(self)
         self.searchText.backgroundColor = color;
     }] ;

    // 手动移除
//    RACSignal *backgroundColorSignal =
//    [self.searchText.rac_textSignal map:^id(NSString *text) {
//         return [self isValidSearchText:text] ? [UIColor whiteColor] : [UIColor yellowColor];
//     }];
//
//    RACDisposable *subscription =
//    [backgroundColorSignal subscribeNext:^(UIColor *color) {
//         self.searchText.backgroundColor = color;
//     }];
//
//    // at some point in the future ...
//    [subscription dispose];
    
    
    
}

- (BOOL)isValidSearchText:(NSString *)text {
    return text.length > 2;
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
