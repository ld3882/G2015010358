//
//  GBMNickNameViewController.h
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBMNickNameViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

- (IBAction)doneBarButtonClicked:(id)sender;


@end
