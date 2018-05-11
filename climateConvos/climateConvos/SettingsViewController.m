//
//  SettingsViewController.m
//  climateConvos
//
//  Created by SENG NGOR on 4/25/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "SettingsViewController.h"
#import "GEOViewController.h"




@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *seattleButton;
@property (weak, nonatomic) IBOutlet UIButton *houstonButton;

@property (weak, nonatomic) IBOutlet UIView *geoButtonView;
@property (weak, nonatomic) IBOutlet UILabel *geoLabel;
@property (weak, nonatomic) IBOutlet UILabel *soundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationsLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UISwitch *geoSwitch;
@property  (weak, nonatomic) GEOViewController *geoView;


@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self style];

    
}

//clearDefault
- (IBAction)clearDefaults:(id)sender {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

- (IBAction)aboutUs:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"About Us👋" message:@"\n\n We are SASON, a team of UW students from the Interactive Media Design program and we are creating an iOs app called Climate Convos. Climate Convos creates the agency for well-informed conversations about climate change. It does this through the use of factoids, local articles, and interactive data (live data), which are based on scholarly research and sources. By adding informed dialogue to the world, we believe we can create change to the systems which affect our earth. The information is presented in a way that it advocates face-to-face conversations and can also lead to activism. Users will also be presented with local events and calls-to-action based in the Pacific NorthWest. Due to this localization, we hope to create a sense of urgency as people would then feel a personal stake in the issue.\n" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
    
    UITextView *textAboutUs = [[UITextView alloc] initWithFrame:CGRectMake(15, 35, 250, 100)];
    textAboutUs.backgroundColor = [UIColor clearColor];
    textAboutUs.textColor = [UIColor whiteColor];
    textAboutUs.editable = NO;
    textAboutUs.scrollEnabled = YES;
    textAboutUs.font = [UIFont systemFontOfSize:15];
    
    [alert addSubview:textAboutUs];
    [alert show];
}
- (IBAction)seattleButton:(id)sender {
    NSString *valueToSave = @"Seattle";
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"location"];
    self.seattleButton.backgroundColor=[UIColor whiteColor];
    self.houstonButton.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    

}
- (IBAction)houstonButton:(id)sender {
    NSString *valueToSave = @"Houston";
    [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"location"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.houstonButton.backgroundColor=[UIColor whiteColor];
    self.seattleButton.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0];
    
}

//- (IBAction)geoSwitch:(id)sender {
//
//    if([sender isOn]){
//        NSString *valueToSave = @"disableGeo";
//        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"geoEnabledStatus"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        NSLog(valueToSave);
//        self.geoView.view.hidden = YES;
//
//    } else{
//        NSString *valueToSave = @"enableGeo";
//        [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"geoEnabledStatus"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        NSLog(valueToSave);
//        //[_geoView setHidden:YES];
//
//    }
//}




-(void)style{
    self.geoButtonView.layer.cornerRadius = 11;
    self.geoButtonView.layer.masksToBounds = true;
    self.soundsLabel.layer.cornerRadius = 11;
    self.soundsLabel.layer.masksToBounds = true;
    self.notificationsLabel.layer.cornerRadius = 11;
    self.notificationsLabel.layer.masksToBounds = true;
    self.locationButton.layer.cornerRadius = 11;
    self.locationButton.layer.masksToBounds = true;
    self.seattleButton.layer.cornerRadius = 11;
    self.seattleButton.layer.masksToBounds = true;
    self.houstonButton.layer.cornerRadius = 11;
    self.houstonButton.layer.masksToBounds = true;
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
