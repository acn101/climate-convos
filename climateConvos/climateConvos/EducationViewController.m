//
//  EducationViewController.m
//  climateConvos
//
//  Created by neeks on 2/12/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "EducationViewController.h"

@interface EducationViewController ()
@property (weak, nonatomic) IBOutlet UITextView *educText;
@property (weak, nonatomic) IBOutlet UILabel *educTitle;

@property (weak, nonatomic) IBOutlet UIButton *rightNav;
@property (weak, nonatomic) IBOutlet UIButton *leftNav;

@property (nonatomic) int pageView;

// lil change

@end


@implementation EducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _educTitle.textAlignment = NSTextAlignmentCenter;
    
    _pageView = 0;
    
    _rightNav.hidden = YES;
    _leftNav.hidden = YES;
    
}


- (IBAction)changePro:(UIButton *)sender {
    
}

- (IBAction)changeWhatIs:(UIButton *)sender {
    
}

- (IBAction)changeHow:(UIButton *)sender {
    
}

- (IBAction)changeWhatCan:(UIButton *)sender {
    
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

- (NSString *)proactive1
{
    return @"Proactive Conversation is important for making conversation like happen and like stuff";
}
- (NSString *)proactive2
{
    return @"pro2";
}
- (NSString *)proactive3
{
    return @"pro3";
}
- (NSString *)proactive4
{
    return @"pro4";
}


- (NSString *)whatIsIt1
{
    return @"Climate Change is this thing which toally sucks and should be stopped at all costs";
}

- (NSString *)howDoesIt1
{
    return @"It may not seem pressing in a grander scope, but it does actuall effect you, and the people around you...";
}

- (NSString *)whatCanYou1
{
    return @"What you can do about it is help start conversation and promote activism in order to stop legislation and systematic negatives.";
}

- (IBAction)hello:(UIButton *)sender {
}
@end
