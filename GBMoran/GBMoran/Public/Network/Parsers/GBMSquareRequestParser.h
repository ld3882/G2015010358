//
//  GBMSquareRequestParser.h
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBMSquareModel.h"
#import "GBMPictureModel.h"

@interface GBMSquareRequestParser : NSObject

- (NSMutableArray *)parseJson:(NSData *)data;

@end
