//
//  TableViewController.m
//  EventOrganizer
//
//  Created by Deema Abdallah


#import "EventViewController.h"
#import "EventDetailViewController.h"
#import "Event.h"

@interface EventViewController ()

{
    NSMutableData *jsonData;
    NSMutableArray *Array;
    NSURLConnection *connection;
    //UIImage *eventImage;
    Event *event;
}
@end

@implementation EventViewController {
    
    #define URL @"http://pointevent.it.pointpark.edu/events.json"

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Array = [[NSMutableArray alloc]init];
    
    NSURL *url = [NSURL URLWithString:URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if(connection) {
        jsonData = [[NSMutableData alloc]init];
    }

  }



/*- (void) imageAsyncDownload:(NSString *) imageURLString {
    
    dispatch_queue_t imageQueue = dispatch_queue_create("imageDownloader", nil);
    dispatch_async(imageQueue, ^ {
        //Dowload image
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        eventImage = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = eventImage;
        });
    });
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - URL Connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [jsonData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [jsonData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"failed with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //When parsing json, {} indicate NSDictionary i.e. key-value pairs
    // [] indicate NSArray i.e. array of objects
    
    
    if(jsonData!= nil)
    {
        NSArray *jsonArray = (NSArray *)[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
        for(NSDictionary *dict in jsonArray) {
            event = [[Event alloc]init];
            event.eName = [dict objectForKey:@"EventName"];
            event.eDescription = [dict objectForKeyedSubscript:@"Description"];
            event.eAvailability = [dict objectForKey:@"Availability"];
            event.eCapacity = [dict objectForKey:@"Capacity"];
            event.eAddress = [dict objectForKey:@"Address"];
            event.eSchedule = [dict objectForKey:@"Schedule"];
            event.eImageURL = [dict objectForKey: @"image"];
            NSLog(@"event Availability: %@", event.eAvailability);
            [Array addObject:event];
        
        }
        
        /*for(Event *myEvent in Array){
            NSLog(@"objects Array are %@", myEvent.Name);
        }*/
        
        [[self eventTableView]reloadData];

    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1; //at least one to show the rows we have!
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [self.eventArray count];
    return [Array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    if(cell == nil) {
        
        //using style1 instead of default to show status in detailTextLabel
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"EventCell"];
    }
    
    Event *myEvent = [[Event alloc]init];
    myEvent = [Array objectAtIndex:indexPath.row];
    NSLog(@"objects Array are %@", myEvent.eName);
    cell.textLabel.text = myEvent.eName;
    
    NSLog(@"Availability is: %@", myEvent.eAvailability);
    NSLog(@"Capacity is: %@", myEvent.eCapacity);

    
   /* if(([myEvent.eAvailability intValue] > 0) && ([myEvent.eCapacity intValue]!= -1))
    {
        
        cell.detailTextLabel.text = @"Register";

    }*/
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
  /*  dispatch_queue_t imageQueue = dispatch_queue_create("imageDownloader", nil);
    dispatch_async(imageQueue, ^ {
        //Dowload image
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        eventImage = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = eventImage;
        });
    }); */
    

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    dispatch_async(queue, ^{
        NSURL *imageURL = [NSURL URLWithString:myEvent.eImageURL];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *eventImage = [UIImage imageWithData:imageData];

        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[cell imageView] setImage:eventImage];
            [cell setNeedsLayout];
            
            //cell.imageView.image = eventImage;
            //self.rowWidth = 32;
            //self.rowHeight = 32;
            CGFloat widthScale = 32 / eventImage.size.width;
            CGFloat heightScale = 32/ eventImage.size.height;
            cell.imageView.transform = CGAffineTransformMakeScale(widthScale, heightScale);
            
            
        });
    });

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //EventDetailViewController *detailEventViewController = [[EventDetailViewController alloc] initWithNibName:@"EventDetailViewController" bundle:nil];
    //[self.navigationController pushViewController:detailEventViewController animated:YES];
    [self performSegueWithIdentifier:@"EventDetailSegue" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
    

 if([segue.identifier isEqualToString:@"EventDetailSegue"]) {
     
     // UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
     //EventDetailViewController *detailEventViewController (EventDetailViewController *)navController.parentViewController
     
     NSIndexPath *indexPath = [self.eventTableView indexPathForSelectedRow];
     EventDetailViewController *detailEventViewController = segue.destinationViewController;
     
     Event *myEvent = [[Event alloc]init];
     myEvent = [Array objectAtIndex:indexPath.row];
     
     //It is better to create an Event object at the detailEventController and copy the event itself instead
     //To be enhanced later on
     detailEventViewController.eventName = myEvent.eName;
     detailEventViewController.eventAvailability = myEvent.eAvailability;
     detailEventViewController.eventCapacity = myEvent.eCapacity;
     detailEventViewController.eventDescription = myEvent.eDescription;
     detailEventViewController.eventSchedule = myEvent.eSchedule;
     detailEventViewController.eventLocation = myEvent.eAddress;
     detailEventViewController.eventImageURL = myEvent.eImageURL;
     //NSLog(@"event name of selected row is: %@", detailEventViewController.eventName);
     
     detailEventViewController.title = detailEventViewController.eventName;
     //NSLog(@"Array Size %i", [detailEventViewController.eventDetailArray count]);
     
     
      }

}


@end
