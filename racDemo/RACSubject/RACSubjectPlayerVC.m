//
//  RACSubjectPlayerVC.m
//  racDemo
//
//  Created by xtc on 2018/1/31.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "RACSubjectPlayerVC.h"
#import <ReactiveObjC.h>
#import "RACSubjectSecondVC.h"

@interface RACSubjectPlayerVC ()
@property (weak, nonatomic) IBOutlet UIButton *bt1;
@property (weak, nonatomic) IBOutlet UIButton *bt_subject;
@property (weak, nonatomic) IBOutlet UIButton *bt_ReplaySubject;

@property (weak, nonatomic) IBOutlet UIButton *bt_asDelegate;

@end

@implementation RACSubjectPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self)
    
    // demos
    [[_bt1 rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self racSignalTest] ;
    }] ;
    
    [[_bt_subject rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self racSubjectTest] ;
     }] ;
    
    [[_bt_ReplaySubject rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self RACReplaySubject] ;
     }] ;
    
    
    // As delegate
    
    [[_bt_asDelegate rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
         
         RACSubject *subject = [RACSubject subject];
         [subject subscribeNext:^(id x) {
             NSLog(@"inner 被通知了:%@",x) ;
         }] ;
         [self performSegueWithIdentifier:@"subjectAsDelegate" sender:subject] ;
         
     }] ;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //subjectAsDelegate
    RACSubjectSecondVC *toVC = [segue destinationViewController] ;
    toVC.aSubject = sender ;
}


#pragma mark - demos

- (void)racSignalTest {
    
    __block int number = 1 ;
    // replay ---- 解决 side effects
    RACSignal *signal = //[
                         [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
                                [subscriber sendNext:@(number)];
                                number ++ ;
                                [subscriber sendCompleted];
                                return [RACDisposable disposableWithBlock:^{
                                    NSLog(@"信号被摧毁") ;
                                }] ;
                         }] ;
//                         replay] ;
    
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }] ;
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }] ;
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }] ;
}


//RACSubject:信号提供者，自己可以充当信号，又能发送信号。
//创建方法：
//（1）创建RACSubject
//（2）订阅信号
//（3）发送信号
//工作流程：
//（1）订阅信号时，内部保存了订阅者，和订阅者响应block
//（2）当发送信号的，遍历订阅者，调用订阅者的nextBlock
//注：如果订阅信号，必须在发送信号之前订阅信号，不然收不到信号，这也有别于RACReplaySubject
- (void)racSubjectTest {

    RACSubject *subject = [RACSubject subject] ;
    [subject subscribeNext:^(id x) {
        NSLog(@"1 %@",x);
    }];
    [subject subscribeNext:^(id x) {
        NSLog(@"2 %@",x);
    }];
    [subject sendNext:@1] ;
    
    // 不会出来
    [subject subscribeNext:^(id x) {
        NSLog(@"3 %@",x);
    }];
}

//RACReplaySubject 创建方法：
//（1）创建RACSubject
//（2）订阅信号
//（3）发送信号
//工作流程：
//（1）订阅信号时，内部保存了订阅者，和订阅者响应block
//（2）当发送信号的，遍历订阅者，调用订阅者的nextBlock
//（3）发送的信号会保存起来，当订阅者订阅信号的时，会将之前保存的信号，一个一个作用于新的订阅者，保存信号的容量由capacity决定，这也是有别有RACSubject的
- (void)RACReplaySubject {
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"1 %@",x);
    }];
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"2 %@",x);
    }];
    [replaySubject sendNext:@3333];
    
    // 会出来
    [replaySubject subscribeNext:^(id x) {
        NSLog(@"3 %@",x);
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
