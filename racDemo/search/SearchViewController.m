//
//  SearchViewController.m
//  racDemo
//
//  Created by xtc on 2018/1/22.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "SearchViewController.h"
#import <ReactiveObjC.h>
#import "ServerRequest.h"
#import <YYModel.h>
#import "Book.h"
#import "BookTableViewCell.h"

@interface SearchViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *lbUserInfo;

@property (copy,nonatomic) NSArray *datasource ;
@end

@implementation SearchViewController

#pragma mark - prop
// req access (userinfo)
- (RACSignal *)requestAccessToTwitterSignal {
    //  - create the signal
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //  - request access to twitter
        @strongify(self)
        [ServerRequest getUserInfoSuccess:^(id json) {
            
            self.lbUserInfo.text = json[@"name"] ;
            if (!self.lbUserInfo.text.length) {
                NSError *accessError = [NSError errorWithDomain:@"testsfasdfas"
                                                           code:3331221
                                                       userInfo:nil] ;
                [subscriber sendError:accessError] ;
            } else {
                [subscriber sendNext:nil] ;
                [subscriber sendCompleted] ;
            }
            
        }
                                     fail:^{
                                         
             NSError *accessError = [NSError errorWithDomain:@"dddtestsfasdfas"
                                                        code:666666
                                                    userInfo:nil] ;
             [subscriber sendError:accessError] ;

                                     }] ;
        return nil ;
    }] ;
}

// search signal .
- (RACSignal *)signalForSearchWithText:(NSString *)text {
    
    // 1 - define the errors
    NSError *invalidResponseError = [NSError errorWithDomain:@"invalidResponseError"
                                                        code:878677777
                                                    userInfo:nil];
    // 2 - create the signal block
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [ServerRequest searchWithString:text
                                success:^(id json) {
                                    
                                    if (!json[@"code"]) {
                                        [subscriber sendNext:json] ;
                                        [subscriber sendCompleted] ;
                                    }
                                    else {
                                        [subscriber sendError:invalidResponseError] ;
                                    }
                                }
                                   fail:^{
                                       
                                       [subscriber sendError:invalidResponseError] ;
                                   }] ;
        return nil ;
    }] ;
}


// get image
- (RACSignal *)signalForCellImage:(NSString *)imageUrl {
    // 异步下载 image
    RACScheduler *scheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground] ;
    
    return
    [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]] ;
        UIImage *image = [UIImage imageWithData:data] ;
        [subscriber sendNext:image] ;
        [subscriber sendCompleted] ;
        return nil ;
    }]
            subscribeOn:scheduler] ;
    //由于你希望这个信号不在主线程中执行，上面的方法先获取了一个后台调度器。然后创建一个信号，该信号在有订阅者时下载图像数据并生成UIImage。最后一步就是使用subscribeOn:，以保证信号在提供的调度器中执行。
}

#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad] ;
    
    self.table.delegate     = self ;
    self.table.dataSource   = self ;
    
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
    
    
    [[[[[[[[self requestAccessToTwitterSignal]
      then:^RACSignal * _Nonnull{
          @strongify(self)
          return self.searchText.rac_textSignal ;
      }]
         throttle:1]
         distinctUntilChanged]
      filter:^BOOL(NSString *text) {
          @strongify(self)
          return [self isValidSearchText:text] ;
      }]
      flattenMap:^__kindof RACSignal * _Nullable(NSString *text) {
          @strongify(self)
          return [self signalForSearchWithText:text] ;
      }]
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(id  _Nullable x) {
         @strongify(self)
         // NSLog(@"xt_result %@" , x) ; // json obj
         NSArray *list = [NSArray yy_modelArrayWithClass:[Book class] json:x[@"books"]] ;
         self.datasource = [list copy] ;
         [self.table reloadData] ;
    }
     error:^(NSError * _Nullable error) {
         @strongify(self)
         NSLog(@"An error occurred: %@", error) ;
         self.lbUserInfo.text = [error localizedDescription] ;
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
    return text.length > 2 ;
}

#pragma mark - tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell"] ;
    Book *abook = self.datasource[indexPath.row] ;
    [cell configure:abook] ;
    
    [[[self signalForCellImage:abook.image]
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(id  _Nullable x) {
        cell.img.image = x ;
    }] ;
    
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BookTableViewCell cellHeight] ;
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
