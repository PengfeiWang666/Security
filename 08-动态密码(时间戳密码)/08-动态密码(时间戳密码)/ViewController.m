//
//  ViewController.m
//  08-动态密码(时间戳密码)
//
//  Created by 王鹏飞 on 16/2/17.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Hash.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 动态密码：服务器会计算两个时间值,当期时间和前一分钟的时间
    
    // 为了保证服务器在下一分钟接收到客户端的密码内容之后，仍然能够判断准确的值
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 1. 当前密码
    NSString *password = @"zhang";
    
    // 2. hmacKey值，是对“WangPengfei” 进行 MD5加密之后的值（动态生成的）
    NSString *hmacKey = @"d3bba33b51acaa0a272de7a2f6dfa233";
    
    // 加密过程
    
    // 1. 第一次加密：第一次 HMAC 运算
    password = [password hmacMD5StringWithKey:hmacKey];
    
    // 2.1 获得当前的时间
    NSDate *date = [NSDate date];
    
    // 2.2 获得当前时间的字符串
    // 实例化时间格式器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 设置时间格式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    // 获取当前时间（要和服务器保持一致）
    NSString *dateStr = [formatter stringFromDate:date];
    
    // 3. 将第一次加密后的密码与当前时间的字符串拼接在一起
    password = [password stringByAppendingString:dateStr];
    
    // 4. 进行第二次 HMAC 加密
    password = [password hmacMD5StringWithKey:hmacKey];
    
    NSLog(@"password:%@", password);
    
    
    // 访问 loginhmac.php 接口
    
    // 1. 创建请求
    NSURL *url = [NSURL URLWithString:@"http://localhost/login/loginhmac.php"];
    
    // POST 要手动设置方法，因此为可变
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方法
    request.HTTPMethod = @"POST";
    
    // 设置请求体内容
    NSString *body = [NSString stringWithFormat:@"username=zhangsan&password=%@", password];
    
    
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    // 2. 发送请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }] resume];
    
    
}

@end
