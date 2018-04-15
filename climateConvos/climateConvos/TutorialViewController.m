//
//  TutorialViewController.m
//  climateConvos
//
//  Created by acn96 on 2/7/18.
//  Copyright © 2018 acn96. All rights reserved.
//
//oliver comment

#import "TutorialViewController.h"
@import Firebase;

@interface TutorialViewController ()
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIImageView *dotThing;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UITextView *tutorialText;
@property (nonatomic) int current;
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkStatus];
}

- (IBAction)leftAction:(UIButton *)sender {
    self.current--;
    [self checkStatus];
    //    NSLog(@"current: %i", current);
}

- (IBAction)rightAction:(UIButton *)sender {
    self.current++;
    [self checkStatus];
    //    NSLog(@"current: %i", current);
}

- (void)checkStatus{
    // Makes sure that the text counter doesn't go out of bounds
    if (self.current > 4) {
        self.current = 4;
    } else if (self.current < 1) {
        self.current = 1;
    }
    // Switch statement to change the tutorial text and check if left or right navigators should be hidden
    switch (self.current) {
        case 1:
            self.leftButton.hidden = YES;
            self.rightButton.hidden = NO;
            self.doneButton.hidden = YES;
            self.tutorialText.text = [self text1];
            self.dotThing.image = [UIImage imageNamed:@"dot1.png"];
            break;
        case 2:
            self.leftButton.hidden = NO;
            self.rightButton.hidden = NO;
            self.doneButton.hidden = YES;
            self.tutorialText.text = [self text2];
            self.dotThing.image = [UIImage imageNamed:@"dot2.png"];
            break;
        case 3:
            self.leftButton.hidden = NO;
            self.rightButton.hidden = NO;
            self.doneButton.hidden = YES;
            self.tutorialText.text = [self text3];
            self.dotThing.image = [UIImage imageNamed:@"dot3.png"];
            break;
        case 4:
            self.leftButton.hidden = NO;
            self.rightButton.hidden = YES;
            self.doneButton.hidden = NO;
            self.skipButton.hidden = YES;
            self.tutorialText.text = [self text4];
            self.dotThing.image = [UIImage imageNamed:@"dot4.png"];
            break;
        default:
            break;
    }
}

- (NSString *)text1
{
    return @"Welcome to Climate Convos! I’m Geo and I’ve got some tips for you before you begin. Feel free to skip and get started right away!";
}

- (NSString *)text2
{
    return @"Our is a platform that helps users like you talk about climate change. We believe this is the best way to spread awareness, promote action, and create systematic change.";
}

- (NSString *)text3
{
    return @"We provide well-researched and easy-to-digest factoids that you are encouraged to bring up in your day-to-day conversation. You can also explore the sources and related news articles.";
}

- (NSString *)text4
{
    return @"You can use your location to curate information and different activism based on where you are! CC is your one-stop-shop for getting started with helping stop climate change.";
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [FIRApp configure];
}

@end
