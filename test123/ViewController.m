//
//  ViewController.m
//  test123
//
//  Created by Shay Finkelstein on 12/3/16.
//  Copyright © 2016 Shay Finkelstein. All rights reserved.
//

@import MapKit;



#import "ViewController.h"
#import "annotation.h"
#define METERS_PER_MILE 1609.344

@interface ViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblGigName;
@property (weak, nonatomic) IBOutlet UILabel *locationAndTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Show info";
    _map.showsUserLocation=YES;
    // 1
    CLLocationCoordinate2D zoomLocation;
    double lat = [self.theShow[@"location"][@"lat"] doubleValue];
    double lon = [self.theShow[@"location"][@"lon"] doubleValue];
    zoomLocation.latitude = lat;
    zoomLocation.longitude= lon;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
    
    // 3
    [_map setRegion:viewRegion animated:YES];
 
    
    CLLocationCoordinate2D  ctrpoint;
    ctrpoint.latitude = lat;
    ctrpoint.longitude = lon;
    Annotation *addAnnotation =  [[Annotation alloc]init];
    addAnnotation.coordinate = ctrpoint;
    addAnnotation.title= @"Show Location";
    addAnnotation.subtitle = _theShow[@"location"][@"name"];
    [_map addAnnotation:addAnnotation];
    
    [_map selectAnnotation:addAnnotation animated:YES];
    _lblName.text = _theShow[@"performer"][@"name"];
    _lblGigName.text = _theShow[@"gigname"];
    _locationAndTime.text = [NSString stringWithFormat:@"%@ %@",_theShow[@"location"][@"name"],@" 22:00"];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_small"]]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
