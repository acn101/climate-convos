//
//  GEOViewController.m
//  climateConvos
//
//  Created by Senglong on 4/18/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "GEOViewController.h"


@interface GEOViewController ()
@property (weak, nonatomic) IBOutlet UIButton *GEO;
@property (weak, nonatomic) IBOutlet UIWebView *geoMain;


@end

@implementation GEOViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
//    [self animatedGeo];
    // Do any additional setup after loading the view.
    [self loadHTML];
}

- (IBAction)clearDefaults:(id)sender {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

// gif of GEO
- (void)loadHTML {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"geo" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSURL *baseURL = [url URLByDeletingLastPathComponent];
    [self.geoMain loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:baseURL];
    
    //make the background transparent
    [self.geoMain setBackgroundColor:[UIColor clearColor]];
    [self.geoMain setOpaque:NO];
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
