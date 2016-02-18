//
//  WPFTableViewController.m
//  04-POST加密(保存本地数据)
//
//  Created by 王鹏飞 on 16/2/16.
//  Copyright © 2016年 王鹏飞. All rights reserved.
//

#import "WPFTableViewController.h"

#define kUserNameKey @"kUserNameKey"
#define kPasswordKey @"kPasswordKey"

@interface WPFTableViewController ()

@end

@implementation WPFTableViewController

- (IBAction)btnLogoutDidClick:(UIBarButtonItem *)sender {
    
    // 1. 清除本地信息
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserNameKey];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPasswordKey];
    
    // 同步信息
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 2. 发送信息，切换控制器
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logoutSuccess" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // token 值: 登录令牌.利用 token 值来判断用户的登录状态.类似于 MD5 加密之后的长字符串.
    
    // 用户登录成功之后,在后端(服务器端)会根据用户信息生成一个唯一的值.这个值就是 token 值.
    
    // 1. 在服务器端(数据库)会保存这个 token 值,以后利用这个 token 值来检索对应的用户信息,并且判断用户的登录状态.
    
    // 2. 用户登录成功之后,服务器会将生成的 token 值返回给 客户端,在客户端也会保存这个 token 值.(一般可以保存在 cookie 中,也可以自己手动确定保存位置(比如偏好设置.)).
    
    // 3. 以后客户端在发送新的网络请求的时候,会默认自动附带这个 token 值(作为一个参数传递给服务器.).服务器拿到客户端传递的 token 值跟保存在 数据库中的 token 值做对比,以此来判断用户身份和登录状态.
    
    // 判断登录状态:
    
    // 1. 如果客户端没有这个 token 值,意味着没有登录成功过,提示用户登录.
    
    // 2. 如果客户端有 token 值,一般会认为登录成功.不需要用户再次登录(输入账号和密码信息).
    
    // token 值扩展:
    
    // 1. token 值有失效时间; 一般的 app ,token值得失效时间都在 1 年以上.
    // 特殊的 app :银行类 app /支付类 app :token值失效时间 15 分钟左右.
    
    // 2. token 值改变: 可以做 唯一性登录的判断,也可以检查用户信息的改变.
    
    // 一旦用户信息改变(密码改变),会在服务器生成新的  token 值,原来的 token值就会失效.需要再次输入账号和密码,以得到生成的新的 token 值.
    
    // 唯一性判断: 每次登录,都会生成一个新的token值.原来的 token 值就会失效.利用时间来判断登录的差异性.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
