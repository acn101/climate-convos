//
//  NavigationViewController.h
//  climateConvos
//
//  Created by Senglong on 4/9/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@interface NavigationViewController : UIViewController

@property ContainerViewController *container;
@property (weak, nonatomic) IBOutlet UIButton *topicButton;
@property (weak, nonatomic) IBOutlet UIButton *educationButton;
@property (weak, nonatomic) IBOutlet UIButton *getActiveButton;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;

@end
