//
//  GEOViewController.m
//  climateConvos
//
//  Created by Senglong on 4/18/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "GEOViewController.h"
#import "UIImage+animatedGIF.h"
#import "Tip.h"


@interface GEOViewController ()


@property (weak, nonatomic) IBOutlet UITextView *geoText;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) NSMutableArray *tips;

@property (weak, nonatomic) IBOutlet UILabel *tapButton;

@property (weak, nonatomic) IBOutlet UIButton *GEO;
@property (weak, nonatomic) IBOutlet UIImageView *speechBubble;

@property (nonatomic) Boolean tapped;



@end

@implementation GEOViewController

- (void)viewDidLoad {
    //[self checkEnabledStatus];
    
    [super viewDidLoad];
    [self checkEnabledStatus];
    [self setup];
    [self displayGeo];
    
    self.tapped = YES;
}

- (void)setup {
    self.ref = [[FIRDatabase database] reference];
    self.tips = [[NSMutableArray alloc] init];
    [self tipsDB];
    self.geoText.textAlignment = NSTextAlignmentCenter;
    [self displayTip];
}

-(void)checkEnabledStatus
{
    NSString *currentSavedGeo = [[NSUserDefaults standardUserDefaults]
                                    stringForKey:@"geoEnabledStatus"];
    if ([currentSavedGeo isEqualToString:(@"disableGeo")])
    {
        [self disableGeo:YES];
      
    }else if([currentSavedGeo isEqualToString:(@"enableGeo")]){
        [self disableGeo:NO];
    }
}


- (void)tipsDB {
    [[self.ref child:@"Tips"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.dict = snapshot.value;
        for (NSString *factNumber in self.dict) {
            Tip *tip = [[Tip alloc] init];
            tip.number = factNumber;
            NSDictionary *tipsDetails = [self.dict objectForKey:factNumber];
            tip.tags = [tipsDetails  objectForKey:@"tags"];
            tip.text = [tipsDetails objectForKey:@"text"];
            [self.tips addObject:tip];
            // NSLog(@"this is the current tip %@", tip);
            //  [self displayTip];
        }
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

    
-(void)displayGeo{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"geo" withExtension:@"gif"];
    self.geoGif.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
}

-(void)displayTip{
    
    [self.ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        int random = arc4random_uniform(self.tips.count);
        Tip *currentTip = self.tips[random];
        self.geoText.text = currentTip.text;
    }];
}


- (IBAction)geoPressed:(id)sender {
    int random = arc4random_uniform(self.tips.count);
    Tip *currentTip = self.tips[random];
    self.geoText.text = currentTip.text;
    if(self.tapped) {
        self.tapButton.hidden = self.tapped;
        self.tapped = NO;
    }
}

-(void)disableGeo:(bool) input{
    self.geoGif.hidden=input;
    self.speechBubble.hidden=input;
    self.geoText.hidden = input;
    
    
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
