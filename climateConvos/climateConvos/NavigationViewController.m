//
//  NavigationViewController.m
//  climateConvos
//
//  Created by Senglong on 4/9/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "NavigationViewController.h"
#import <QuartzCore/QuartzCore.h>

ContainerViewController *container;

@interface NavigationViewController ()
@property (weak, nonatomic) IBOutlet UIView *displayPage;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (nonatomic) BOOL titleButtonPressed;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet UIView *displayGEO;

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self toPerviousPage];
    [self buttonShadows];
    self.titleButtonPressed = NO;
    self.displayGEO.hidden=NO;
  
}




- (IBAction)titleButton:(id)sender {
    
    if (self.titleButtonPressed) {
        [self closeMenu];
    } else if (!self.titleButtonPressed) {
        [self openMenu];
    }
    
}

-(void)toPerviousPage{
    if([self.VCSegueWasPerformedFrom isEqualToString:@"articlesVC"]){
        [self.container segueIdentifierReceivedFromParent:@"toTopic"];
    }
}


- (IBAction)homeButton:(id)sender {
    [self.container segueIdentifierReceivedFromParent:@"toHome"];
    
    //change the label
    [self.titleButton setTitle:@"Discover" forState:UIControlStateNormal];
   // [self.homeButton setImage:[UIImage imageNamed:@"house-selected"] forState : UIControlStateNormal];
    [self stylingNotInMenu];
    [self closeMenu];
    
}
- (IBAction)profileButton:(id)sender {
    [self.container segueIdentifierReceivedFromParent:@"toProfile"];
    
    
    //change the label
    
    [self.titleButton setTitle:@"Profile" forState:UIControlStateNormal];
    [self stylingNotInMenu];
    self.settingsButton.hidden=NO;
    self.profileButton.hidden=YES;
    
}
- (IBAction)settingsButton:(id)sender {
    [self.container segueIdentifierReceivedFromParent:@"toSettings"];
    
    //change the label
    [self.titleButton setTitle:@"Settings" forState:UIControlStateNormal];
    [self stylingNotInMenu];
    self.settingsButton.hidden=YES;
    self.profileButton.hidden=NO;
    
    [self closeMenu];
    
    
}


- (IBAction)topicButton:(id)sender {
   
    [self.container segueIdentifierReceivedFromParent:@"toTopic"];
    
    
    //change the label
    [self.topicButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.titleButton setTitle:@"Search by Topic" forState:UIControlStateNormal];
     [self buttonStyling];
    [self closeMenu];
    
    
}

- (IBAction)educationButton:(id)sender {
   
    [self.container segueIdentifierReceivedFromParent:@"toEducation"];
    
    
    //change the label
    [self.titleButton setTitle:@"Get Educated" forState:UIControlStateNormal];
     [self buttonStyling];
    [self closeMenu];
}

- (IBAction)getActiveButton:(id)sender {
   
    [self.container segueIdentifierReceivedFromParent:@"toGetActive"];
    
    //change the label
    [self.titleButton setTitle:@"Find Events" forState:UIControlStateNormal];
     [self buttonStyling];
    [self closeMenu];
}


//change home icon
- (IBAction)notHomeButton:(id)sender {
    [self.homeButton setImage:[UIImage imageNamed:@"house icon"] forState : UIControlStateNormal];
}

//hide settings button
- (IBAction)hideSettingsButton:(id)sender {
    self.settingsButton.hidden=YES;
    self.profileButton.hidden=NO;
}

//dropdown menu shadows
-(void)buttonShadows{
//    [self.topicButton.layer setShadowOffset:CGSizeMake(5, 5)];
//    [self.topicButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
//    [self.topicButton.layer setShadowOpacity:0.5];
//    [self.getActiveButton.layer setShadowOffset:CGSizeMake(5, 5)];
//    [self.getActiveButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
//    [self.getActiveButton.layer setShadowOpacity:0.5];
//    [self.educationButton.layer setShadowOffset:CGSizeMake(5, 5)];
//    [self.educationButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
//    [self.educationButton.layer setShadowOpacity:0.5];
}


-(void)buttonStyling{
    
    if ([_titleButton.currentTitle isEqualToString:_topicButton.currentTitle]) {
        [self.topicButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.topicButton setBackgroundColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]];
//        [self.topicButton.layer setBorderWidth:3.0];
//        [self.topicButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
//        CGRect      buttonFrame = self.topicButton.frame;
//        buttonFrame.size = CGSizeMake(150, 70);
//        self.topicButton.frame = buttonFrame;
    }
    else{
        [self.topicButton setTitleColor:[UIColor colorWithRed:104/255.0 green:188/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.topicButton setBackgroundColor:[UIColor whiteColor]];
      
        
    }
    
    if ([_titleButton.currentTitle isEqualToString:_educationButton.currentTitle]){
        [self.educationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.educationButton setBackgroundColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]];
      
        
    }
    else{
        [self.educationButton setTitleColor:[UIColor colorWithRed:104/255.0 green:188/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.educationButton setBackgroundColor:[UIColor whiteColor]];
     
        
    }
    
    if ([_titleButton.currentTitle isEqualToString:_getActiveButton.currentTitle]){
        [self.getActiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.getActiveButton setBackgroundColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0]];
      
        
    }
    else{[self.getActiveButton setTitleColor:[UIColor colorWithRed:104/255.0 green:188/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.getActiveButton setBackgroundColor:[UIColor whiteColor]];
    
        
    }
   
    
}

-(void)stylingNotInMenu{
    [self.topicButton setBackgroundColor:[UIColor whiteColor]];
     [self.getActiveButton setBackgroundColor:[UIColor whiteColor]];
     [self.educationButton setBackgroundColor:[UIColor whiteColor]];
    [self.topicButton setTitleColor:[UIColor colorWithRed:104/255.0 green:188/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.getActiveButton setTitleColor:[UIColor colorWithRed:104/255.0 green:188/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.educationButton setTitleColor:[UIColor colorWithRed:104/255.0 green:188/255.0 blue:227/255.0 alpha:1.0] forState:UIControlStateNormal];
}


-(void)openMenu{
    
    [UIView animateWithDuration:0.5
                     animations:^{self.displayPage.center = CGPointMake(187, 505);}];
    
    self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
    self.titleButtonPressed = YES;
}

-(void)closeMenu{
    
    [UIView animateWithDuration:0.5
                     animations:^{self.displayPage.center = CGPointMake(187, 365);}];
    
    self.arrow.transform = CGAffineTransformMakeRotation(M_PI*2);
    self.titleButtonPressed = NO;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    //  vc = [[UIViewController alloc]init];
    // Make sure your segue name in storyboard is the same as this line
    
    if ([[segue identifier] isEqual: @"container"]){
        
        self.container = (ContainerViewController *)[segue destinationViewController];
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
