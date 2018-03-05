//
//  whatCanViewController.m
//  climateConvos
//
//  Created by Nicolas E. Blomgren on 2/26/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "whatCanViewController.h"

@interface whatCanViewController ()
@property (weak, nonatomic) IBOutlet UITextView *educView;

@property (strong,nonatomic) NSArray*aboutTexts;

@property (weak, nonatomic) IBOutlet UIButton *rightNav;
@property (weak, nonatomic) IBOutlet UIButton *leftNav;

@property (nonatomic) int currentView;

@end

@implementation whatCanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Initialize array
    [self initArray];
    self.leftNav.hidden = YES;
    //Initialize view keeper
    _currentView = 0;
    
    _educView.text = _aboutTexts[_currentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    
}

-(void) initArray
{
    self.aboutTexts = [NSArray arrayWithObjects:
                     @" 0",
                     @" 1",
                     @" 2",
                     @" 3",
                     @" 4" , nil];
}

- (IBAction)leftNav:(id)sender {
    self.rightNav.hidden = NO;
    
    self.educView.text = self.aboutTexts[--_currentView];
    
    if (_currentView == 0)
    {
        _leftNav.hidden = YES;
    }
}


- (IBAction)rightNav:(id)sender {
    self.leftNav.hidden = NO;
    
    self.educView.text = self.aboutTexts[++_currentView];
    
    if (_currentView > 3)
    {
        self.rightNav.hidden = YES;
    }
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
