//
//  locationViewController.m
//  climateConvos
//
//  Created by Nicolas E. Blomgren on 4/23/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *location;


@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}



- (IBAction)saveLocation:(id)sender {
    if(_location.selectedSegmentIndex == 0)
    {
        NSString *valueToSave = @"Seattle";
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"location"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    if(_location.selectedSegmentIndex == 1)
    {
        NSString *valueToSave = @"Houston";
        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"location"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
