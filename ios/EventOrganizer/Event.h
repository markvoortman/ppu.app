//
//  Event.h
//  EventOrganizer
//
//  Created by Deema Abdallah
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

// These properties are needed to be set from the Jason data

@property (nonatomic, strong) NSString *eName;
@property (nonatomic, strong) NSString *eAddress;
@property (nonatomic, strong) NSString *eDescription;
@property (nonatomic, strong) NSString *eSchedule;
@property (nonatomic, strong) NSString *eImageURL;

@property (nonatomic, strong) NSString *eAvailability;
@property (nonatomic, strong) NSString *eCapacity;

@end
