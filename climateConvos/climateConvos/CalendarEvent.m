//
//  CalendarEvent.m
//  climateConvos
//
//  Created by Alan Ngo on 4/22/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "CalendarEvent.h"

@implementation CalendarEvent

- (NSString *) description {
    return [NSString stringWithFormat:@"Name: %@ | Date: %@ | Day: %@ | Start Time: %@ | End Time: %@ | Description: %@", self.eName, self.eDate, self.eDay, self.eTimeStart, self.eTimeEnd, self.eDescription];
}

@end
