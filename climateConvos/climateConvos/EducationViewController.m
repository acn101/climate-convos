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

@property (weak, nonatomic) IBOutlet UILabel *modTitle;


@property (nonatomic) int pageView;
@property (nonatomic) int index;


@end


@implementation EducationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _educTitle.textAlignment = NSTextAlignmentCenter;
    _pageView = 0;
    
    [_modText setFont:[UIFont systemFontOfSize:14]];
    [_modTitle setFont:[UIFont systemFontOfSize:16]];
    
    _modText.textAlignment = NSTextAlignmentCenter;
    _modTitle.textAlignment = NSTextAlignmentCenter;
    
    
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
    _modTitle.hidden = YES;
    
    
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
    _modTitle.hidden = NO;
    _hide.hidden = NO;
    _rightNav.hidden = NO;
}


- (IBAction)proMod:(id)sender {
    [self showContent];
    _pageView = 1;
    _index = 0;
    
    [self initProArray];
    _modText.text = _currentTexts[_index];
    _modTitle.text = @"Proactive Conversation";
    
    //_modText =
    //self.leftNav.hidden = YES;
}
- (void) initProArray
{
    _currentTexts = [NSArray arrayWithObjects:
                     @"Climate Change can be rather difficult to talk about. It's complex, huge, and can be very political. Luckily, we on the Climate Convos team have some guidance for you to follow during your conversations about and your approach towards climate change. ",
                     @"Something to start you out with is that, no matter what, don't worry too much. Even though there's plenty of news, ongoing conversations, and changing legislature about climate change that can definitely get a little bit scary, it's not quite the end of the world. Make sure to always step back and don't let the severity of the situation stress you.",
                     @"It's always important to talk about climate change optimistically, and in terms of finding soltions. Many, when approaching the topic, can find themselves worrying and overly stressed, speaking about the end of days and so forth. Also, it is often such worries aren't appropriately educated or researched; the best thing that we can do to combat this is to educate ourselves, which is what you're doing right now!",
                     @" We're here to tell you that, even if it were the 'end of days', speaking so negatively isn't going to get anything done. To hold proactive conversations, stay positive, and discuss real-life action that can be taken. The importance is understanding the difference between urgency and agency. Urgency is the stress and motivation which come with realizing the severity of the problem, whereas agency is the actual action which can be taken in order to help mend the issue itself. Agency is far more important. ",
                     @"The major difference to distinguish in this ongoing conversation to combat climate change is that: it's a conversation. It's not an argument, or a debate. And if it ever turns into one, then time to talk about solutions and being proactive is lost. Arguing with an uncle at Thanksgiving dinner gets us, and our planet, nowhere. Instead of this argument, throwing aggressive opinions around, think about instead holding a friendly climate conversation, backed up with facts, and education. And you can do that by starting here. " , nil];
}

- (IBAction)whatMod:(id)sender {
    [self showContent];
    _pageView = 2;
    [self initWhatArray];
    _modText.text = _currentTexts[0];
    _modTitle.text = @"What is Climate Change?";
}
- (void)initWhatArray
{
    _currentTexts = [NSArray arrayWithObjects:
                     @"Webster's dictionary definition: Climate Change is - 'a change in global or regional climate patterns, in particular a change apparent from the mid to late 20th century onwards and attributed largely to the increased levels of atmospheric carbon dioxide produced by the use of fossil fuels.'",
                     @" From NASA: Evidence  - The Earth's climate has changed throughout history. Just in the last 650,000 years there have been seven cycles of glacial advance and retreat, with the abrupt end of the last ice age about 7,000 years ago marking the beginning of the modern climate era — and of human civilization. Most of these climate changes are attributed to very small variations in Earth’s orbit that change the amount of solar energy our planet receives. ",
                     
                     @" From NASA: Evidence (Global Warming) - The current warming trend is of particular significance because most of it is extremely likely (greater than 95 percent probability) to be the result of human activity since the mid-20th century and proceeding at a rate that is unprecedented over decades to millennia. Earth-orbiting satellites and other technological advances have enabled scientists to see the big picture, collecting many different types of information about our planet and its climate on a global scale. This body of data, collected over many years, reveals the signals of a changing climate.",
                     @" From NASA: Causes - Most climate scientists agree the main cause of the current global warming trend is human expansion of the 'greenhouse effect' — warming that results when the atmosphere traps heat radiating from Earth toward space. Certain gases in the atmosphere block heat from escaping. Long-lived gases that remain semi-permanently in the atmosphere and do not respond physically or chemically to changes in temperature are described as 'forcing' climate change. ",
                     @" From NASA: Causes - On Earth, human activities are changing the natural greenhouse. Over the last century the burning of fossil fuels like coal and oil has increased the concentration of atmospheric carbon dioxide (CO2). This happens because the coal or oil burning process combines carbon with oxygen in the air to make CO2. To a lesser extent, the clearing of land for agriculture, industry, and other human activities has increased concentrations of greenhouse gases. " , nil];
}

- (IBAction)howMod:(id)sender {
    [self showContent];
    _pageView = 3;
    [self initHowArray];
    _modText.text = _currentTexts[0];
    _modTitle.text = @"How Does it Effect You?";
}
- (void)initHowArray
{
    _currentTexts = [NSArray arrayWithObjects:
                     @" Global climate change has already had observable effects on the environment. Glaciers have shrunk, ice on rivers and lakes is breaking up earlier, plant and animal ranges have shifted and trees are flowering sooner.",
                     @"Scientists have high confidence that global temperatures will continue to rise for decades to come, largely due to greenhouse gases produced by human activities. The Intergovernmental Panel on Climate Change (IPCC), which includes more than 1,300 scientists from the United States and other countries, forecasts a temperature rise of 2.5 to 10 degrees Fahrenheit over the next century.",
                     @"Summer temperatures are projected to continue rising, and a reduction of soil moisture, which exacerbates heat waves, is projected for much of the western and central U.S. in summer. By the end of this century, what have been once-in-20-year extreme heat days (one-day events) are projected to occur every two or three years over most of the nation.",
                     @"Global climate is projected to continue to change over this century and beyond. The magnitude of climate change beyond the next few decades depends primarily on the amount of heat-trapping gases emitted globally, and how sensitive the Earth’s climate is to those emissions.",
                     @"The length of the frost-free season (and the corresponding growing season) has been increasing nationally since the 1980s, with the largest increases occurring in the western United States, affecting ecosystems and agriculture. Across the United States, the growing season is projected to continue to lengthen." , nil];
    
}

- (IBAction)whatCanMod:(id)sender {
    [self showContent];
    _pageView = 4;
    [self initWhatCanArray];
    _modText.text = _currentTexts[0];
    _modTitle.text = @"What Can You Do About It?";
}
- (void)initWhatCanArray
{
    _currentTexts = [NSArray arrayWithObjects:
                     @"Climate change is one of the most complex issues facing us today. It involves many dimensions – science, economics, society, politics and moral and ethical questions – and is a global problem, felt on local scales, that will be around for decades and centuries to come. Carbon dioxide, the heat-trapping greenhouse gas that has driven recent global warming, lingers in the atmosphere for hundreds of years, and the planet (especially the oceans) takes a while to respond to warming.",
                     @"How much climate change? That will be determined by how our emissions continue and also exactly how our climate system responds to those emissions. Despite increasing awareness of climate change, our emissions of greenhouse gases continue on a relentless rise. In 2013, the daily level of carbon dioxide in the atmosphere surpassed 400 parts per million for the first time in human history. The last time levels were that high was about three to five million years ago, during the Pliocene era.",
                     @"Because we are already committed to some level of climate change, responding to climate change involves a two-pronged approach: 1. Reducing emissions of and stabilizing the levels of heat-trapping greenhouse gases in the atmosphere (“mitigation”); 2. Adapting to the climate change already in the pipeline (“adaptation”).",
                     @"Mitigation – reducing climate change – involves reducing the flow of heat-trapping greenhouse gases into the atmosphere, either by reducing sources of these gases (for example, the burning of fossil fuels for electricity, heat or transport) or enhancing the “sinks” that accumulate and store these gases (such as the oceans, forests and soil). The goal of mitigation is to avoid significant human interference with the climate system, and “stabilize greenhouse gas levels in a timeframe sufficient to allow ecosystems to adapt naturally to climate change.",
                     @"Adaptation – adapting to life in a changing climate – involves adjusting to actual or expected future climate. The goal is to reduce our vulnerability to the harmful effects of climate change (like sea-level encroachment, more intense extreme weather events or food insecurity). It also encompasses making the most of any potential beneficial opportunities associated with climate change (for example, longer growing seasons or increased yields in some regions)." , nil];
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
