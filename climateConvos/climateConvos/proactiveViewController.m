//
//  proactiveViewController.m
//  climateConvos
//
//  Created by Nicolas E. Blomgren on 2/28/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "proactiveViewController.h"

@interface proactiveViewController ()
@property (weak, nonatomic) IBOutlet UITextView *educView;

@property (strong,nonatomic) NSArray*proTexts;

@property (weak, nonatomic) IBOutlet UIButton *leftNav;
@property (weak, nonatomic) IBOutlet UIButton *rightNav;

@property (nonatomic) int currentView;

@end



@implementation proactiveViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //Initialize array
    [self initArray];
     self.leftNav.hidden = YES;
    //Initialize view keeper
    _currentView = 0;
    
    _educView.text = _proTexts[_currentView];
}

-(void) initArray
{
    self.proTexts = [NSArray arrayWithObjects:
    @"Climate Change is hard to talk about. It's complex, vast, and very political. Luckily I have some tips and guidance for you to follow during your climate convos. 0 ",
    @"Something to start you out with is to take it easy, and understand that it's not the end of the world, especially if the person you're talking to doesn't agree with you 1",
     @"It's always important to talk about it optimistically, and to not think it's the end of the world. 2",
     @"Holding a proactive conversation is to talk about solutions and remaining hopeful. 3",
    @"More stuff here!!!!! More text and explanation about proactive conversations and stuff. 4" , nil];
}

- (IBAction)rightNav:(id)sender {
    self.leftNav.hidden = NO;
    
    self.educView.text = self.proTexts[++_currentView];
    
    if (_currentView > 3)
    {
        self.rightNav.hidden = YES;
    }
}

- (IBAction)leftNav:(id)sender {
    self.rightNav.hidden = NO;
    
    self.educView.text = self.proTexts[--_currentView];
    
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
