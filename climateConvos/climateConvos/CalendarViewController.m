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
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIView *cardBox;
@property (strong, nonatomic) UILabel *eveSummary;
@property (strong, nonatomic) UILabel *eveDescription;
@property (strong, nonatomic) UILabel *eveStartTime;
@property (strong, nonatomic) UILabel *eveEndTime;
@property (strong, nonatomic) UILabel *eveLocation;
@property (strong, nonatomic) UIButton *closeEBtn;

@property (strong, nonatomic) NSString *city;
@end

@implementation CalendarViewController
#pragma mark - table expansion
- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
    // Return whether the cell at the specified index path is selected or not
    NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
    return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Deselect cell
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    // Toggle 'selected' state
    BOOL isSelected = ![self cellIsSelected:indexPath];
    
    // Store cell 'selected' state keyed on indexPath
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [selectedIndexes setObject:selectedIndex forKey:indexPath];
    
    // This is where magic happens...
    [tableView beginUpdates];
    [tableView endUpdates];
}

#pragma mark - Table View Data Source and Delegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Our table only has one section...
    if (section == 0) {
        return self.calendarEvents.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // grab the drone for this row
    CalendarEvent *thisEvent = self.calendarEvents[indexPath.row];
    
    // get our custom cell
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"custom"];
    
    // we assigned each component of the custom cell we created
    // in interface builder a unique tab number - this is how
    // we get references to those components
    UILabel *summaryLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *startLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *endLabel = (UILabel *)[cell viewWithTag:3];
    UILabel *locationLabel = (UILabel *)[cell viewWithTag:4];
    UILabel *descriptionLabel = (UILabel *)[cell viewWithTag:5];
    UILabel *somethingElse = (UILabel *)[cell viewWithTag:6];
    
    // customize date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy h:mm a"];
    NSString *fST = [formatter stringFromDate:thisEvent.eStartTime];
    NSString *fET = [formatter stringFromDate:thisEvent.eEndTime];
    
    NSDateFormatter *newFormatter = [[NSDateFormatter alloc] init];
    [newFormatter setDateFormat:@"MM/dd"];
    NSString *bST = [newFormatter stringFromDate:thisEvent.eStartTime];
    
    // populate the cell
    summaryLabel.text = thisEvent.eSummary;
    startLabel.text = fST;
    endLabel.text = fET;
    locationLabel.text = thisEvent.eLocation;
    descriptionLabel.text = thisEvent.eDescription;
    somethingElse.text = bST;
    
    // return our cell
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self cellIsSelected:indexPath]) {
        return 500;
    }
    return 42;
}

#pragma mark - SEATTLE START
#pragma mark - calendar download
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
    NSMutableArray *calendarEventsUnsorted = [[NSMutableArray alloc] init];
    // create array of lines
    NSArray *events = [ICSAsString componentsSeparatedByString:@"BEGIN:VEVENT"];
    for (NSUInteger i = 0; i < events.count; i++) {
        if (i > 0) {
#pragma mark - call events here
            NSString *event = events[i];
            // NSLog(@"EVENT WE ARE IN: %zd", i);
            CalendarEvent *calEvent = [[CalendarEvent alloc] init];
            calEvent.eDescription = [self getDescription:event];
            calEvent.eStartTime = [self getStartTime:event];
            calEvent.eEndTime = [self getEndTime:event];
            calEvent.eSummary = [self getSummary:event];
            calEvent.eLocation = [self getLocation:event];
            // NSLog(@"%@ \n\n\n", calEvent);
            [calendarEventsUnsorted addObject:calEvent];

        }
    }
    
    self.calendarEvents = [NSMutableArray arrayWithArray:[calendarEventsUnsorted sortedArrayUsingSelector:@selector(compareTest:)]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    // NSLog(@"Calendar Events Count %tu", self.calendarEvents.count);
}


#pragma mark - SEATTLE END

#pragma mark - HOUSTON START
- (void)downloadICSHouston
{
    NSString *URLString = @"https://calendar.google.com/calendar/ical/glhsdobgfp0uat7regg4idd8ma70fiaq%40import.calendar.google.com/public/basic.ics";
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *downloadTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // handle response
        if (error) {
            NSLog(@"ERROR! - %@", error);
        } else {
            [self parseICSHouston:data];
        }
    }];
    [downloadTask resume];
}

- (void)parseICSHouston:(NSData *)data
{
    NSString *ICSAsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // printf("%s", [NSString stringWithFormat: @"%@", ICSAsString].UTF8String);
    self.calendarEvents = [[NSMutableArray alloc] init];
    // create array of lines
    NSArray *events = [ICSAsString componentsSeparatedByString:@"BEGIN:VEVENT"];
    for (NSUInteger i = 0; i < events.count; i++) {
        if (i > 0) {
#pragma mark - call events here
            NSString *event = events[i];
            // NSLog(@"EVENT WE ARE IN: %zd", i);
            CalendarEvent *calEvent = [[CalendarEvent alloc] init];
            calEvent.eDescription = [self getDescription:event];
            calEvent.eStartTime = [self getStartTime:event];
            calEvent.eEndTime = [self getEndTime:event];
            calEvent.eSummary = [self getSummary:event];
            calEvent.eLocation = [self getLocation:event];
            // NSLog(@"%@ \n\n\n", calEvent);
            [self.calendarEvents addObject:calEvent];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    // NSLog(@"Calendar Events Count %tu", self.calendarEvents.count);
}
#pragma mark - HOUSTON END

#pragma mark - HELPER METHODS
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
        description = [description stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        description = [description stringByReplacingOccurrencesOfString:@"\r\n" withString:@" "];
        description = [description stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        description = [description stringByReplacingOccurrencesOfString:@"  " withString:@" "];
        description = [self stringByStrippingHTML:description];
        // NSLog(@"description: %@", description);
    }
    return description;
}

-(NSString *)stringByStrippingHTML:(NSString *)stringToStrip {
    NSRange r;
    while ((r = [stringToStrip rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        stringToStrip = [stringToStrip stringByReplacingCharactersInRange:r withString:@""];
    return stringToStrip;
}

#pragma mark - start time
- (NSDate *)getStartTime:(NSString *)event
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
                // NSLog(@"ERROR! No matches for DTSART");
                line = [self getSemiColonTimeStart:line];
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
            // NSLog(@"Start Date: %@", [formatter stringFromDate:dateObj]);
            return dateObj;
        }
    }
    return lines[0];
}

- (NSString *)getSemiColonTimeStart:(NSString *)line
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

#pragma mark - end time
- (NSDate *)getEndTime:(NSString *)event
{
    NSArray *lines = [event componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    //    for (NSUInteger i = 0; i < lines.count; i++) {
    //        NSString *line = lines[i];
    //    }
    for (NSUInteger i = 0; i < lines.count; i++) {
        NSString *line = lines[i];
        if ([line rangeOfString:@"DTEND" options:NSRegularExpressionSearch].location != NSNotFound) {
            NSRegularExpression *RE = [[NSRegularExpression alloc] initWithPattern:@"TEND:.+Z"
                                                                           options:NSRegularExpressionDotMatchesLineSeparators
                                                                             error:nil];
            NSArray *matches = [RE matchesInString:line options:0 range:NSMakeRange(0, line.length)];
            if (matches.count <= 0) {
                // NSLog(@"ERROR! No matches for DTSART");
                line = [self getSemiColonTimeEnd:line];
                RE = [[NSRegularExpression alloc] initWithPattern:@"TEND:.+Z"
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
            startTime = [startTime stringByReplacingOccurrencesOfString:@"TEND:" withString:@""];
            NSArray *components = [startTime componentsSeparatedByString:@"T"];
            NSString *date;
            NSString *time;
            if (components.count == 2) {
                date = components[0];
                time = components[1];
            } else {
                NSLog(@"ERROR!! TEND not splitting up into components");
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
            // NSLog(@"END DATE: %@", [formatter stringFromDate:dateObj]);
            return dateObj;
        }
    }
    return lines[0];
}

- (NSString *)getSemiColonTimeEnd:(NSString *)line
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

#pragma mark - summary
- (NSString *)getSummary:(NSString *)event
{
    // GET SUMMARY
    
    NSString *summary;
    NSError *error;
    NSRegularExpression *RE = [[NSRegularExpression alloc] initWithPattern:@"(?<=SUMMARY:)(.*)(?=RANSP)"
                                                                   options:NSRegularExpressionDotMatchesLineSeparators
                                                                     error:&error];

    if (error) {
        NSLog(@"ERROR! - %@", error.localizedDescription);
    }
    
    NSArray *matches = [RE matchesInString:event options:0 range:NSMakeRange(0, event.length)];
    if (matches.count > 0) {
        NSTextCheckingResult *result = matches[0];
        summary = [event substringWithRange:result.range];
        summary = [summary stringByReplacingOccurrencesOfString:@"SUMMARY:" withString:@""];
        //        summary = [summary stringByReplacingOccurrencesOfString:@"T" withString:@""];
        // NSLog(@"Summary: %@", summary);
    }

    // STRIP PARENTHESES

    NSRegularExpression *REParentheses = [[NSRegularExpression alloc] initWithPattern:@"\\(.+\\)"
                                                                              options:NSRegularExpressionDotMatchesLineSeparators
                                                                                error:&error];
    
    if (error) {
        NSLog(@"ERROR! - %@", error.localizedDescription);
    }
    
    NSArray *matchesParen = [REParentheses matchesInString:summary options:0 range:NSMakeRange(0, summary.length)];
    
    if (matchesParen.count > 0) {
        NSTextCheckingResult *result = matchesParen[0];
        NSString *parens = [summary substringWithRange:result.range];
        summary = [summary stringByReplacingOccurrencesOfString:parens withString:@""];
    }

    
    return summary;
}

#pragma mark - location
- (NSString *)getLocation:(NSString *)event
{
    NSString *location;
    NSError *error;
    NSRegularExpression *RE = [[NSRegularExpression alloc] initWithPattern:@"(?<=LOCATION:)(.*)(?=QUENCE)"
                                                                   options:NSRegularExpressionDotMatchesLineSeparators
                                                                     error:&error];
    if (error) {
        NSLog(@"ERROR! - %@", error.localizedDescription);
    }
    NSArray *matches = [RE matchesInString:event options:0 range:NSMakeRange(0, event.length)];
    if (matches.count > 0) {
        NSTextCheckingResult *result = matches[0];
        location = [event substringWithRange:result.range];
        location = [location stringByReplacingOccurrencesOfString:@"LOCATION:" withString:@""];
        location = [location stringByReplacingOccurrencesOfString:@"SE" withString:@""];
        // NSLog(@"Location: %@", location);
    }
    return location;
}

#pragma mark - Default
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self downloadICS];
    [self checkCity];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    selectedIndexes = [[NSMutableDictionary alloc] init];
    self.tableView.layer.cornerRadius = 11;
}

- (void)checkCity {
    self.city = [[NSUserDefaults standardUserDefaults] stringForKey:@"location"];
    if([self.city isEqualToString:@"Seattle"]) {
        [self downloadICS];
    } else if ([self.city isEqualToString:@"Houston"]) {
        [self downloadICSHouston];
    }
}

@end
