//
//  ViewController.h
//  kcg
//
//  Created by Lee, Chia-Pei on 2015/9/3.
//  Copyright (c) 2015年 Lee, Chia-Pei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

static NSString *annotationViewReuseIdentifier      = @"annotationViewReuseIdentifier";
static NSString *CurrentLocation                    = @"Current Location";

@interface MapViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate>
{
    IBOutlet MKMapView      *thisMap;
    NSArray                 *aAllMRTStation;
    NSMutableArray          *allPoint;
}
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

