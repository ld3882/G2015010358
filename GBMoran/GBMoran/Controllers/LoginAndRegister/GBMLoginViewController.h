//
//  GBMLoginViewController.h
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBMLoginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonClicked:(id)sender;

- (IBAction)touchDownAction:(id)sender;


@end
