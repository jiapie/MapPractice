//
//  ViewController.m
//  kcg
//
//  Created by Lee, Chia-Pei on 2015/9/3.
//  Copyright (c) 2015年 Lee, Chia-Pei. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad
{
    //NSLog(@"Map");
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if(UI_IS_IOS8_AND_HIGHER)
    {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    //Taiwan Center
    MKCoordinateRegion region = {KcgR16, NearbyMap};
    [thisMap setRegion:region animated:YES];
    
    //NSLog(@"Map MRTStation:%@",aAllMRTStation);
    allPoint = [[NSMutableArray alloc]init];
    for(id a in aAllMRTStation)
    {
        NSMutableDictionary *d = a;
        MKPointAnnotation *Landpoint = [[MKPointAnnotation alloc] init];
        Landpoint.title = [d valueForKey:sStationNo];
        NSString *sSubtitle = [NSString stringWithFormat:@"%@(%@)",[d valueForKey:sStationEnglishName],[d valueForKey:sStationChineseName]];
        sSubtitle = [sSubtitle stringByReplacingOccurrencesOfString:@" " withString:@""];
        Landpoint.subtitle = sSubtitle;
        NSString *sY = [NSString stringWithFormat:@"%@",[d valueForKey:sStationLatitude]];
        NSString *sX = [NSString stringWithFormat:@"%@",[d valueForKey:sStationLongitude]];
        
        CLLocationCoordinate2D naviCoord = CLLocationCoordinate2DMake([sY doubleValue],[sX doubleValue]);
        Landpoint.coordinate = naviCoord;
        [allPoint addObject:Landpoint];
    }
    
    [thisMap addAnnotations:allPoint];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//換圖, 換顏色
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSString *sTitle = [annotation title];
    NSString *firstLetter = [sTitle substringToIndex:1];
    firstLetter = [firstLetter uppercaseString];
    
    //換圖
    MKAnnotationView *annotationView = (MKAnnotationView *)[thisMap dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIdentifier];
    
    if (annotationView == nil)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIdentifier];
    }
    
    if([[annotation title] isEqualToString:CurrentLocation])
    {//不換
        annotationView = nil;
    }
    else
    {
        if([firstLetter isEqualToString:@"R"])
        {//紅線
            annotationView.image = [UIImage imageNamed:sIconRed];
        }
        else //if([firstLetter isEqualToString:@"O"])
        {//橘線
            annotationView.image = [UIImage imageNamed:sIconOrange];
        }
    }
    
    annotationView.annotation = annotation;
    // add below line of code to enable selection on annotation view
    annotationView.canShowCallout = YES;
    
    return annotationView;
}
@end
