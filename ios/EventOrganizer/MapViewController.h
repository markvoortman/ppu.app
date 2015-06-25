//
//  MapViewController.h
//  EventOrganizer
//
//  Created by Deema Abdallah


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewController : UIViewController


@property (strong, nonatomic) IBOutlet MKMapView *fullMapView;

@property (strong, nonatomic) NSString *eventAddress;
@end
