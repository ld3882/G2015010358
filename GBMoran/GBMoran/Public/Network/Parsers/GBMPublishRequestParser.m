//
//  GBMPublishRequestParser.m
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMPublishRequestParser.h"

@implementation GBMPublishRequestParser

- (GBMPublishModel *)parseJson:(NSData *)data
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        // 解析出错。
    }else {
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            
            id returnMessage = [jsonDic valueForKey:@"data"];
            id returnPic = [returnMessage valueForKey:@"pic_id"];
            if ([[returnPic class] isSubclassOfClass:[NSString class]]) {
                GBMPublishModel *model = [[GBMPublishModel alloc] init];
                model.picId = returnPic;
                return model;
            }
        }
    }
    
    return nil;
}

@end
