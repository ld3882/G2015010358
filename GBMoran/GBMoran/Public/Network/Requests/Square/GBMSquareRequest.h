//
//  GBMSquareRequest.h
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBMSquareModel.h"
#import "GBMUserModel.h"

@class GBMSquareRequest;

@protocol GBMSquareRequestDelegate <NSObject>

- (void)requestSuccess:(GBMSquareRequest *)request squareModelArray:(NSMutableArray *)modelarray;
- (void)requestFailed:(GBMSquareRequest *)request error:(NSError *)error;

@end

@interface GBMSquareRequest : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *urlConnection;
@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, assign) id <GBMSquareRequestDelegate> delegate;

- (void)sendSquareRequestWithUserid:(NSString *)userid
                           distance:(NSString *) distance
                           latitude:(NSString *) latitude
                          longitude:(NSString *)longitude
                              token:(NSString *)token
                           delegate:(id <GBMSquareRequestDelegate>)delegate;

@end