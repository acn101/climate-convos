//
//  CalendarViewController.m
//  climateConvos
//
//  Created by acn96 on 4/16/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarEvent.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)downloadICS
{
    NSString *URLString = @"https://calendar.google.com/calendar/ical/72dh5ehol3oufbkusqagta0qf8%40group.calendar.google.com/public/basic.ics";
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *downloadTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // handle response
        if (error) {
            NSLog(@"ERROR! - %@", error);
        } else {
            [self parseICS:data];
        }
    }];
    [downloadTask resume];
}

- (void)parseICS:(NSData *)data
{
    NSString *ICSAsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // printf("%s", [NSString stringWithFormat: @"%@", ICSAsString].UTF8String);
    // create array of lines
    NSArray *events = [ICSAsString componentsSeparatedByString:@"BEGIN:VEVENT"];
    for (NSUInteger i = 0; i < events.count; i++) {

        if (i > 0) {
            NSString *event = events[i];
            // NSLog(@"EVENT WE ARE IN: %zd", i);
            [self getStartTime:event];
            // GET SUMMARY
            // Create an event object
            CalendarEvent *eventObj = [[CalendarEvent alloc] init];
        }
    }
}

#pragma mark - helper methods
- (NSString *)getDescription:(NSString *)event
{
    // GET DESCRIPTION
    NSString *description;
    NSError *error;
    NSRegularExpression *RE = [[NSRegularExpression alloc] initWithPattern:@"DESCRIPTION:.+LAST-MODIFIED"
                                                                   options:NSRegularExpressionDotMatchesLineSeparators
                                                                     error:&error];
    if (error) {
        NSLog(@"ERROR! - %@", error.localizedDescription);
    }
    NSArray *matches = [RE matchesInString:event options:0 range:NSMakeRange(0, event.length)];
    if (matches.count > 0) {
        NSTextCheckingResult *result = matches[0];
        description = [event substringWithRange:result.range];
        description = [description stringByReplacingOccurrencesOfString:@"DESCRIPTION:" withString:@""];
        description = [description stringByReplacingOccurrencesOfString:@"LAST-MODIFIED" withString:@""];
        description = [self stringByStrippingHTML:description];
        // NSLog(@"description: %@", description);
    }
    return description;
}

- (NSString *)getStartTime:(NSString *)event
{
    NSArray *lines = [event componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
//    for (NSUInteger i = 0; i < lines.count; i++) {
//        NSString *line = lines[i];
//    }
    for (NSUInteger i = 0; i < lines.count; i++) {
        NSString *line = lines[i];
        if ([line rangeOfString:@"DTSTART" options:NSRegularExpressionSearch].location != NSNotFound) {
            NSRegularExpression *RE = [[NSRegularExpression alloc] initWithPattern:@"TSTART:.+Z"
                                                                           options:NSRegularExpressionDotMatchesLineSeparators
                                                                             error:nil];
            NSArray *matches = [RE matchesInString:line options:0 range:NSMakeRange(0, line.length)];
            if (matches.count <= 0) {
                NSLog(@"ERROR! No matches for DTSART");
                line = [self getSemiColonTime:line];
                RE = [[NSRegularExpression alloc] initWithPattern:@"TSTART:.+Z"
                                                          options:NSRegularExpressionDotMatchesLineSeparators
                                                            error:nil];
                matches = [RE matchesInString:line options:0 range:NSMakeRange(0, line.length)];
                // exit(EXIT_FAILURE);
            }
            // NSLog(@"matches: %@", matches);
            NSTextCheckingResult *result = matches[0];
            // Should be:   20180519T163000Z
            // Is:          20180509T000000Z
            NSString *startTime = [line substringWithRange:result.range];
            startTime = [startTime stringByReplacingOccurrencesOfString:@"TSTART:" withString:@""];
            NSArray *components = [startTime componentsSeparatedByString:@"T"];
            NSString *date;
            NSString *time;
            if (components.count == 2) {
                date = components[0];
                time = components[1];
            } else {
                NSLog(@"ERROR!! TSTART not splitting up into components");
                exit(EXIT_FAILURE);
            }
            time = [time stringByReplacingOccurrencesOfString:@"Z" withString:@""];
            // NSLog(@"DATE: %@ | TIME: %@", date, time);
            NSString *day = [date substringWithRange:NSMakeRange(6, 2)];
            NSString *month = [date substringWithRange:NSMakeRange(4, 2)];
            NSString *year = [date substringWithRange:NSMakeRange(0, 4)];
            NSString *hour = [time substringWithRange:NSMakeRange(0, 2)];
            NSString *minutes = [time substringWithRange:NSMakeRange(2, 2)];
            int hourInt = [hour intValue];
            NSString *amPm = hourInt > 12 ? @"PM" : @"AM";
            if (hourInt > 12) {
                hourInt = hourInt - 12;
            }
            hour = [NSString stringWithFormat:@"%d", hourInt];
            NSString *dateTimeString = [NSString stringWithFormat:@"%@/%@/%@ %@:%@ %@", month, day, year, hour, minutes, amPm];
            // NSLog(@"%@", dateTimeString);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM/dd/yyyy h:mm a"];
            NSDate *dateObj = [formatter dateFromString:dateTimeString];
            // NSLog(@"date from dateObj: %@", [formatter stringFromDate:dateObj]);
            break;
        }
    }
    return lines[0];
}

- (NSString *)getSemiColonTime:(NSString *)line
{
    // GET DESCRIPTION
    NSString *date;
    NSError *error;
    NSRegularExpression *RE = [[NSRegularExpression alloc] initWithPattern:@";.+:"
                                                                   options:NSRegularExpressionDotMatchesLineSeparators
                                                                     error:&error];
    if (error) {
        NSLog(@"ERROR! - %@", error.localizedDescription);
    }
    NSArray *matches = [RE matchesInString:line options:0 range:NSMakeRange(0, line.length)];
    NSTextCheckingResult *result = matches[0];
    NSString *tempStr = [line substringWithRange:result.range];
    // NSLog(@"Temp String: %@", tempStr);
    date = [line stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@", tempStr] withString:@":"];
    if(date.length <=17 ) {
        date = [date stringByAppendingString:@"T000000Z"];
    } else {
        date = [date stringByAppendingString:@"Z"];
    }
    return date;
}

-(NSString *)stringByStrippingHTML:(NSString *)stringToStrip {
    NSRange r;
    while ((r = [stringToStrip rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        stringToStrip = [stringToStrip stringByReplacingCharactersInRange:r withString:@""];
    return stringToStrip;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self downloadICS];
}

@end
