//
//  GBMRigisterViewController.h
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBMRigisterViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTextField;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)registerButtonClicked:(id)sender;

- (IBAction)touchDownAction:(id)sender;

- (IBAction)loginButtonClicked:(id)sender;


@end
