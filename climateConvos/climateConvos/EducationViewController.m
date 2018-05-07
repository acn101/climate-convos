//
//  EducationViewController.m
//  climateConvos
//
//  Created by neeks on 2/12/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "EducationViewController.h"

@interface EducationViewController ()
@property (weak, nonatomic) IBOutlet UITextView *educText;
@property (weak, nonatomic) IBOutlet UILabel *educTitle;

@property (weak, nonatomic) IBOutlet UIButton *rightNav;
@property (weak, nonatomic) IBOutlet UIButton *leftNav;

@property (weak, nonatomic) IBOutlet UIImageView *module;
@property (weak, nonatomic) IBOutlet UIImageView *module2;


@property (weak, nonatomic) IBOutlet UITextView *modText;
@property (weak, nonatomic) IBOutlet UIButton *hide;

@property (strong,nonatomic) NSArray*currentTexts;

// Buttons to change module & modText
@property (weak, nonatomic) IBOutlet UIButton *proButt;
@property (weak, nonatomic) IBOutlet UIButton *whatButt;
@property (weak, nonatomic) IBOutlet UIButton *howButt;
@property (weak, nonatomic) IBOutlet UIButton *whatCanButt;


@property (nonatomic) int pageView;
@property (nonatomic) int index;





@end


@implementation EducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _educTitle.textAlignment = NSTextAlignmentCenter;
    _pageView = 0;
    
    [self hideContent];
    
}
- (IBAction)hideButt:(id)sender {
    [self hideContent];
}
-(void) hideContent
{
    _proButt.enabled = YES;
    _whatButt.enabled = YES;
    _howButt.enabled = YES;
    _whatCanButt.enabled = YES;
    _module.hidden = YES;
    _module2.hidden = YES;
    
    [UIView transitionWithView:_module
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        _module.hidden = YES;
                        _modText.hidden = YES;
                        _hide.hidden = YES;
                        _rightNav.hidden = YES;
                        _leftNav.hidden = YES;
                    }
                    completion:NULL];
    _index = 0;
}

- (void) showContent
{
    
    _proButt.enabled = NO;
    _whatButt.enabled = NO;
    _howButt.enabled = NO;
    _whatCanButt.enabled = NO;
    
    [UIView transitionWithView:_modText
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        
                        _modText.hidden = NO;
                        
                    } completion: NULL];
    _module.hidden = NO;
    _module2.hidden = NO;
    _hide.hidden = NO;
    _rightNav.hidden = NO;
}


- (IBAction)proMod:(id)sender {
    [self showContent];
    _pageView = 1;
    _index = 0;
    
    [self initProArray];
    _modText.text = _currentTexts[_index];
    
    //_modText =
    //self.leftNav.hidden = YES;
}
- (void) initProArray
{
    _currentTexts = [NSArray arrayWithObjects:
                     @"Climate Change can be rather difficult to talk about. It's complex, huge, and very political. Luckily, we on the Climate Convos team have some guidance for you to follow during your climate convos. ",
                     @"Something to start you out with is to take it easy, and understand that it's not the end of the world, especially if the person you're talking to doesn't agree with you 1",
                     @"It's always important to talk about it optimistically, and to not think it's the end of the world. 2",
                     @"Holding a proactive conversation is to talk about solutions and remaining hopeful. 3",
                     @"More stuff here!!!!! More text and explanation about proactive conversations and stuff. 4" , nil];
}

- (IBAction)whatMod:(id)sender {
    [self showContent];
    _pageView = 2;
    [self initWhatArray];
    _modText.text = _currentTexts[0];
    
}
- (void)initWhatArray
{
    _currentTexts = [NSArray arrayWithObjects:
                     @" What is it",
                     @" 1w",
                     @" 2w",
                     @" 3w",
                     @" 4w" , nil];
}

- (IBAction)howMod:(id)sender {
    [self showContent];
    _pageView = 3;
    [self initHowArray];
    _modText.text = _currentTexts[0];
}
- (void)initHowArray
{
    _currentTexts = [NSArray arrayWithObjects:
                     @" How Does it Effect You",
                     @" 1h",
                     @" 2h",
                     @" 3h",
                     @" 4h" , nil];
}

- (IBAction)whatCanMod:(id)sender {
    [self showContent];
    _pageView = 4;
    [self initWhatCanArray];
    _modText.text = _currentTexts[0];
}
- (void)initWhatCanArray
{
    _currentTexts = [NSArray arrayWithObjects:
                     @" What Can you do about it",
                     @" 1c",
                     @" 2c",
                     @" 3c",
                     @" 4c" , nil];
}




- (IBAction)navRight:(UIButton *)sender {
    CATransition *transition = [CATransition new];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    
    // Make any view changes
    _modText.text = _currentTexts[++_index];
    
    // Add the transition
    [_modText.layer addAnimation:transition forKey:@"transition"];
    [_module.layer addAnimation:transition forKey:@"transition"];
    [_module2.layer addAnimation:transition forKey:@"transition"];
    
    
    
    if (_index > 0)
    {
        _leftNav.hidden = NO;
    }
    
    if (_index > 3)
    {
        _rightNav.hidden = YES;
        
    }
    

}

- (IBAction)navLeft:(UIButton *)sender {
    CATransition *transition = [CATransition new];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    
    // Make any view changes
    _modText.text = _currentTexts[--_index];
    
    // Add the transition
    [_modText.layer addAnimation:transition forKey:@"transition"];
    [_module.layer addAnimation:transition forKey:@"transition"];
    [_module2.layer addAnimation:transition forKey:@"transition"];
    
    
    
    if (_index == 0)
    {
        _leftNav.hidden = YES;
    }
    
    if (_index < 4)
    {
        _rightNav.hidden = NO;
        
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

- (IBAction)hello:(UIButton *)sender {
}
@end
