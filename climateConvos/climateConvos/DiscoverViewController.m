//
//  DiscoverViewController.m
//  climateConvos
//
//  Created by Sandra Le on 2/7/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "DiscoverViewController.h"
#import "singleFactoid.h"

@interface DiscoverViewController ()

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) NSMutableArray *currentDB;

@property (strong, nonatomic) NSArray *getDBInfo;
@property (weak, nonatomic) IBOutlet UITextView *printDBtest;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FIRApp configure];
    self.ref = [[FIRDatabase database] reference];
    self.currentDB = [[NSMutableArray alloc] init];
    [self testDB];
}

- (void)testDB {
    [[self.ref child:@"facts"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.dict = snapshot.value;
      //  NSLog(@"%@", dict);
        for (NSString *factNumber in self.dict) {
            singleFactoid *single = [[singleFactoid alloc] init];
            single.number = factNumber;
            NSDictionary *factDetails = [self.dict objectForKey:factNumber];
            
            single.sources = [factDetails objectForKey:@"sources"];
            single.tags = [factDetails  objectForKey:@"tags"];
            single.location = [factDetails objectForKey:@"location"];
            single.text = [factDetails  objectForKey:@"text"];
            [self.currentDB addObject:single];
            
            [self writeFact:self.currentDB];
            
            
            //THIS WORKS HERE BUT NOT IN WRITEFACT
//            singleFactoid *currentFactoid = [self.currentDB objectAtIndex:0];
//            self.printDBtest.text = [NSString stringWithFormat:@"%@", currentFactoid.text];
//            NSLog(@"LOOK AT ME AIOWJEO;FAIJWEOA: %lu", (unsigned long)self.currentDB.count);
        }
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)writeFact:(NSObject *)neeko {
   // singleFactoid *currentFactoid = [self.currentDB objectAtIndex:0];
    //self.printDBtest.text = [NSString stringWithFormat:@"%@", currentFactoid.text];
//    NSLog(@"%@", currentFactoid.text);
    NSLog(@"LOOK AT ME: %lu", (unsigned long)self.currentDB.count);
}
//        NSLog(@"%@",dict);
/*        for (NSString *key in [dict allKeys]) {
            if([key isEqualToString:@"fact1"]) {
                if([key isEqualToString:@"text"]) {
                    self.printDBtest.text = [NSString stringWithFormat:@"%@", [dict objectForKey:key]];
                }
            }
        }
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}*/

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
