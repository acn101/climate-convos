//
//  Profile.m
//  CustomTableViewCells
//
//  Created by Sandra Le on 4/20/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "Profile.h"
#import "singleFactoid.h"
@interface Profile ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dummyFactsArray;
@property (strong, nonatomic) NSMutableArray *dummyArticlesArray;
@property (strong, nonatomic) NSMutableArray *dummyEventsArray;
@property (strong, nonatomic) NSMutableArray *currentArray;
@property (nonatomic) int segmentChosen;

@end

@implementation Profile

#pragma mark - Setup
- (void)setup
{
    // make sure to add "<UITableViewDataSource>" to
    // DefaultCellViewController.h for this to not
    // produce a warning
    self.tableView.dataSource = self;
    
    
}

- (IBAction)segmentedcontroller {
    self.segmentChosen = (int) control.selectedSegmentIndex;
    switch (control.selectedSegmentIndex) {
        case 0:{
            self.currentArray = self.dummyFactsArray;
            [self.tableView reloadData];
            
            break;}
        case 1:{
            self.currentArray = self.dummyArticlesArray;
            [self.tableView reloadData];
            
            break;}
        case 2:{
            self.currentArray = self.dummyEventsArray;
            [self.tableView reloadData];
            
            break;}
    }
    self.segmentChosen = (int) control.selectedSegmentIndex;
}

#pragma mark - Table View Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Our table only has one section...
    if (section == 0) {
        return self.currentArray.count;
        /*
        if (self.segmentChosen == 0) {
            return self.dummyFactsArray.count;
        } else if (self.segmentChosen == 1) {
            return self.dummyArticlesArray.count;
        } else {
            return self.dummyEventsArray.count;
        }
        */
    } else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // grab the drone for this row
    //Drone *thisDrone = self.drones[indexPath.row];
    
    
    // create a cell with default styling
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"default"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
    }
    
    NSString *text = self.currentArray[indexPath.row];
    // populate the cell
    cell.textLabel.text = text;
    //[cell.imageView setImage:thisDrone.image];
    
    // return our cell
    return cell;
}

#pragma mark - Inherited Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    self.dummyFactsArray = [[NSMutableArray alloc] init];
    [self.dummyFactsArray addObject:@"fact 1"];
    [self.dummyFactsArray addObject:@"fact 2"];
    
    self.dummyArticlesArray = [[NSMutableArray alloc] init];
    [self.dummyArticlesArray addObject:@"article 1"];
    [self.dummyArticlesArray addObject:@"article 2"];
    
    self.dummyEventsArray = [[NSMutableArray alloc] init];
    [self.dummyEventsArray addObject:@"events 1"];
    [self.dummyEventsArray addObject:@"events 2"];
    
    self.currentArray = self.dummyFactsArray;
}


@end
