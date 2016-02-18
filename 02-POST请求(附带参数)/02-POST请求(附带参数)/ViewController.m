//
//  ViewController.m
//  02-POST请求(附带参数)
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
    
    
    // POST 请求是指 向服务器发送表单
    
    // POST 请求是安全的，在网络中传输私密信息(银行卡信息/密码信息)必须使用 POST 请求
    
    // 所有的文件(数据量比较大)上传都使用 POST 请求
    
    // 文件的上传使用 PUT 还是 POST 请求? 利用 POST 来取代 PUT
    
    // 增(PUT)删(DELETE)改(POST)查(GET),NSURLSession 的上传默认是使用 PUT 请求,所以直接使用 NSUrlSession 中的上传任务不能满足文件上传的需求
    
    // 评论结构:使用 GET 请求还是 POST 请求?
    
    // 接口要求: 评论结构中可以附带图片(文件)参数. POST
    // 接口要求: 不能附带文件信息,只能附带文字信息. GET / POST(注意字数要求)
}

// POST 请求发送数据请求
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 1. 创建请求
    NSString *urlString = @"http://localhost/login/login.php";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    // 对于POST请求，必须手动设置其请求方法，因此要使用可变请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 设置请求方法
    request.HTTPMethod = @"POST";
    
#warning 这里的参数不加问号
    // 设置请求参数
    NSString *body = @"username=zhangsan&password=zhang";
    
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];   // 转化为二进制数据
    
    request.HTTPBody = data;
    
    // 2. 发送请求
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"response(响应行/响应头):%@", response);
        
        NSLog(@"data(实体内容):%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }] resume];
    
}

/*
打印结果：
 
response(响应行/响应头):<NSHTTPURLResponse: 0x7fbfb0e97200> { URL: http://localhost/login/login.php } { status code: 200, headers {
 Connection = "Keep-Alive";
 "Content-Length" = 34;
 "Content-Type" = "application/json;charset=utf-8";
 Date = "Tue, 16 Feb 2016 11:51:56 GMT";
 "Keep-Alive" = "timeout=5, max=100";
 Server = "Apache/2.4.16 (Unix) PHP/5.5.27";
 "X-Powered-By" = "PHP/5.5.27";
 } }
 
data(实体内容):{"userId":1,"userName":"zhangsan"}
 */

@end
