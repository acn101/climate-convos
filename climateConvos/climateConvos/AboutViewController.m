//
//  AboutViewController.m
//  climateConvos
//
//  Created by SENG NGOR on 5/2/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "AboutViewController.h"
#import "NavigationViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NavigationViewController *navigationVC = segue.destinationViewController;
    navigationVC.VCSegueWasPerformedFrom = @"aboutVC";
}



@end
