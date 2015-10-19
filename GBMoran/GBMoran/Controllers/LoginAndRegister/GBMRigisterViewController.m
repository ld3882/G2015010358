//
//  GBMRigisterViewController.m
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMRigisterViewController.h"
#import "GBMRegisterRequest.h"

@interface GBMRigisterViewController ()<GBMRegisterRequestDelegate>

@property(nonatomic,strong) GBMRegisterRequest *registerRequest;

@end

@implementation GBMRigisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.registerButton.layer.cornerRadius = 5.0;
    self.registerButton.clipsToBounds = YES;
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.repeatPasswordTextField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = self.registerButton.frame;
    int offset = frame.origin.y + 36 - (self.view.frame.size.height - 216);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (offset > 0) {
        self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
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

- (IBAction)registerButtonClicked:(id)sender {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *repeatPassword = self.repeatPasswordTextField.text;
    NSString *gbid = @"G2015010358";
    
    if (([email length] == 0) || ([password length] == 0) || ([repeatPassword length] == 0)) {
        [self showErrorMessage:@"邮箱和密码不能为空"];
    } else if (![self isValidateEmail:email])
    {
        [self showErrorMessage:@"邮箱格式有误"];
    } else if (![self isValidatePassword:password])
    {
        [self showErrorMessage:@"密码格式有误，应为6-20位字母或数字"];
    } else if (![password isEqualToString:repeatPassword])
    {
        [self showErrorMessage:@"两次输入密码不一致"];
    }else {
        [self registerHandle];
    }
}

- (IBAction)touchDownAction:(id)sender {
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.repeatPasswordTextField resignFirstResponder];
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (IBAction)loginButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegax = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegax];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)isValidatePassword:(NSString *)password {
    NSString *passwordRegax = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegax];
    return [passwordTest evaluateWithObject:password];
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

- (void)registerHandle
{
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *gbid = @"G2015010358";
    
    self.registerRequest = [[GBMRegisterRequest alloc] init];
    [self.registerRequest sendRegisterRequestWithUserName:email
                                                 password:password
                                                 delegate:self];
}

#pragma mark - GBMRegisterRequestDelegate methods
- (void)requestSuccess:(GBMRegisterRequest *)request user:(GBMUserModel *)usr
{
    if ([usr.registerReturnMessage isEqualToString:@"Register success"]) {
        [self showErrorMessage:@"注册成功，请登录"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self showErrorMessage:usr.registerReturnMessage];
    }
}

- (void)requestFailed:(GBMRegisterRequest *)request error:(NSError *)error
{
    NSLog(@"注册错误原因：%@",error);
}

@end
