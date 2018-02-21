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


@end

@implementation EducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (IBAction)changePro:(UIButton *)sender {
    self.educText.text = [self proactive];
    
}

- (IBAction)changeWhatIs:(UIButton *)sender {
    self.educText.text = [self whatIsIt];
}

- (IBAction)changeHow:(UIButton *)sender {
    self.educText.text = [self howDoesIt];
}

- (IBAction)changeWhatCan:(UIButton *)sender {
    self.educText.text = [self whatCanYou];
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

- (NSString *)proactive
{
    return @"Proactive Conversation";
}

- (NSString *)whatIsIt
{
    return @"What Even Is it";
}

- (NSString *)howDoesIt
{
    return @"How Does it Affect You";
}

- (NSString *)whatCanYou
{
    return @"What Can You Do About It";
}

- (IBAction)hello:(UIButton *)sender {
}
@end
