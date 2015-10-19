//
//  GBMPublishViewController.m
//  GBMoran
//
//  Created by ld on 15/10/18.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import "GBMPublishViewController.h"
#import "GBMPublishCell.h"
#import "GBMPublishRequest.h"
#import "GBMPublishModel.h"
#import "GBMUserModel.h"
#import "GBMGlobal.h"

#define selfWidth self.view.frame.size.width
#define selfHeight self.view.frame.size.height

@interface GBMPublishViewController ()<GBMPublishRequestDelegate>
{
    BOOL openOrNot;
}

@property(nonatomic,strong) UITableView *tableview;
@property(nonatomic,strong) UIControl *blackView;

@end

@implementation GBMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.delegate = self;
    
    [self makePublishButtom];
    self.navigationController.navigationBar.backgroundColor = [[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    self.navigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:230/255.0 green:106/255.0 blue:58/255.0 alpha:1];
    [self.navigationController.navigationBar setAlpha:1.0];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-30, 10, 100, 30)];
    label.text = @"发布照片";
    label.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:label];
    [self startLocation];
    [self reversLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makePublishButtom {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-65, 0, 50, 40)];
    button.backgroundColor = [UIColor whiteColor];
    button.alpha = 0.8;
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(publishPhotoButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 3.0;
    button.clipsToBounds = YES;
    [self.navigationController.navigationBar addSubview:button];
}

- (void)makeTableView {
    if (!self.tableview) {
        self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, selfHeight, selfWidth, 230) style:UITableViewStylePlain];
        [self.tableview setDataSource:self];
        [self.tableview setDelegate:self];
        [self.tableview setBackgroundColor:[UIColor whiteColor]];
        [self.tableview setSeparatorColor:[UIColor blackColor]];
        [self.tableview setShowsHorizontalScrollIndicator:NO];
        [self.tableview setShowsVerticalScrollIndicator:YES];
        [self.tableview registerNib:[UINib nibWithNibName:@"GBMPublishCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"publishCell"];
        [self.view addSubview:self.tableview];
        openOrNot = NO;
    }
    
    if (openOrNot == NO) {
        _blackView = [[UIControl alloc] initWithFrame:CGRectMake(0,0,selfWidth, selfHeight-230)];
        [_blackView addTarget:self action:@selector(blackViewTouchDown) forControlEvents:UIControlEventTouchDown];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0;
        [self.view addSubview:_blackView];
        [UIView animateWithDuration:1 animations:^{
            [self.tableview setFrame:CGRectMake(0, selfHeight-230, selfWidth, 230)];
            _blackView.alpha = 0.5;
        }];
        openOrNot = YES;
    } else {
        [UIView animateWithDuration:1 animations:^{
            [self.tableview setFrame:CGRectMake(0, selfHeight, selfWidth, 230)];
            _blackView.alpha = 0;
        }];
        [_blackView removeFromSuperview];
        openOrNot = NO;
    }
}

- (void)showErrorMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 25) {
        [self.textView resignFirstResponder];
    }
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/25",textView.text.length];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"你想说的话"]) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length < 1) {
        textView.text = @"你想说的话";
    }
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GBMPublishCell *cell = [tableView dequeueReusableCellWithIdentifier:@"publishCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.nameLabel.text = @"上海";
    cell.placeLabel.text = @"上海浦东国际金融中心";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (openOrNot == YES) {
        [self makeTableView];
    }
}

- (void)blackViewTouchDown
{
    if (openOrNot == YES) {
        [self makeTableView];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)touchDown:(id)sender {
    [self.textView resignFirstResponder];
}

#pragma mark 发布照片事件

- (void)publishPhotoButtonClicked:(id)sender
{
    NSData *data = UIImageJPEGRepresentation(self.photoView.image, 1.0);
    GBMPublishRequest *request = [[GBMPublishRequest alloc] init];
    GBMUserModel *user = [GBMGlobal shareGlobal].user;
    
    [request sendPublishRequestWithUserId:user.user_id token:user.token longitude:@"1" latitue:@"1" data:data title:self.textView.text delegate:self];
    
}

- (void)requestSuccess:(GBMPublishRequest *)request picId:(NSString *)picId
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestFailed:(GBMPublishRequest *)request error:(NSError *)error
{
    [self showErrorMessage:@"发布错误"];
}

- (IBAction)photoButtonClicked:(id)sender {
    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
    pic.sourceType = UIImagePickerControllerSourceTypeCamera;
    pic.delegate = self;
    [self presentViewController:pic animated:YES completion:nil];
}

- (IBAction)locationButtonClicked:(id)sender {
    [self startLocation];
}

- (void)startLocation
{
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
    } else {
        [self.locationManager startUpdatingLocation];
    }
}

- (void)reversLocation
{
    if (self.geocoder == nil) {
        self.geocoder = [[CLGeocoder alloc] init];
    }

    [self.geocoder reverseGeocodeLocation:self.currentLocation
                        completionHandler:^(NSArray *placemarks, NSError *error){
                            if (error) {
                                NSLog(@"%@", error.description);
                            }else {
                                if ([placemarks count] > 0) {
                                    CLPlacemark *placemark = [placemarks objectAtIndex:0];
                                    _locationButton.titleLabel.text = [NSString stringWithFormat:@"%@ %@ %@",placemark.country,placemark.postalCode,placemark.locality];
                                }
                            }
                        }];
}

#pragma mark - CLLocationManagerDelegate methods

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待用户授权");
    }else if (status == kCLAuthorizationStatusAuthorizedAlways ||
              status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        
    } else {
        NSLog(@"授权失败");
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.locationManager stopUpdatingLocation];
    NSLog(@"%@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    [self.locationManager stopUpdatingLocation];
    self.currentLocation = newLocation;
    [self reversLocation];
    //    CLLocationDistance distance = [newLocation distanceFromLocation:oldLocation];
    // _locationLabel.text = [NSString stringWithFormat:@"(%f,%f)", newLocation.coordinate.latitude,newLocation.coordinate.longitude];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.photoView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
