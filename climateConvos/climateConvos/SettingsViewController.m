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
@property (weak, nonatomic) IBOutlet UIView *geoButtonView;
@property (weak, nonatomic) IBOutlet UILabel *geoLabel;
@property (weak, nonatomic) IBOutlet UILabel *lockscreenLabel;
@property (weak, nonatomic) IBOutlet UILabel *soundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *notificationsLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;
@property (weak, nonatomic) IBOutlet UISwitch *geoSwitch;


@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self style];

    
}

- (IBAction)geoSwitch:(id)sender {
    if([sender isOn]){
        self.geoLabel.text = @"Disable GEO";
    } else{
        self.geoLabel.text = @"Enable GEO";
    }
}




-(void)style{
    self.geoButtonView.layer.cornerRadius = 11;
    self.geoButtonView.layer.masksToBounds = true;
    self.lockscreenLabel.layer.cornerRadius = 11;
    self.lockscreenLabel.layer.masksToBounds = true;
    self.soundsLabel.layer.cornerRadius = 11;
    self.soundsLabel.layer.masksToBounds = true;
    self.notificationsLabel.layer.cornerRadius = 11;
    self.notificationsLabel.layer.masksToBounds = true;
    self.locationButton.layer.cornerRadius = 11;
    self.locationButton.layer.masksToBounds = true;
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
