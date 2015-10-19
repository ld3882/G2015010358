//
//  GBMLoginRequest.h
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBMUserModel.h"

@class GBMLoginRequest;

@protocol GBMLoginRequestDelegate <NSObject>

- (void)requestSuccess:(GBMLoginRequest *)request user:(GBMUserModel *)usr;
- (void)requestFailed:(GBMLoginRequest *)request error:(NSError *)error;

@end

@interface GBMLoginRequest : NSObject

@property(nonatomic, strong)NSURLConnection *URLConnection;
@property(nonatomic, strong)NSMutableData *receivedData;
@property(nonatomic, assign)id<GBMLoginRequestDelegate> delegate;

- (void)sendLoginRequestWithUserName:(NSString *)userName
                            password:(NSString *)password
                            delegate:(id<GBMLoginRequestDelegate>)delegate;

- (void)cancelRequest;


@end
