//
//  GBMSquareRequestParser.m
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMSquareRequestParser.h"

@implementation GBMSquareRequestParser

- (NSMutableArray *)parseJson:(NSData *)data
{
    NSError *error = nil;
    id jsonDic = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingAllowFragments
                                                   error:&error];
    
    
    NSMutableArray *squareModelArray = [[NSMutableArray alloc] init];
    if (error) {
        NSLog(@"The parser is not work.");
    } else {
        
        if ([[jsonDic class] isSubclassOfClass:[NSDictionary class]]) {
            
            id data = [[jsonDic valueForKey:@"data"] allValues];

            for (id dic in data) {
                GBMSquareModel *squareModel = [[GBMSquareModel alloc] init];
                squareModel.addr = dic[@"node"];
                for (id picDictionary in dic[@"pic"]) {
                    GBMPictureModel *pictureModel = [[GBMPictureModel alloc] init];
                    pictureModel.pic_id = picDictionary[@"pic_id"];
                    pictureModel.pic_link = picDictionary[@"pic_link"];
                    pictureModel.title = picDictionary[@"title"];
                    [squareModel.pictureArray addObject:pictureModel];
                }
                [squareModelArray addObject:squareModel];
                
            }
        }
    }
    return squareModelArray;
}


@end
