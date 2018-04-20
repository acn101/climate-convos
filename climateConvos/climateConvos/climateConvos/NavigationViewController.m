//
//  NavigationViewController.m
//  climateConvos
//
//  Created by Senglong on 4/9/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "NavigationViewController.h"


ContainerViewController *container;

@interface NavigationViewController ()
@property (weak, nonatomic) IBOutlet UIView *displayPage;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (nonatomic) BOOL buttonPressed;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;


@end

@implementation NavigationViewController



- (IBAction)titleButton:(id)sender {
    
    
    if (self.buttonPressed) {
        [self closeMenu];
    } else if (!self.buttonPressed) {
        [self openMenu];
    }
    
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonPressed = NO;
    self.homeButton.hidden=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)homeButton:(id)sender {
    [self.container segueIdentifierReceivedFromParent:@"toHome"];
    
    //change the label
    [self.titleButton setTitle:@"Discover" forState:UIControlStateNormal];
    
    self.homeButton.hidden=YES;
    
    [self closeMenu];
    
}

- (IBAction)topicButton:(id)sender {
    [self.container segueIdentifierReceivedFromParent:@"toTopic"];
    
    //change the label
    
    [self.titleButton setTitle:@"Search by Topic" forState:UIControlStateNormal];
    
    self.homeButton.hidden=NO;
    
    [self closeMenu];
    
    
}

- (IBAction)educationButton:(id)sender {
    [self.container segueIdentifierReceivedFromParent:@"toEducation"];
    
    //change the label
    [self.titleButton setTitle:@"Get Educated" forState:UIControlStateNormal];
    
    self.homeButton.hidden=NO;
    
    [self closeMenu];
}

- (IBAction)getActiveButton:(id)sender {
    [self.container segueIdentifierReceivedFromParent:@"toGetActive"];
    
    //change the label
    [self.titleButton setTitle:@"Get Active" forState:UIControlStateNormal];
    
    self.homeButton.hidden=NO;
    
    [self closeMenu];
}

-(void)openMenu{
    
    [UIView animateWithDuration:0.5
                     animations:^{self.displayPage.center = CGPointMake(187, 505);}];
    
    self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
    self.buttonPressed = YES;
}

-(void)closeMenu{
    
    [UIView animateWithDuration:0.5
                     animations:^{self.displayPage.center = CGPointMake(187, 365);}];
    
    self.arrow.transform = CGAffineTransformMakeRotation(M_PI*2);
    self.buttonPressed = NO;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //  vc = [[UIViewController alloc]init];
    // Make sure your segue name in storyboard is the same as this line
    
    if ([[segue identifier] isEqual: @"container"]){
        
        self.container = (ContainerViewController *)[segue destinationViewController];
        
        
        
        
        
    }
    
}

@end
