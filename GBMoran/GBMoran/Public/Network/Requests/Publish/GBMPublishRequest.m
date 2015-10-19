//
//  GBMPublishRequest.m
//  GBMoran
//
//  Created by ld on 15/10/12.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMPublishRequest.h"
#import "BLMultipartForm.h"
#import "GBMPublishRequestParser.h"
#import "GBMPublishModel.h"

@interface GBMPublishRequest()<NSURLConnectionDataDelegate>

@end

@implementation GBMPublishRequest

- (void)sendPublishRequestWithUserId:(NSString *)userId token:(NSString *)token longitude:(NSString *)longitude latitue:(NSString *)latitude data:(NSData *)data title:(NSString *)title delegate:(id<GBMPublishRequestDelegate>)delegate
{
    [self.URLConnection cancel];
    
    
    self.delegate = delegate;
    NSString *URLString = @"http://moran.chinacloudapp.cn/moran/web/picture/create";
    
    
    NSString *encodedURLString
    = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:encodedURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    [form addValue:userId forField:@"user_id"];
    [form addValue:token forField:@"token"];
    [form addValue:data forField:@"data"];
    [form addValue:title forField:@"title"];
    [form addValue:@"" forField:@"location"];
    [form addValue:longitude forField:@"longitude"];
    [form addValue:latitude forField:@"latitude"];
    
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
    
    GBMPublishRequestParser *parser = [[GBMPublishRequestParser alloc] init];
    GBMPublishModel *model = [parser parseJson:self.receivedData];
    
    if ([_delegate respondsToSelector:@selector(requestSuccess:picId:)]) {
        [_delegate requestSuccess:self picId:model.picId];
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
