//
//  ViewController.m
//  01-GET请求(附带参数)
//
//  Created by 王鹏飞 on 16/2/16.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#warning 必须联网才可以实现发送数据的请求

// 利用 GET 发送数据请求
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 1. 创建请求
    // http://localhost/login/login.php: 接口地址.
    NSString *urlString = @"http://localhost/login/login.php";
    
    // 拼接字符串
    // username/password：存储账号和密码的key，由服务器后台提供
#warning 这里拼接的字符串需要用 ? 连接
    urlString = [urlString stringByAppendingString:@"?password=zhang&username=zhangsan"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2. 发送请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"responseData:%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }] resume];
}

/*
打印结果：
 
 responseData:{"userId":1,"userName":"zhangsan"}
 */

@end
