//
//  GBMRegisterRequest.m
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMRegisterRequest.h"
#import "BLMultipartForm.h"
#import "GBMRegisterRequestParser.h"

@interface GBMRegisterRequest()<NSURLConnectionDataDelegate>

@end

@implementation GBMRegisterRequest

- (void)sendRegisterRequestWithUserName:(NSString *)userName password:(NSString *)password delegate:(id<GBMRegisterRequestDelegate>)delegate
{
    NSString *gbid = @"";
    
    [self.URLConnection cancel];
    
    
    self.delegate = delegate;
    NSString *URLString = @"http://moran.chinacloudapp.cn/moran/web/user/register";
    
    
    NSString *encodedURLString
    = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:encodedURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:userName forField:@"username"];
    [form addValue:userName forField:@"email"];
    [form addValue:password forField:@"password"];
    [form addValue:gbid forField:@"gbid"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
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
    NSString *string = [[NSString alloc] initWithData:self.receivedData
                                             encoding:NSUTF8StringEncoding];
    NSLog(@"%@", string);
    
    GBMRegisterRequestParser *parser = [[GBMRegisterRequestParser alloc] init];
    GBMUserModel *user = [parser parseJson:self.receivedData];
    
    if ([_delegate respondsToSelector:@selector(requestSuccess:user:)]) {
        [_delegate requestSuccess:self user:user];
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
