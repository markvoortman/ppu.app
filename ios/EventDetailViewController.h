//
//  EventDetailViewController.h
//  EventOrganizer
//
//  Created by Deema Abdallah


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <EventKit/EventKit.h>
#import "Event.h"


@interface EventDetailViewController : UITableViewController <UIGestureRecognizerDelegate> {
    MKMapView *mapView;
    
}

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventLocation;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *eventSchedule;
@property (nonatomic, strong) NSString *eventImageURL;
@property (nonatomic, strong) NSString *eventAvailability;
@property (nonatomic, strong) NSString *eventCapacity;
@property (strong, nonatomic) IBOutlet UITableView *detailEventTableView;


@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) IBOutlet UIButton *addReminderButton;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventScheduleLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventCapacityLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventAvailabilityLabel;

@property (strong, nonatomic) UIViewController *mapViewController;

- (IBAction)addReminder:(id)sender;

@end
