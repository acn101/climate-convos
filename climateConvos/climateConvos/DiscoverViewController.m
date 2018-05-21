//
//  DiscoverViewController.m
//  climateConvos
//
//  Created by Alan Ngo on 2/7/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "DiscoverViewController.h"
#import "singleFactoid.h"
#import "iCarousel.h"
#import "ArticlesViewController.h"
#import "AppDelegate.h"

@interface DiscoverViewController ()
{
    AppDelegate *mainDelegate;
}

@property (weak, nonatomic) IBOutlet UIView *carouselV;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) NSMutableArray *currentDB;

@property (strong, nonatomic) NSArray *getDBInfo;
@property (strong, nonatomic) singleFactoid *currentFactoid;
@property (nonatomic, strong) NSMutableArray *seattleFactoids;
@property (nonatomic, strong) NSMutableArray *houstonFactoids;


@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *items;

//@property (nonatomic, assign) NSInteger *sendMeIndex;
@property (nonatomic) int sendMeIndex;


@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.ref = [[FIRDatabase database] reference];
    self.currentDB = [[NSMutableArray alloc] init];
    self.seattleFactoids = [[NSMutableArray alloc] init];
    self.houstonFactoids = [[NSMutableArray alloc] init];
//    self.savedFactoids = [[NSMutableArray alloc] init];

    [self testDB];
}

- (void)testDB {
    [[self.ref child:@"Facts"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.dict = snapshot.value;
        for (NSString *factNumber in self.dict) {
            singleFactoid *single = [[singleFactoid alloc] init];
            single.number = factNumber;
            NSDictionary *factDetails = [self.dict objectForKey:factNumber];
            single.sources = [factDetails objectForKey:@"sources"];
            single.tags = [factDetails  objectForKey:@"tags"];
            single.location = [factDetails objectForKey:@"location"];
            single.texts = [factDetails objectForKey:@"texts"];
            [self.currentDB addObject:single];
        }
        [self setupCarousel];
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

- (void)setItems:(NSMutableArray *)items {
    NSLog(@"setting items");
    _items = items;
}

- (void)setupCarousel {
//    configure carousel
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    
//    set up data
//    your carousel should always be driven by an array of
//    data of some kind - don't store data in your item views
//    or the recycling mechanism will destroy your data once
//    your item views move off-screen
    
#pragma mark this1
    self.items = [[NSMutableArray alloc] init];
    [self.ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot *snapshot) {
        for (int i = 0; i < self.currentDB.count; i++) {
            singleFactoid *sf = [[singleFactoid alloc] init];
            sf = [self.currentDB objectAtIndex:i];
            
            NSString *currentSavedLocation = [[NSUserDefaults standardUserDefaults]
                                              stringForKey:@"location"];
            
            if ([sf.location isEqualToString:@"Seattle"] || [sf.location isEqualToString:@"Global"]) {
                [_seattleFactoids addObject:sf];
            } else if ([sf.location isEqualToString:@"Houston"] || [sf.location isEqualToString:@"Global"]) {
                [_houstonFactoids addObject:sf];
            }
            
            if([sf.location isEqualToString:currentSavedLocation] || [sf.location isEqualToString:@"Global"] ) {
                [self.items addObject:[NSNumber numberWithInt:i]];
            }
        }
        [self.carousel reloadData];
    }];
}

// Share Button

- (IBAction)shareButton:(id)sender {
    [self shareContent];
}

-(void)shareContent{
    NSString * message = @"share factoids";
    NSArray * shareItems = @[message];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}

#pragma mark - iCarousel methods
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    //return the total number of items in the carousel
    NSLog(@"numberOfItemsInCarousel self.items.count: %lu", (long unsigned)self.items.count);
    return [self.items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)carouselView {
    UILabel *label = nil;
    UILabel *topic = nil;
    
    //create new view if no view is available for recycling
    if (carouselView == nil) {
    
        // editing the boyd of the carousel
        carouselView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 327.0f, 378.0f)];
        carouselView.contentMode = UIViewContentModeCenter;
        carouselView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"discover.png"]];
        label = [[UILabel alloc] initWithFrame:CGRectMake(25, -50, 283.0f, 380.0f)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:16];
        label.tag = 1;
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithRed:94.0f/255.0f green:94.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
        [carouselView addSubview:label];
        
        // Topic Label
        topic = [[UILabel alloc] initWithFrame:CGRectMake(15, -30, 250.0f, 30.0f)];
        topic.font = [UIFont boldSystemFontOfSize:22];
        topic.numberOfLines = 0;
//        topic.text = self.currentFactoid.tags; // here
//        NSLog(@"this is the fact number %@ this is the tag %@", self.currentFactoid.number, self.currentFactoid.tags);
        topic.textColor = [UIColor whiteColor];
        [carouselView addSubview:topic];
        
        // Show more button
        UIButton *showMore = [UIButton buttonWithType:UIButtonTypeCustom];
        showMore.frame = CGRectMake(26.0, 320, 98.0f, 32.0f);
        
        
        [showMore setTitle:@"+ show more" forState:UIControlStateNormal];
        [showMore setTitleColor:[UIColor colorWithRed:94.0f/255.0f green:94.0f/255.0f blue:94.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        showMore.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [carouselView addSubview:showMore];
        
        // Inivisible shadow show more button
        UIButton *shadowMore = [UIButton buttonWithType:UIButtonTypeCustom];
        shadowMore.frame = CGRectMake(65.0, 357.0, 98.0f, 32.0f);
        
        [shadowMore addTarget:self
                       action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:shadowMore];

        
        // Show plus button
       // UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(250.0, 327, 20.0f, 20.0f)];
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(247.0, 323, 25.0f, 25.0f)];
        [addButton addTarget:self
                      action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        
        
        [addButton setImage:([UIImage imageNamed:@"add_icon.png"]) forState:UIControlStateNormal];
        [addButton setTitle:@"" forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont systemFontOfSize:16];
        addButton.userInteractionEnabled = YES;
        [carouselView addSubview:addButton];
        
        // Inivisible shadow plus button
        UIButton *shadowPlus = [UIButton buttonWithType:UIButtonTypeCustom];
//        shadowPlus.frame = CGRectMake(273.0, 378.0, 20.0f, 20.0f);
        shadowPlus.frame = CGRectMake(270.0, 374.0, 25.0f, 25.0f);
    //    shadowPlus.backgroundColor = [UIColor redColor];
        [shadowPlus addTarget:self
                       action:@selector(addFactoid:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:shadowPlus];
        
        
        // share button
        UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(285.0, 320, 18.0f, 26.0f)];
       // UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(285.0, 327, 20.0f, 18.0f)];
        [shareButton addTarget:self
                        action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [shareButton setImage:([UIImage imageNamed:@"upload1.png"]) forState:UIControlStateNormal];
       // [shareButton setImage:([UIImage imageNamed:@"share_icon.png"]) forState:UIControlStateNormal];
        [shareButton setTitle:@"" forState:UIControlStateNormal];
        shareButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [shareButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        shareButton.userInteractionEnabled = YES;
        [carouselView addSubview:shareButton];
        
        // Inivisible share plus button
        UIButton *shadowShare = [UIButton buttonWithType:UIButtonTypeCustom];
       // shadowShare.backgroundColor = [UIColor redColor];
       // shadowShare.frame = CGRectMake(308.0, 378.0, 20.0f, 18.0f);
        shadowShare.frame = CGRectMake(308.0, 371.0, 20.0f, 26.0f);
        [shadowShare addTarget:self
                       action:@selector(shareContent:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:shadowShare];
        
    } else {
        //get a reference to the label in the recycled view
        label = (UILabel *)[carouselView viewWithTag:1];
    }
    
//    set item label
//    remember to always set any properties of your carousel item
//    views outside of the `if (view == nil) {...}` check otherwise
//    you'll get weird issues with carousel item content appearing
//    in the wrong place in the carousel
#pragma mark this2
    self.currentFactoid = [self.currentDB objectAtIndex:[[self.items objectAtIndex:index] intValue]];
    label.text = [self.currentFactoid.texts objectForKey:@"short"];
    topic.text = self.currentFactoid.tags;
    
    return carouselView;
}

- (void)buttonPressed:(id)sender {
//    NSLog(@"I worked yay");
    UIView *current = self.carousel.currentItemView;
    NSInteger *index = [self.carousel indexOfItemView:(current)];
    self.sendMeIndex = (int)index;
//    NSLog(@" %tu", index);
    
    [self performSegueWithIdentifier:@"showMoreSegue" sender:self];
    
    
}


-(void ) shareContent:(id)sender {
    UIView *current = self.carousel.currentItemView;
    NSInteger *index = [self.carousel indexOfItemView:(current)];
    singleFactoid *toSave = [[singleFactoid alloc] init];
    
    
    toSave = _seattleFactoids[(int)index];
    
    NSDictionary *texts = toSave.texts;
    
    NSString *message = [texts objectForKey:@"long"];
    NSArray * shareItems = @[message];
    //    NSArray * shareItems = @[message, image];
    
    UIActivityViewController * avc = [[UIActivityViewController alloc]  initWithActivityItems:shareItems applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}


-(void ) addFactoid:(id)sender {
    UIView *current = self.carousel.currentItemView;
    
    NSInteger *index = [self.carousel indexOfItemView:(current)];
    self.sendMeIndex = index;
    NSLog(@" %tu", index);
    singleFactoid *toSave = [[singleFactoid alloc] init];
    NSString *currentSavedLocation = [[NSUserDefaults standardUserDefaults]
                                      stringForKey:@"location"];
    if ([currentSavedLocation isEqualToString:@"Seattle"]) {
        toSave = _seattleFactoids[(int)index];
    } else {
        toSave = _houstonFactoids[(int)index];
    }
//    UIAlertController *alert=   [UIAlertController
//                                 alertControllerWithTitle:@"Fact Saved!"
//                                 message:@"\nFact has been added to your profile!\n"
//                                 preferredStyle:UIAlertControllerStyleAlert];
//
//    [self presentViewController:alert animated:YES completion:nil];
//
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [alert dismissViewControllerAnimated:YES completion:^{
//
//            //Dismissed
//        }];
//
//    });
//
    
    
    UITextView *textAboutUs = [[UITextView alloc] initWithFrame:CGRectMake(15, 35, 250, 100)];
    textAboutUs.backgroundColor = [UIColor clearColor];
    textAboutUs.textColor = [UIColor whiteColor];
    textAboutUs.editable = NO;
    textAboutUs.scrollEnabled = YES;
    textAboutUs.font = [UIFont systemFontOfSize:15];

    if ([_savedFactoids containsObject:toSave]) {
        UIAlertController *alert=   [UIAlertController
                                     alertControllerWithTitle:@"Could not save!"
                                     message:@"\nYou already have this factoid saved!\n"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alert dismissViewControllerAnimated:YES completion:^{
                
                //Dismissed
            }];
            
        });
    } else {
        [_savedFactoids addObject:toSave];
        UIAlertController *alert=   [UIAlertController
                                     alertControllerWithTitle:@"Fact Saved!"
                                     message:@"\nFact has been added to your profile!\n"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [alert dismissViewControllerAnimated:YES completion:^{
                
                //Dismissed
            }];
            
        });
        
        
    }
 //   NSLog(@"this is the saved factoid %@", _savedFactoids);
  //  [self performSegueWithIdentifier:@"savedToProfileSegue" sender:self];

}


- (void)dealloc {
//    it's a good idea to set these to nil here to avoid
//    sending messages to a deallocated viewcontroller
    self.carousel.delegate = nil;
    self.carousel.dataSource = nil;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
//    free up memory by releasing subviews
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value {
    switch (option) {
        case iCarouselOptionWrap:
            return YES;
        case iCarouselOptionSpacing:
            //return 1.05; // If the width of your items is 40 e.g, the spacing would be 4 px.
            return 1.02;
            break;
        case iCarouselOptionVisibleItems:
            return self.currentDB.count;
            break;
    }
    return value;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prep for segue");
    ArticlesViewController *factoidVC = segue.destinationViewController;
    factoidVC.sendMeIndex = self.sendMeIndex;
    NSLog(@"SENT BEFORE SEGUE: %tu", self.sendMeIndex);
}
@end
