//
//  GBMSquareRequest.m
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMSquareRequest.h"
#import "BLMultipartForm.h"
#import "GBMSquareRequestParser.h"

@implementation GBMSquareRequest

- (void)sendSquareRequestWithUserid:(NSString *)userid distance:(NSString *)distance latitude:(NSString *)latitude longitude:(NSString *)longitude token:(NSString *)token delegate:(id<GBMSquareRequestDelegate>)delegate
{
    [self.urlConnection cancel];
    
    self.delegate = delegate;
    
    NSString *urlString = [NSString stringWithFormat:@"http://moran.chinacloudapp.cn/moran/web/node/list?distance=%@&latitude=%@&longitude=%@&token=%@&user_id=%@", distance, latitude, longitude, token, userid];
    // GET请求
    NSString *encodeURLString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodeURLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    self.urlConnection = [[NSURLConnection alloc] initWithRequest:request
                                                         delegate:self
                                                 startImmediately:YES];
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
    NSString *string = [[NSString alloc] initWithData:self.receivedData
                                             encoding:NSUTF8StringEncoding];
    NSLog(@"%@", string);
    
    GBMSquareRequestParser *parser = [[GBMSquareRequestParser alloc] init];
    NSMutableArray *modelArray = [parser parseJson:self.receivedData];
    
    if ([_delegate respondsToSelector:@selector(requestSuccess:squareModelArray:)]) {
        [_delegate requestSuccess:self squareModelArray:modelArray];
    }
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
    if ([_delegate respondsToSelector:@selector(requestFailed:error:)]) {
        [_delegate requestFailed:self error:error];
    }
}

@end
