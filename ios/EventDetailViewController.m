
//
//  EventDetailViewController.m
//  EventOrganizer
//
//  Created by Deema Abdallah


#import "EventDetailViewController.h"
#import "MapViewController.h"
#import "EventViewController.h"

@interface EventDetailViewController ()

@end

//int addEventGranted;
NSDate *eventDate;

@implementation EventDetailViewController

@synthesize detailEventTableView = _detailEventTableView;
@synthesize addReminderButton = _addReminderButton;
@synthesize registerButton = _registerButton;
@synthesize mapView = _mapView;
@synthesize eventNameLabel = _eventNameLabel;
@synthesize eventAvailabilityLabel = _eventAvailabilityLabel;
@synthesize eventScheduleLabel = _eventScheduleLabel;
@synthesize eventDescriptionLabel = _eventDescriptionLabel;
@synthesize mapViewController = _mapViewController;
@synthesize eventImage = _eventImage;

@synthesize eventName = _eventName;
@synthesize eventDescription = _eventDescription;
@synthesize eventAvailability = _eventAvailability;
@synthesize eventCapacity = _eventCapacity;
@synthesize eventImageURL = _eventImageURL;
@synthesize eventLocation = _eventLocation;
@synthesize eventSchedule = _eventSchedule;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Registration is not required
   if ([self.eventCapacity intValue] == -1) {
        self.registerButton.hidden = YES;
        self.eventCapacityLabel.hidden = YES;
        self.eventAvailabilityLabel.text = @"This event doesn't require registration!";
        
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        //[self.detailEventTableView cellForRowAtIndexPath:indexPath].hidden = YES;
    }
    //Registration is required, and there are available seats
    else if (([self.eventCapacity intValue] != -1) && ([self.eventAvailability intValue] > 0)) {
        self.registerButton.enabled = YES;
        self.eventAvailabilityLabel.text = [@"Available Seats: " stringByAppendingString: self.eventAvailability];
        self.eventCapacityLabel.text = [@"Capacity: " stringByAppendingString: self.eventCapacity];
    }
    //Registration is required, but no available seats
    else if (([self.eventCapacity intValue] != -1) && ([self.eventAvailability intValue] == 0)) {
        self.registerButton.enabled = NO;
        self.eventAvailabilityLabel.text = [@"Available Seats: " stringByAppendingString: self.eventAvailability];
        self.eventCapacityLabel.text = [@"Capacity: " stringByAppendingString: self.eventCapacity];
    }
    
    
    NSLog(@"After transferring array of Events: %@", self.eventName);
    self.eventNameLabel.text = self.eventName;
    self.eventDescriptionLabel.text = self.eventDescription;
    self.eventScheduleLabel.text = self.eventSchedule;
    self.eventLocation = self.eventLocation;
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL: [NSURL URLWithString:self.eventImageURL]]];
    [self.eventImage setImage:image];
    

    
    [self calculateMapCoordinates];
       
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewFullMap)];
    [tap setNumberOfTouchesRequired:1];
    [tap setNumberOfTapsRequired:1];
    [self.mapView addGestureRecognizer:tap];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterFullStyle];
    [dateFormat setTimeStyle:NSDateFormatterShortStyle];
    eventDate = [dateFormat dateFromString: self.eventSchedule];
    //NSString *dateString = [dateFormat stringFromDate:[NSDate date]];
    NSLog(@"event date set as: %@", eventDate);
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}*/

/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventDetailCell"];
    if(cell == nil) {
 
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EventDetailCell"];
    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = self.eventDetailArray [0];
            break;
        case 1:
            cell.textLabel.text = self.eventDetailArray [1];
            break;
        case 2:
            cell.textLabel.text = self.eventDetailArray [2];
            break;
        default:
            break;
    }
 
    //cell.textLabel.text = self.eventDetailArray [indexPath.row];
    //cell.detailTextLabel.text = @"Registered"; //This is only for demo purposes. Needs to change dynamically
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
    return cell;
} */

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if(section == 5)
        return self.eventLocation;
    else
        return nil;
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if(indexPath.section == 3 && indexPath.row ==0) //selecting map cell
    {
        [self performSegueWithIdentifier:@"FullMapSegue" sender:self];

    }

}*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"FullMapSegue"]) {
        MapViewController *mapViewController = segue.destinationViewController;
        mapViewController.eventAddress = self.eventLocation;
        mapViewController.title = @"Event Location";
        NSLog(@"The adress is: %@", mapViewController.eventAddress);
        }
   
}

- (void)calculateMapCoordinates
{
    NSLog(@"Calculating Map Coordinates");
    //The following is needed to decode the latitude and longitude
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:self.eventLocation completionHandler:^(NSArray* placemarks, NSError* error){
        if(placemarks && placemarks.count>0)
        {
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            MKPlacemark *placeMark = [[MKPlacemark alloc] initWithPlacemark:topResult];
            
            MKCoordinateRegion region = self.mapView.region;
            region.center = placeMark.region.center;
            region.span.longitudeDelta /= 8.0;
            region.span.latitudeDelta /= 8.0;
            
            [self.mapView setRegion:region animated:YES];
            [self.mapView addAnnotation:placeMark];
            
            //NSLog(@"First latitude: %.4f", self.mapView.region.span.latitudeDelta);
            
            
        }
        
    }];}

- (void)viewFullMap
{
    NSLog(@"Map Tapped");
    [self performSegueWithIdentifier:@"FullMapSegue" sender:self];
}

- (IBAction)addReminder:(id)sender {
    //if(addEventGranted != 1) {
        //NSLog(@"addEventGranted value: %i", addEventGranted);
        //this means the event hasnt been added to the calendar yet
        [self addEvent];
        [self performSelector:@selector(eventAlert) withObject:nil afterDelay:0.3];
    /*}
    else {
        UIAlertView * eventAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"The event has already been added!" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
        
        [eventAlert show];
        
    }*/
}

- (void) addEvent {
    EKEventStore *eventStore = [[EKEventStore alloc]init];
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            
            //creating event to be added to iOS calendar
            if (granted) {
                //addEventGranted = 1;
                EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                [event setTitle:self.eventName];
                [event setStartDate:[[NSDate alloc]init]];
                [event setEndDate:[[NSDate alloc]initWithTimeInterval:1200 sinceDate:eventDate]];
                
                NSLog(@"event date is %@", eventDate);
                [event setLocation:self.eventLocation];
                
                //Setting a reminder for the user
                NSTimeInterval alarmOffSet = -1*1440*60;
                EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:alarmOffSet];
                [event addAlarm:alarm];
                
                
                //Adding event to calendar
                [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                NSError *err;
                [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
            }
        }];
        
        //Disable the addReminderButton
        //self.addReminderButton.enabled = NO;
        
    }
    
}

- (void) eventAlert {
    //if(addEventGranted == 1) {
        UIAlertView * eventAlert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"The event has been successfully added!" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
        
        [eventAlert show];
    //}
}

@end
