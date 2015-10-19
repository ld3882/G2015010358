//
//  GBMRegisterRequestParser.m
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMRegisterRequestParser.h"

@implementation GBMRegisterRequestParser

- (GBMUserModel *)parseJson:(NSData *)data
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        // 解析出错。
    }else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            
            id returnMessage = [jsonDic valueForKey:@"message"];
            if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
                GBMUserModel *user = [[GBMUserModel alloc] init];
                user.loginReturnMessage = returnMessage;
                return user;
            }
        }
    }
    
    return nil;
}

@end
