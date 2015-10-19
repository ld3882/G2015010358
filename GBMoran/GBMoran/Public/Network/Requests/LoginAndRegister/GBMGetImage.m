//
//  GBMGetImage.m
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMGetImage.h"
#import "GBMGlobal.h"

@interface GBMGetImage()<NSURLConnectionDataDelegate>

@end

@implementation GBMGetImage

- (void)sendGetImageRequest
{
    [self.URLConnection cancel];
    
    
    NSString *urlString = [NSString stringWithFormat:@"http://moran.chinacloudapp.cn/moran/web/user/show?user_id=%@", [GBMGlobal shareGlobal].user.user_id];
    // GET请求
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    self.URLConnection = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self
                                                 startImmediately:YES];
}

- (void)cancelRequest
{
    if (self.URLConnection) {
        [self.URLConnection cancel];
        self.URLConnection = nil;
    }
}


#pragma mark - NSURLConnectionDataDelegate methods

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode == 200) {   // 连接成功
        self.receivedData = [NSMutableData data];
    }else {
        // 请求错误，错误处理。
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [GBMGlobal shareGlobal].user.image = [UIImage imageWithData:self.receivedData];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}


@end
