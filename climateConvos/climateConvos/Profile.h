//
//  ListSavedViewController.h
//  CustomTableViewCells
//
//  Created by Sandra Le on 4/20/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import <UIKit/UIKit.h>
@class singleFactoid;

@interface Profile : UIViewController <UITableViewDataSource> {
    IBOutlet UISegmentedControl *control;
}
 - (IBAction)segmentedcontroller;
// this property is weak because it is "owned" by myTabBarViewController
//@property (weak, nonatomic) NSArray <singleFactoid *> *drones;

@property (nonatomic, strong) NSMutableArray *savedFactoids;

@end
