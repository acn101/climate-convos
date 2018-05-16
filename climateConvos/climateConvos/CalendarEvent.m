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
    return [NSString stringWithFormat:@"Summary: %@\nStart Time: %@\nEnd Time: %@\nLocation: %@\nDescription: %@", self.eSummary, self.eStartTime, self.eEndTime, self.eLocation, self.eDescription];
}

- (NSComparisonResult)compareTest:(CalendarEvent *)eventToCompare {
    return [self.eStartTime compare:eventToCompare.eStartTime];
}

@end
