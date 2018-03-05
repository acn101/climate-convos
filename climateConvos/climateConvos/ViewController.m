//
//  ViewController.m
//  Categories
//
//  Created by Oliver on 2/21/18.
//  Copyright © 2018 SASON. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //scrollView.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:scrollView];
    
    [scrollView setContentSize:CGSizeMake(scrollView.bounds.size.width,scrollView.bounds.size.height*1.2)];
    
    [scrollView addSubview:Button1];
    [scrollView addSubview:Button2];
    [scrollView addSubview:Button3];
    [scrollView addSubview:Button4];
    [scrollView addSubview:Button5];
    [scrollView addSubview:Button6];
    [scrollView addSubview:ExampleLabel];
    
    // old scroll view data UIView* redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
                       //redView.backgroundColor = [UIColor redColor];
                      // [self.view addSubview:redView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn:(id)sender {
}
@end
