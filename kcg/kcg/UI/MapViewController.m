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
        Landpoint.title = [d valueForKey:@"車站編號"];
        NSString *sSubtitle = [NSString stringWithFormat:@"%@(%@)",[d valueForKey:@"車站英文名稱"],[d valueForKey:@"車站中文名稱"]];
        Landpoint.subtitle = sSubtitle;
        
        //static CLLocationCoordinate2D TaiwanCenter          = {23.5832,120.5825};
        NSData *Y = [d valueForKey:@"車站緯度"];
        NSString *sY = [NSString stringWithFormat:@"%@",Y];
        NSData *X = [d valueForKey:@"車站經度"];
        NSString *sX = [NSString stringWithFormat:@"%@",X];
        
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
    //CLLocationCoordinate2D nowCoord = [annotation coordinate];
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
    {//Secure (Green),(Purple) ,Not Fund(Red)
        //annotationView = nil;
        if([firstLetter isEqualToString:@"R"])
        {//紅線
            annotationView.image = [UIImage imageNamed:@"Circle_Red.png"];
        }
        else //if([firstLetter isEqualToString:@"O"])
        {//橘線
            annotationView.image = [UIImage imageNamed:@"Circle_Orange.png"];
        }
    }
    
    annotationView.annotation = annotation;
    // add below line of code to enable selection on annotation view
    annotationView.canShowCallout = YES;
    
    return annotationView;
}
@end
