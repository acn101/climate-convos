//
//  DiscoverViewController.m
//  climateConvos
//
//  Created by Sandra Le on 2/7/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UITextView *discoverText;
@property (nonatomic) int current;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkStatus];
    [self checkID];
}

- (void)checkID {
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSLog(@"this is the key: %@", bundleIdentifier);
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
            self.discoverText.text = [self text1];
            break;
        case 2:
            self.leftButton.hidden = NO;
            self.rightButton.hidden = NO;
            self.discoverText.text = [self text2];
            break;
        case 3:
            self.leftButton.hidden = NO;
            self.rightButton.hidden = NO;
            self.discoverText.text = [self text3];
            break;
        case 4:
            self.leftButton.hidden = NO;
            self.rightButton.hidden = YES;
            self.discoverText.text = [self text4];
            break;
        default:
            break;
    }
}

- (NSString *)text1
{
    return @"To Climate Convos, where we believe the solution begins with conversation. I'm Geo and I've got some tips for you before you begin. Feel free to skip and get started right away!";
}

- (NSString *)text2
{
    return @"The purpose of this app is to provide a platform which helps users like you talk about climate change. We believe this is the best way to spread awareness, promote action, and create systematic change.";
}

- (NSString *)text3
{
    return @"The app provides well-researched and easy-to-digest factoids that you are encouraged to bring up in your day-to-day conversation. You can also explore the sources and related news articles.";
}

- (NSString *)text4
{
    return @"You may also input your location, and you will receive curated information and different activism based on where you are! CC is your one-stop-shop for getting started with helping stop climate change.";
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
