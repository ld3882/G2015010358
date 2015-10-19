//
//  GBMHeadImageViewController.h
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBMHeadImageViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) NSData *data;


- (IBAction)changeImageButtonClicked:(id)sender;

- (IBAction)doneBarButtonClicked:(id)sender;
@end
