//
//  GBMRegisterRequest.h
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBMUserModel.h"

@class GBMRegisterRequest;

@protocol GBMRegisterRequestDelegate <NSObject>

- (void)requestSuccess:(GBMRegisterRequest *)request user:(GBMUserModel *)usr;
- (void)requestFailed:(GBMRegisterRequest *)request error:(NSError *)error;

@end

@interface GBMRegisterRequest : NSObject

@property(nonatomic, strong)NSURLConnection *URLConnection;
@property(nonatomic, strong)NSMutableData *receivedData;
@property(nonatomic, assign)id<GBMRegisterRequestDelegate> delegate;

- (void)sendRegisterRequestWithUserName:(NSString *)userName
                            password:(NSString *)password
                            delegate:(id<GBMRegisterRequestDelegate>)delegate;

- (void)cancelRequest;

@end
