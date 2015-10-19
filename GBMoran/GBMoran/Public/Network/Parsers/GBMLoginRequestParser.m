//
//  GBMLoginRequestParser.m
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMLoginRequestParser.h"

@implementation GBMLoginRequestParser

- (GBMUserModel *)parseJson:(NSData *)data
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        // 解析出错。
    }else {
        GBMUserModel *user = [[GBMUserModel alloc] init];
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            
            id returnMessage = [jsonDic valueForKey:@"message"];
            if ([[returnMessage class] isSubclassOfClass:[NSString class]]) {
                
                user.loginReturnMessage = returnMessage;

            }
            id data = [jsonDic valueForKey:@"data"];
            if ([[data class] isSubclassOfClass:[NSDictionary class]]) {
                id userId = [data valueForKey:@"data"];
                if ([[userId class] isSubclassOfClass:[NSString class]]) {
                    user.user_id = userId;
                }
                id token = [data valueForKey:@"token"];
                if ([[token class] isSubclassOfClass:[NSString class]]) {
                    user.token = token;
                }
                id userName = [data valueForKey:@"user_name"];
                if ([[userName class] isSubclassOfClass:[NSString class]]) {
                    user.user_name = userName;
                }
            }
        }
    }
    
    return nil;
}


@end
