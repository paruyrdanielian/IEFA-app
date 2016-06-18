//
//  IEFAEvantDayViewController.m
//  iefa
//
//  Created by User on 6/11/16.
//  Copyright © 2016 Paruyr Danielian. All rights reserved.
//

#import "IEFAEvantDayViewController.h"
#import "IEFAConstants.h"
#import <MapKit/MapKit.h>

@interface IEFAEvantDayViewController () <MKAnnotation>

@property (weak, nonatomic) IBOutlet UILabel *dressCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *aboutPlaceLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation IEFAEvantDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.scrollView.frame.size.height)];
    self.navigationItem.title = self.time;
    [self setupLabels];
    [self setupMap];
}


- (void)setupLabels {
    
    self.aboutPlaceLabel.numberOfLines = 0;
    self.dressCodeLabel.numberOfLines = 0;
    
    self.aboutPlaceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.dressCodeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.aboutPlaceLabel.textAlignment = NSTextAlignmentJustified;
    self.dressCodeLabel.textAlignment = NSTextAlignmentJustified;
    
    self.aboutPlaceLabel.text = self.aboutPlace;
    self.dressCodeLabel.text = self.dressCode;
    

}



- (void)setupMap {
    
    CLLocationCoordinate2D coordinats;
    coordinats.latitude = [self.place[0] floatValue];
    coordinats.longitude = [self.place[1] floatValue];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinats;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinats, 500,500);
    CLLocationManager *locMan = [[CLLocationManager alloc] init];
    [locMan requestWhenInUseAuthorization];
    
    self.map.showsUserLocation = YES;
    
    [self.map setRegion:viewRegion];
    [self.map addAnnotation:annotation];

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

@end
