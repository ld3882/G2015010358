//
//  GBMPublishRequest.h
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>


@class GBMPublishRequest;

@protocol GBMPublishRequestDelegate <NSObject>

- (void)requestSuccess:(GBMPublishRequest *)request picId:(NSString *)picId;
- (void)requestFailed:(GBMPublishRequest *)request error:(NSError *)error;

@end

@interface GBMPublishRequest : NSObject

@property(nonatomic, strong)NSURLConnection *URLConnection;
@property(nonatomic, strong)NSMutableData *receivedData;
@property(nonatomic, assign)id<GBMPublishRequestDelegate> delegate;

- (void)sendPublishRequestWithUserId:(NSString *)userId
                               token:(NSString *)token
                           longitude:(NSString *)longitude
                             latitue:(NSString *)latitude
                                data:(NSData *)data
                               title:(NSString *)title
                            delegate:(id<GBMPublishRequestDelegate>)delegate;


@end
