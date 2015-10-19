//
//  GBMRegisterRequestParser.h
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBMUserModel.h"

@interface GBMRegisterRequestParser : NSObject

- (GBMUserModel *)parseJson:(NSData *)data;

@end
