//
//  Profile.m
//  CustomTableViewCells
//
//  Created by Sandra Le on 4/20/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "Profile.h"
#import "singleFactoid.h"
#import "ProfileCustomTableViewCell.h"

@interface Profile ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dummyFactsArray;
@property (strong, nonatomic) NSMutableArray *dummyArticlesArray;
@property (strong, nonatomic) NSMutableArray *dummyEventsArray;
@property (strong, nonatomic) NSMutableArray *currentArray;
@property (nonatomic) int segmentChosen;
@property (weak, nonatomic) IBOutlet UILabel *saveFactsLabel;

@end

@implementation Profile

#pragma mark - Setup
- (void)setup
{
    // make sure to add "<UITableViewDataSource>" to
    // DefaultCellViewController.h for this to not
    // produce a warning
    self.tableView.dataSource = self;
    self.currentArray = self.savedFactoids;
    [_saveFactsLabel setFont:[UIFont boldSystemFontOfSize:20]];
}
/*
- (IBAction)segmentedcontroller {
    self.segmentChosen = (int) control.selectedSegmentIndex;
    switch (control.selectedSegmentIndex) {
        case 0:{
            self.currentArray = self.savedFactoids;
            [self.tableView reloadData];
            
            break;}
        case 1:{
            self.currentArray = self.savedFactoids;
            [self.tableView reloadData];
            
            break;}
        case 2:{
            self.currentArray = self.savedFactoids;
            [self.tableView reloadData];
            
            break;}
    }
    self.segmentChosen = (int) control.selectedSegmentIndex;
}*/ 

#pragma mark - Table View Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Our table only has one section...
    if (section == 0) {
        if (self.currentArray.count == 0) {
            return 1;
        } else  {
            return self.currentArray.count;
        }
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tableView.rowHeight = 85;
    ProfileCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profilecell" forIndexPath:indexPath];
    NSString *text;
    if (self.currentArray.count > 0) {
        for (singleFactoid *factoid in self.currentArray) {
            
            NSLog(@"factoid on profile: %@", factoid);
            
        }
        singleFactoid *factoid = self.currentArray[indexPath.row];
        text = [factoid.texts objectForKey:@"short"];
    } else {
        text = @"You have no saved factoids";
    }
    
    // populate the cell
    cell.profileText.text = text;
    
    // return our cell
    return cell;
}

#pragma mark - Inherited Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    self.currentArray = self.savedFactoids;
}


@end
