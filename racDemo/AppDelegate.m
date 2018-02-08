//
//  AppDelegate.m
//  racDemo
//
//  Created by xtc on 2018/1/19.
//  Copyright © 2018年 xtc. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self sendLocalNotification:5] ;
    completionHandler(UIBackgroundFetchResultNewData) ;
}

//使用 UNNotification 本地通知
- (void)registerNotification {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    //监听回调事件
    center.delegate = self;
    
    //iOS 10 使用以下方法注册，才能得到授权，注册通知以后，会自动注册 deviceToken，如果获取不到 deviceToken，Xcode8下要注意开启 Capability->Push Notification。
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                          }] ;
    
    //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        NSLog(@"UNNotificationSettings : %@",settings) ;
    }] ;
}

- (void)sendLocalNotification:(NSInteger )alerTime {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"nimagebi" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"dadfadf"
                                                         arguments:nil] ;
    content.sound = [UNNotificationSound defaultSound];
    content.badge = @(2) ;

    
    // 在 alertTime 后推送本地推送
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:alerTime repeats:NO];
    
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }] ;
}





//需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。


#pragma mark - UNUserNotificationCenterDelegate
//在展示通知前进行处理，即有机会在展示通知前再修改通知内容。
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    //1. 处理通知
    
    //2. 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound) ;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self registerNotification] ;
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum] ;
//    application.applicationIconBadgeNumber = 0 ;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
