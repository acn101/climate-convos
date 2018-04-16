//
//  ArticlesViewController.m
//  climateConvos
//
//  Created by Sandra Le on 4/15/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "ArticlesViewController.h"

@interface ArticlesViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIImageView *logo1;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;

@end

@implementation ArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width,self.scrollView.bounds.size.height*1.5)];
    
    [self.scrollView addSubview:self.button1];
    [self.scrollView addSubview:self.label1];
    [self.scrollView addSubview:self.logo1];
    [self.scrollView addSubview:self.button2];
    [self.scrollView addSubview:self.button3];
    [self.scrollView addSubview:self.button4];
    [self.scrollView addSubview:self.button5];
    [self.scrollView addSubview:self.button6];
    [self.scrollView addSubview:self.button7];
    [self.scrollView addSubview:self.button8];
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
