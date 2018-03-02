//
//  howDoesViewController.m
//  climateConvos
//
//  Created by Nicolas E. Blomgren on 2/26/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "howDoesViewController.h"

@interface howDoesViewController ()
@property (weak, nonatomic) IBOutlet UITextView *educView;

@property (strong,nonatomic) NSArray*howTexts;

@property (weak, nonatomic) IBOutlet UIButton *rightNav;
@property (weak, nonatomic) IBOutlet UIButton *leftNav;

@property (nonatomic) int currentView;

@end

@implementation howDoesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Initialize array
    [self initArray];
    self.leftNav.hidden = YES;
    //Initialize view keeper
    _currentView = 0;
    
    _educView.text = _howTexts[_currentView];
}

-(void) initArray
{
    self.howTexts = [NSArray arrayWithObjects:
          @" 0",
          @" 1",
          @" 2",
          @" 3",
          @" 4" , nil];
}

- (IBAction)rightNav:(id)sender {
    self.leftNav.hidden = NO;
    
    self.educView.text = self.howTexts[++_currentView];
    
    if (_currentView > 3)
    {
        self.rightNav.hidden = YES;
    }
}

- (IBAction)leftNav:(id)sender {
    self.rightNav.hidden = NO;
    
    self.educView.text = self.howTexts[--_currentView];
    
    if (_currentView == 0)
    {
        _leftNav.hidden = YES;
    }
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
