//
//  TableViewController.h
//  EventOrganizer
//
//  Created by Deema Abdallah

#import <UIKit/UIKit.h>

@interface EventViewController : UITableViewController <NSURLConnectionDataDelegate> {
    
}

@property (weak, nonatomic) IBOutlet UITableView *eventTableView;
@property(copy, nonatomic) NSArray *eventArray;


@end
