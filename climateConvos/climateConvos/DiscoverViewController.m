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
@property (strong, nonatomic) singleFactoid *currentFactoid;


@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self testDB];
//    DELAY(2000);
    [self writeFact];
}

- (IBAction)genFactoid:(UIButton *)sender {
    [self genFactoid];
}

- (void)genFactoid {
    self.currentFactoid = [self.currentDB objectAtIndex:arc4random_uniform(self.currentDB.count)];
    self.printDBtest.text = [NSString stringWithFormat:@"%@", self.currentFactoid.text];
}

- (void)setup {
    self.ref = [[FIRDatabase database] reference];
    self.currentDB = [[NSMutableArray alloc] init];
}

- (void)testDB {
    [[self.ref child:@"facts"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.dict = snapshot.value;
        for (NSString *factNumber in self.dict) {
            singleFactoid *single = [[singleFactoid alloc] init];
            single.number = factNumber;
            NSDictionary *factDetails = [self.dict objectForKey:factNumber];
            
            single.sources = [factDetails objectForKey:@"sources"];
            single.tags = [factDetails  objectForKey:@"tags"];
            single.location = [factDetails objectForKey:@"location"];
            single.text = [factDetails  objectForKey:@"text"];
            [self.currentDB addObject:single];
        }
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)writeFact {
    self.printDBtest.text = @"Loading";
    [self.ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        [self genFactoid];
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
