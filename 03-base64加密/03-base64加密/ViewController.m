//
//  ViewController.m
//  03-base64加密
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 加密字符串
    NSString *string = @"I MISS YOU";
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"data:%@", data);
    
    // 进行base64 加密
//    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    
    NSLog(@"base64Data:%@", base64String);
    
    // 直接将加密后的字符串进行base64 解密(可以反向)
    NSData *baseData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    
    // 将解密后产生的二进制数据转为字符串
    NSString *baseStr = [[NSString alloc] initWithData:baseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"baseStr:%@", baseStr);
    
    /*
    输出结果：
     data:<49204d49 53532059 4f55>
     base64Data:SSBNSVNTIFlPVQ==
     baseStr:I MISS YOU
     */
    
}

// 解密图片
- (void)test2 {
    
    // 获得加密后的二进制数据
    NSData *base64Data = [NSData dataWithContentsOfFile:@"/Users/wangpengfei/Desktop/123"];
    
    // 解密 base64 数据
    NSData *baseData = [[NSData alloc] initWithBase64EncodedData:base64Data options:0];
    
    // 写入桌面
    [baseData writeToFile:@"/Users/wangpengfei/Desktop/IMG_5551.jpg" atomically:YES];
}

// 将图片进行加密
- (void)test1 {
    
    // 获取需要加密文件的二进制数据
    NSData *data = [NSData dataWithContentsOfFile:@"/Users/wangpengfei/Desktop/photo/IMG_5551.jpg"];
    
    // 打印该图片二进制数据
    NSLog(@"data:%@", data);
    
    // base64 加密是 Xcode7.0 之后出现的
    // 或 base64EncodedStringWithOptions
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    
    // 将加密后的文件存储到桌面
    [base64Data writeToFile:@"/Users/wangpengfei/Desktop/123" atomically:YES];
}

@end
