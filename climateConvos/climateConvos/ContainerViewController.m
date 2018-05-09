//
//  ContainerViewController.m
//  climateConvos
//
//  Created by Senglong on 4/9/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "ContainerViewController.h"
#import "DiscoverViewController.h"
#import "Profile.h"

@interface ContainerViewController ()

@property (nonatomic, strong) NSMutableArray *savedFactoids;


@end

@implementation ContainerViewController

- (NSMutableArray *)savedFactoids
{
    if (!_savedFactoids) {
        _savedFactoids = [[NSMutableArray alloc] init];
    }
    return _savedFactoids;
}

- (void)viewDidLoad {
    
    [self segueIdentifierReceivedFromParent:@"toHome"];
    
}
-(void)segueIdentifierReceivedFromParent:(NSString*)button{
    
    if ([button isEqualToString: @"toHome"]){
        self.segueIdentifier = @"homeButton";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
    }
    else if ([button isEqualToString: @"toProfile"]){
        self.segueIdentifier = @"profileButton";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
    }
    
    else if ([button isEqualToString: @"toTopic"]){
        self.segueIdentifier = @"topicButton";
        [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
    }
    else if
        ([button isEqualToString: @"toEducation"]){
            self.segueIdentifier = @"educationButton";
            [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
        }
    else if
        ([button isEqualToString: @"toGetActive"]){
            self.segueIdentifier = @"getActiveButton";
            [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
        }
    else if
        ([button isEqualToString: @"toSettings"]){
            self.segueIdentifier = @"settingsButton";
            [self performSegueWithIdentifier:self.segueIdentifier sender:nil];
        }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController  *lastViewController, *vc;
    //  vc = [[UIViewController alloc]init];
    // Make sure your segue name in storyboard is the same as this line
    
    if ([segue.identifier isEqualToString:@"homeButton"]) {
        
        DiscoverViewController *discoverVC = segue.destinationViewController;
        discoverVC.savedFactoids = self.savedFactoids;
        
    }
    
    if ([segue.identifier isEqualToString:@"profileButton"]) {
        Profile *profileVC = segue.destinationViewController;
        profileVC.savedFactoids = self.savedFactoids;
    }
    
    if ([[segue identifier] isEqual: self.segueIdentifier]){
        if(lastViewController != nil){
            [lastViewController.view removeFromSuperview];
        }
        
        // Get reference to the destination view controller
        vc = (UIViewController *)[segue destinationViewController];
        [self addChildViewController:(vc)];
        
        vc. view.frame  = CGRectMake(0,0, self.view.frame.size.width , self.view.frame.size.height);
        
        [self.view addSubview:vc.view];
        lastViewController = vc;
        
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
