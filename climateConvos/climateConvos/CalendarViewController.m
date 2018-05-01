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
@end

@implementation CalendarViewController
#pragma mark -  pragmatically generated view
- (void)generateView {
    self.cardBox = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 300, 600)];
    [self.cardBox setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:self.cardBox];
    
    self.eveSummary = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    self.eveSummary.text = @"Summary";
    [self.cardBox addSubview:self.eveSummary];
    
    self.eveDescription = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 100, 200)];
    self.eveDescription.text = @"Description";
    [self.cardBox addSubview:self.eveDescription];
    
    self.eveStartTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 200)];
    self.eveStartTime.text = @"Start Time";
    [self.cardBox addSubview:self.eveStartTime];
    
    self.eveEndTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 100, 200)];
    self.eveEndTime.text = @"End Time";
    [self.cardBox addSubview:self.eveEndTime];
    
    self.eveLocation = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 100, 200)];
    self.eveLocation.text = @"Location";
    [self.cardBox addSubview:self.eveLocation];
    
    self.closeEBtn = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 200)];
    [self.closeEBtn setTitle:@"X" forState:UIControlStateNormal];
    [self.closeEBtn addTarget:self action:@selector(closeBtnPrs) forControlEvents:UIControlEventTouchUpInside];
    [self.cardBox addSubview:self.closeEBtn];
    
    [self hideBox];
}

- (void)closeBtnPrs {
    [self hideBox];
}

- (void)hideBox {
    self.cardBox.hidden = YES;
}

- (void)showBox {
    self.cardBox.hidden = NO;
}

- (void)sendData:(CalendarEvent *)ce {
    //Create the dateformatter object
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //Set the required date format
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //Get the string date
    NSString *startString = [dateFormatter stringFromDate:ce.eStartTime];
    NSString *endString = [dateFormatter stringFromDate:ce.eEndTime];
    
    self.eveSummary.text = [NSString stringWithFormat:@"%@", ce.eSummary];
    self.eveDescription.text = [NSString stringWithFormat:@"%@", ce.eDescription];
    self.eveStartTime.text = [NSString stringWithFormat:@"%@", startString];
    self.eveEndTime.text = [NSString stringWithFormat:@"%@", endString];
    self.eveLocation.text = [NSString stringWithFormat:@"%@", ce.eLocation];
}

#pragma mark - Table View Data Source and Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showBox];
    [self sendData:self.calendarEvents[indexPath.row]];
}

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
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *costLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *bodyLabel = (UILabel *)[cell viewWithTag:3];
    
    // populate the cell
    titleLabel.text = thisEvent.eSummary;
    costLabel.text = thisEvent.eLocation;
    bodyLabel.text = thisEvent.eDescription;
    
    // return our cell
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // we need to override the default cell height even thought we've set this
    // explicitly in interface builder (this may be a bug in apple's software)
    return 120;
}

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
        summary = [summary stringByReplacingOccurrencesOfString:@"T" withString:@""];
        // NSLog(@"Summary: %@", summary);
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
    [self downloadICS];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self generateView];
}

@end
