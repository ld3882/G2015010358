//
//  GBMGlobal.h
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBMUserModel.h"

@interface GBMGlobal : NSObject

@property(nonatomic,strong)GBMUserModel *user;

+(GBMGlobal *)shareGlobal;

@end
