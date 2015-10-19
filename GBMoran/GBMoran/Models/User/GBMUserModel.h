//
//  GBMUserModel.h
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBMUserModel : NSObject

@property(nonatomic,copy) NSString *user_id;
@property(nonatomic,copy) NSString *user_name;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,copy) NSString *email;
@property(nonatomic,copy) NSString *token;
@property(nonatomic,copy) NSString *loginReturnMessage;
@property(nonatomic,copy) NSString *registerReturnMessage;
@property(nonatomic,copy) NSString *latitude;
@property(nonatomic,copy) NSString *longitude;
@property(nonatomic,copy) UIImage *image;

@end
