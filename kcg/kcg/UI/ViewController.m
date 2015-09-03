//
//  ViewController.m
//  kcg
//
//  Created by Lee, Chia-Pei on 2015/9/3.
//  Copyright (c) 2015年 Lee, Chia-Pei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *send = segue.destinationViewController;
    [send setValue:aAllMRTStation forKey:@"aAllMRTStation"];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    global = [[Global alloc]init];
    [global createData];
    
    NSString *sPath = [[NSBundle mainBundle] bundlePath];
    NSString *sFile = [sPath stringByAppendingPathComponent:@"MRTStation.txt"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if([fm fileExistsAtPath:sFile] == YES)
    {
        NSFileHandle *handle01 = [NSFileHandle fileHandleForReadingAtPath:sFile];
        NSData *sAllData = [[NSData alloc]initWithData:[handle01 readDataToEndOfFile]];
        aAllMRTStation = [NSArray arrayWithJSONData:sAllData];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSegueWithIdentifier:@"Map" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
