//
//  AppDelegate.m
//  04-POST加密(保存本地数据)
//
//  Created by 王鹏飞 on 16/2/16.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "AppDelegate.h"

#define kUserNameKey @"kUserNameKey"
#define kPasswordKey @"kPasswordKey"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1. 注册登录成功的通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"loginSuccess" object:nil];
    
    // 2. 注册登录成功的通知观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccess) name:@"logoutSuccess" object:nil];
    
    // 每次app打开后，应该展示给用户哪个界面
    // 3. 利用偏好设置中用户保存的信息来判断用户的登录状态
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUserNameKey];
    
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:kPasswordKey];
    
    if (userName && password) {
        // 显示app 主界面
        [self loginSuccess];
    } else {
    
        [self logoutSuccess];
    }
    
    return YES;
}

// 登录成功
- (void)loginSuccess {
    
    NSLog(@"登录成功!");
    
    // 获取主界面
    UIStoryboard *mainSb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    // 切换控制器
    self.window.rootViewController = mainSb.instantiateInitialViewController;
}

// 注销成功
- (void)logoutSuccess {
    NSLog(@"注销成功!");
    
    // 获取登录界面
    UIStoryboard *loginSb = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    
    // 切换控制器
    self.window.rootViewController = loginSb.instantiateInitialViewController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
