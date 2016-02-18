//
//  ViewController.m
//  10-钥匙串访问
//
//  Created by 王鹏飞 on 16/2/18.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "ViewController.h"
#import "SSKeychain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 获得app 的唯一标识符
    NSString *identifier = [NSBundle mainBundle].bundleIdentifier;
    
    // 2. 取出钥匙串中存储的密码
    NSString *password = [SSKeychain passwordForService:identifier account:@"zhangsan"];
    
    // 3. 打印密码
    NSLog(@"%@", password);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSLog(@"touchesBegan");
    
    /* 
     钥匙串存储特点：
     1. 只存储私密信息(密码)
     2. 私密信息可以直接以明文的形式存储
     3.钥匙串的位置不知道在哪里，在钥匙串中存、取数据的时候，依赖于app
     
     
     // 参数
     // Password :需要存储的密码信息.
     // Service :用来标识 app ,app的唯一标识符.
     // account :账户信息,当前密码所对应的账号.
    */
    
    // 1. 获得app 的唯一标识符
    NSString *identifier = [NSBundle mainBundle].bundleIdentifier;
    
    // 存储密码
    [SSKeychain setPassword:@"sssss" forService:identifier account:@"zhangsan"];
}

@end
