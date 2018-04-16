//
//  CalendarViewController.m
//  climateConvos
//
//  Created by acn96 on 4/16/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "CalendarViewController.h"

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
    NSLog(@"%@", ICSAsString);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self downloadICS];
}



@end
