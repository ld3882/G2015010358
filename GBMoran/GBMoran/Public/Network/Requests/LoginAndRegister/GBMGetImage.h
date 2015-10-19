//
//  GBMGetImage.h
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBMGetImage : NSObject

@property(nonatomic, strong)NSURLConnection *URLConnection;
@property(nonatomic, strong)NSMutableData *receivedData;

- (void)sendGetImageRequest;

@end
