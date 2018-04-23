//
//  CalendarEvent.h
//  climateConvos
//
//  Created by Alan Ngo on 4/22/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarEvent : NSObject

@property (strong, nonatomic) NSString *eName;
@property (strong, nonatomic) NSString *eDate;
@property (strong, nonatomic) NSString *eDay; // Refers to the day of the week (ie monday tuesday wednesday etc...)
@property (strong, nonatomic) NSString *eTimeStart;
@property (strong, nonatomic) NSString *eTimeEnd;
@property (strong, nonatomic) NSString *eDescription;

@end
