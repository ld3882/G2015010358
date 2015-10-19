//
//  GBMNickNameViewController.m
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMNickNameViewController.h"
#import "GBMGlobal.h"
#import "BLMultipartForm.h"
#import "GBMUserModel.h"

@interface GBMNickNameViewController ()<NSURLConnectionDataDelegate>

@end

@implementation GBMNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nickNameTextField.delegate =self;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nickNameTextField resignFirstResponder];
    return true;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneBarButtonClicked:(id)sender {
    NSURLConnection *URLConnection;
    [URLConnection cancel];
    
    
    
    NSString *URLString = @"http://moran.chinacloudapp.cn/moran/web/user/rename";
    
    NSString *encodedURLString
    = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:encodedURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    
    GBMUserModel *user = [GBMGlobal shareGlobal].user;
    [form addValue:user.user_id forField:@"user_id"];
    [form addValue:user.token forField:@"token"];
    [form addValue:self.nickNameTextField.text forField:@"new_name"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    URLConnection = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self
                                                 startImmediately:YES];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [GBMGlobal shareGlobal].user.user_name = self.nickNameTextField.text;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
    [self.navigationController popViewControllerAnimated:YES];
}


@end
