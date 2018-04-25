//
//  CategoriesViewController.m
//  climateConvos
//
//  Created by Sandra Le on 4/11/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "CategoriesViewController.h"

@interface CategoriesViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width,self.scrollView.bounds.size.height*1.5)];
    
    [self.scrollView addSubview:self.button1];
    [self.scrollView addSubview:self.button2];
    [self.scrollView addSubview:self.button3];
    [self.scrollView addSubview:self.button4];
    [self.scrollView addSubview:self.button5];
    [self.scrollView addSubview:self.button6];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn:(id)sender {
}
@end
