//
//  MapViewController.m
//  EventOrganizer
//
//  Created by Deema Abdallah


#import "MapViewController.h"

@interface MapViewController ()


@end


@implementation MapViewController

@synthesize fullMapView = _fullMapView;
@synthesize eventAddress = _eventAddress;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:self.eventAddress completionHandler:^(NSArray* placemarks, NSError* error){
        if(placemarks && placemarks.count>0)
        {
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            MKPlacemark *placeMark = [[MKPlacemark alloc] initWithPlacemark:topResult];
            
            MKCoordinateRegion region = self.fullMapView.region;
            region.center = placeMark.region.center;
            region.span.longitudeDelta /= 8.0;
            region.span.latitudeDelta /= 8.0;
            
            [self.fullMapView setRegion:region animated:YES];
            [self.fullMapView addAnnotation:placeMark];
            
            //NSLog(@"First latitude: %.4f", self.mapView.region.span.latitudeDelta);
            
        }
        
    }];

    
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

@end
