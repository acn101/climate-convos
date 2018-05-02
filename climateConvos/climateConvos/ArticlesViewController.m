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

@property (weak, nonatomic) IBOutlet UILabel *topic;
@property (weak, nonatomic) IBOutlet UIView *whiteFrame;
@property (weak, nonatomic) IBOutlet UITextView *factoid;



@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.whiteFrame.layer.cornerRadius = 11;
    self.whiteFrame.layer.masksToBounds = YES;
    NSLog(@"should display articles for %@", self.selectedCategory);
    self.topic.text = self.selectedCategory;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NavigationViewController *navigationVC = segue.destinationViewController;
    navigationVC.VCSegueWasPerformedFrom = @"articlesVC";
}


@end
