//
//  ArticlesViewController.m
//  climateConvos
//
//  Created by Sandra Le on 4/15/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "ArticlesViewController.h"
#import "NavigationViewController.h"

@interface ArticlesViewController ()



@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"should display articles for %@", self.selectedCategory);
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NavigationViewController *navigationVC = segue.destinationViewController;
    navigationVC.VCSegueWasPerformedFrom = @"articlesVC";
}


@end
