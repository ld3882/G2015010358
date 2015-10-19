//
//  GBMHeadImageViewController.m
//  GBMoran
//
//  Created by ld on 15/10/19.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMHeadImageViewController.h"
#import "GBMGlobal.h"
#import "BLMultipartForm.h"
#import "GBMUserModel.h"

@interface GBMHeadImageViewController ()<NSURLConnectionDataDelegate>

@end

@implementation GBMHeadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeImageButtonClicked:(id)sender {
    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
    pic.sourceType = UIImagePickerControllerSourceTypeCamera;
    pic.delegate = self;
    [self presentViewController:pic animated:YES completion:nil];
}

- (IBAction)doneBarButtonClicked:(id)sender {
    NSURLConnection *URLConnection;
    [URLConnection cancel];
    
    
    
    NSString *URLString = @"http://moran.chinacloudapp.cn/moran/web/user/avatar";
    
    NSString *encodedURLString
    = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:encodedURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    BLMultipartForm *form = [[BLMultipartForm alloc] init];
    
    self.data = UIImageJPEGRepresentation(self.headImageView.image, 0.000001);
    
    GBMUserModel *user = [GBMGlobal shareGlobal].user;
    [form addValue:user.user_id forField:@"user_id"];
    [form addValue:user.token forField:@"token"];
    [form addValue:self.data forField:@"data"];
    request.HTTPBody = [form httpBody];
    [request setValue:form.contentType forHTTPHeaderField:@"Content-Type"];
    URLConnection = [[NSURLConnection alloc] initWithRequest:request
                                                    delegate:self
                                            startImmediately:YES];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [GBMGlobal shareGlobal].user.image = [UIImage imageWithData:self.data];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.headImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
