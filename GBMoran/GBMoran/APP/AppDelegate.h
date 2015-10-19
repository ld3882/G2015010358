//
//  AppDelegate.h
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBMLoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) GBMLoginViewController *loginViewController;

- (void)loadMainViewWithController:(UIViewController *)controller;
- (void)loadLoginView;

@end

