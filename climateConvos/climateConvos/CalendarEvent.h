//
//  CalendarEvent.h
//  climateConvos
//
//  Created by Alan Ngo on 4/22/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarEvent : NSObject

@property (strong, nonatomic) NSString *eSummary;
@property (strong, nonatomic) NSString *eDescription;
@property (strong, nonatomic) NSDate *eStartTime;
@property (strong, nonatomic) NSDate *eEndTime;
@property (strong, nonatomic) NSString *eLocation;

@end
