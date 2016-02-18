//
//  ViewController.m
//  04-POST加密(保存本地数据)
//
//  Created by 王鹏飞 on 16/2/16.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "ViewController.h"

#define kUserNameKey @"kUserNameKey"
#define kPasswordKey @"kPasswordKey"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     登录的业务逻辑：
     1> 首次登录，进入登录界面
     2> 首次登录成功，则第二次直接进入app主界面
     3> 首次登录失败，则第二次进入登录界面
     4> 进行注销操作后，清除本地信息，进入登录界面
     */
}

- (IBAction)btnLoginDidClick:(UIButton *)sender {
    
    // 如果两个文本框均不为空，则进行登录操作
    if (self.userName.text.length && self.password.text.length) {
        
        // 1. 创建请求
        NSString *urlString = @"http://localhost/login/login.php";
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        // POST 请求需要手动设置请求方法，因此为可变请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        // 设置请求方法
        request.HTTPMethod = @"POST";
        
        // 设置请求参数
        NSString *body = [NSString stringWithFormat:@"username=%@&password=%@", self.userName.text, self.password.text];
        
        // 将字符串转为二进制数据
        NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
        
        // 设置请求主体(二进制数据)
        request.HTTPBody = bodyData;
        
        // 2. 发送请求
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            // 打印请求结果
            NSLog(@"data:%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
            // 判断是否登录成功
            if (data && !error) {
                NSLog(@"网络请求成功!");
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                if (dict[@"userID"]) {
                    [self saveLocalUserInfo];
                }
            } else {
                NSLog(@"网络请求失败!");
            }
            
        }] resume];
    } else {
        NSLog(@"用户名或密码不能为空!");
    }
}

// 抽取出读取数据的方法
- (void)readLocalUserInfo {
    
    // 1. 实例化偏好设置对象
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 2. 取出数据进行赋值
    self.userName.text = [userDefaults objectForKey:kUserNameKey];
    
    // 此时读取的是加密后的密码
    self.password.text = [userDefaults objectForKey:kPasswordKey];
}

// 抽取出存储数据的方法
- (void)saveLocalUserInfo {

    // 1. 实例化偏好设置对象
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 2. 存储用户名
    [userDefaults setObject:self.userName.text forKey:kUserNameKey];
    
    // 3. 将密码进行base64 加密
    // 将密码转化为二进制数据
    NSData *data = [self.password.text dataUsingEncoding:NSUTF8StringEncoding];
    
    // 进行加密
    NSString *base64Str = [data base64EncodedStringWithOptions:0];
    
    // 4. 将加密后的密码存储到偏好设置
    [userDefaults setObject:base64Str forKey:kPasswordKey];
    
    // 5. 为了保证线程的一致性，无论是存储还是读取数据，都要进行同步
    [userDefaults synchronize];
}

@end
