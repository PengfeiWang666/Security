//
//  ViewController.m
//  07-MD5加密
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
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // MD5加密现在一般不用于加密，多用于验证一致性(百度MD5解密，第一个网站进去，数据库伪解密)
    // 由于MD5加密的特点，“数字指纹”--- 文件的“指纹”，在文件的下载过程中，用于验证文件是否损坏（是否认为添加木马，篡改文件内容等）
    NSString *password = @"WangPengfei";
    
    password = [password md5String];
    
    NSLog(@"password1:%@", password);
    
    // 加盐:可以保证 MD5加密之后更加安全
    // 每一个公司都有自己的“盐值”，盐值越复杂，越安全
    NSString *salt = @"234567890-!@#$%^&*()_+QWERTYUIOP{ASDFGHJKL:XCVBNM<>";
    
    [password stringByAppendingString:salt];
    
    password = [password md5String];
    
    NSLog(@"password2:%@", password);
}

@end
