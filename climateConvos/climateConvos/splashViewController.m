//
//  splashViewController.m
//  climateConvos
//
//  Created by SENG NGOR on 5/7/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "splashViewController.h"
#import "UIImage+animatedGIF.h"
@interface splashViewController ()

@end

@implementation splashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayBG];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayBG{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"launch" withExtension:@"gif"];
    self.splashBG.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
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
