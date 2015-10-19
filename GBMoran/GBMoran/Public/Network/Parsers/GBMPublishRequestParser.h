//
//  GBMPublishRequestParser.h
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBMPublishModel.h"

@interface GBMPublishRequestParser : NSObject

- (GBMPublishModel *)parseJson:(NSData *)data;

@end
