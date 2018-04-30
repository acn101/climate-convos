//
//  GEOViewController.m
//  climateConvos
//
//  Created by Senglong on 4/18/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "GEOViewController.h"
#import "UIImage+animatedGIF.h"

@interface GEOViewController ()
@property (weak, nonatomic) IBOutlet UIButton *GEO;
@property (weak, nonatomic) IBOutlet UIImageView *speechBubble;



@end

@implementation GEOViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
//    [self animatedGeo];
    // Do any additional setup after loading the view.
    
    [self displayGeo];
}
    
    
-(void)displayGeo{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"geo" withExtension:@"gif"];
    self.geoGif.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
}
- (IBAction)geoPressed:(id)sender {
    [self disableGeo];
}

-(void)disableGeo{
    self.geoGif.hidden=YES;
    self.speechBubble.hidden=YES;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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

@end
