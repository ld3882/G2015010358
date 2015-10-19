//
//  GBMLoginViewController.m
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMLoginViewController.h"
#import "GBMLoginRequest.h"
#import "AppDelegate.h"
#import "GBMGlobal.h"
#import "GBMGetImage.h"

@interface GBMLoginViewController ()<GBMLoginRequestDelegate>

@property(nonatomic,strong) GBMLoginRequest *loginRequest;

@end

@implementation GBMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonClicked:(id)sender {
    NSString *userName = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if (([userName length] == 0) || ([password length] == 0)) {
        [self showErrorMessage:@"邮箱和密码不能为空"];
    } else {
        [self loginHandle];
    }
}

- (IBAction)touchDownAction:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)showErrorMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)loginHandle
{
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *gbid = @"G2015010358";
    
    self.loginRequest = [[GBMLoginRequest alloc] init];
    [self.loginRequest sendLoginRequestWithUserName:email
                                           password:password
                                           delegate:self];
}

#pragma mark - GBMLoginRequestDelegate methods

- (void)requestSuccess:(GBMLoginRequest *)request user:(GBMUserModel *)usr
{
    if ([usr.loginReturnMessage isEqualToString:@"Login success"]) {
        NSLog(@"登陆成功，现在转换页面");
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate loadMainViewWithController:self];
        [GBMGlobal shareGlobal].user = usr;
        [GBMGlobal shareGlobal].user.email = self.emailTextField.text;
        GBMGetImage *getImageRequest = [[GBMGetImage alloc] init];
        [getImageRequest sendGetImageRequest];
        
    } else {
        NSLog(@"服务器报错:%@",usr.loginReturnMessage);
    }
}



@end
