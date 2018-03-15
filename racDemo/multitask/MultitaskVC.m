//
//  MultitaskVC.m
//  racDemo
//
//  Created by teason23 on 2018/3/15.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "MultitaskVC.h"
#import <ReactiveObjC.h>

@interface MultitaskVC ()
@property (strong,nonatomic) RACSignal *signalA ;
@property (strong,nonatomic) RACSignal *signalB ;

@property (nonatomic) int times ;
@end

@implementation MultitaskVC

- (IBAction)combine:(id)sender {
    
    [[self.signalA combineLatestWith:self.signalB]
     subscribeNext:^(id  _Nullable x) {
         
         RACTupleUnpack(NSString *a,NSString *b) = x ;
         NSLog(@"a :%@,  b:%@",a,b) ;
         
     }] ;
    
}


- (IBAction)zipWith:(id)sender {
//    ZIP
//当且仅当signalA和signalB同时都产生了值的时候，一个value才被输出，signalA和signalB只有其中一个有值时会挂起等待另一个的值，所以输出都是一对值（RACTuple）），当signalA和signalB只要一个先completed，RACStream也解散。
    
    [[self.signalA zipWith:self.signalB]
     subscribeNext:^(id  _Nullable x) {
         RACTupleUnpack(NSString *a,NSString *b) = x ;
         NSLog(@"a :%@,  b:%@",a,b) ;
     }] ;
}

- (IBAction)merge:(id)sender {
//    MERGE
//返回signals当中的最新的next
// 只返回一个. 没有先后顺序.
    [[RACSignal merge:@[self.signalA, self.signalB]]
     subscribeNext:^(id x) {
        NSLog(@"处理%@",x);
    }] ;
}

- (IBAction)concact:(id)sender {
//    CONCACT
//当signalA completed之后 signalB才能执行。 皇帝和太监.
    [[self.signalA concat:self.signalB]
     subscribeNext:^(id  _Nullable x) {
         NSLog(@"concact : %@", x) ;
     }] ;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"a 10s send"] ;
            [subscriber sendCompleted];

        });
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"a Disposable") ;
        }] ;
    }] ;
    
    self.signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"b 5s send"] ;
            [subscriber sendCompleted];

        });
        
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"b Disposable") ;
        }] ;
    }] ;
    
    @weakify(self)
    [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(NSDate * _Nullable x) {
         @strongify(self)
         self.times ++ ;
         NSLog(@"%d",self.times) ;
     }] ;
    

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
