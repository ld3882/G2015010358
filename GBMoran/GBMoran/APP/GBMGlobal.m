//
//  GBMGlobal.m
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMGlobal.h"

static GBMGlobal *glocal = nil;

@implementation GBMGlobal

+ (GBMGlobal *)shareGlobal
{
    if (glocal == nil) {
        glocal = [[GBMGlobal alloc] init];
    }
    return glocal;
}

@end
