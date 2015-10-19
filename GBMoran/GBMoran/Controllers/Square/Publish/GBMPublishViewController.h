//
//  GBMPublishViewController.h
//  GBMoran
//
//  Created by ld on 15/10/18.
//  Copyright © 2015年 lvdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface GBMPublishViewController : UIViewController<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    //MKMapView *_mapview;
}

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) CLGeocoder *geocoder;

- (IBAction)touchDown:(id)sender;
- (IBAction)photoButtonClicked:(id)sender;
- (IBAction)locationButtonClicked:(id)sender;


@end
