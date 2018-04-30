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

@interface DiscoverViewController ()
@property (weak, nonatomic) IBOutlet UIView *carouselV;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) NSMutableArray *currentDB;

@property (strong, nonatomic) NSArray *getDBInfo;
@property (strong, nonatomic) singleFactoid *currentFactoid;

@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *items;



@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup {
    self.ref = [[FIRDatabase database] reference];
    self.currentDB = [[NSMutableArray alloc] init];
    [self testDB];
    
    // Show more button
    UIButton *showMore = [UIButton buttonWithType:UIButtonTypeCustom];
    showMore.frame = CGRectMake(100.0, 448.0, 98.0f, 32.0f);
    //UIButton *showMore = [[UIButton alloc] initWithFrame:CGRectMake(26.0, 320, 98.0f, 32.0f)];
    [showMore addTarget:self
                 action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
    [showMore setTitle:@"+ show more" forState:UIControlStateNormal];
    [showMore setTitleColor:[UIColor colorWithRed:94.0f/255.0f green:94.0f/255.0f blue:94.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    showMore.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:showMore];
    //  showMore.userInteractionEnabled = YES;
    //  [showMore.superview setUserInteractionEnabled:YES];
    //[carousel bringSubviewToFront:showMore];
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
//    self.carousel.type = iCarouselTypeLinear;
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
//    UIImage * image = [UIImage imageNamed:@"earth"];
    NSArray * shareItems = @[message];
//    NSArray * shareItems = @[message, image];
    
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
    
    //create new view if no view is available for recycling
    if (carouselView == nil) {
    
        // editing the boyd of the carousel
        carouselView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 378.0f)];
        carouselView.contentMode = UIViewContentModeCenter;
//        view.backgroundColor = [UIColor grayColor];
        carouselView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"discover_body.png"]];
//        label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 280.0f, 380.0f)];
        label = [[UILabel alloc] initWithFrame:CGRectMake(25, -50, 250.0f, 380.0f)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:16];
        label.tag = 1;
        label.numberOfLines = 0;
       // [label sizeToFit];
        label.textColor = [UIColor colorWithRed:94.0f/255.0f green:94.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
        [carouselView addSubview:label];
        
        // Topic Label
        UILabel *topic = [[UILabel alloc] initWithFrame:CGRectMake(15, -30, 250.0f, 30.0f)];
       // topic.textAlignment = NSTextAlignmentLeft;
        topic.font = [UIFont boldSystemFontOfSize:22];
        //topic.font = [topic.font fontWithSize:24];
        topic.tag = 1;
        topic.numberOfLines = 0;
        topic.text = self.currentFactoid.tags; // here
        topic.textColor = [UIColor whiteColor];
        [carouselView addSubview:topic];
       
        
        /*
        
        // Show more button
        UIButton *showMore = [UIButton buttonWithType:UIButtonTypeCustom];
        showMore.frame = CGRectMake(26.0, 320, 98.0f, 32.0f);
        //UIButton *showMore = [[UIButton alloc] initWithFrame:CGRectMake(26.0, 320, 98.0f, 32.0f)];
        [showMore addTarget:self
                     action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        [showMore setTitle:@"+ show more" forState:UIControlStateNormal];
        [showMore setTitleColor:[UIColor colorWithRed:94.0f/255.0f green:94.0f/255.0f blue:94.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        showMore.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        showMore.userInteractionEnabled = YES;
        [showMore.superview setUserInteractionEnabled:YES];
        [carouselView addSubview:showMore];
        [carousel bringSubviewToFront:showMore];*/
        
        // Show more button
        UIButton *showMore = [UIButton buttonWithType:UIButtonTypeCustom];
        showMore.frame = CGRectMake(26.0, 320, 98.0f, 32.0f);
        //UIButton *showMore = [[UIButton alloc] initWithFrame:CGRectMake(26.0, 320, 98.0f, 32.0f)];
        [showMore addTarget:self
                     action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        [showMore setTitle:@"+ show more" forState:UIControlStateNormal];
        [showMore setTitleColor:[UIColor colorWithRed:94.0f/255.0f green:94.0f/255.0f blue:94.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        showMore.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [carouselView addSubview:showMore];
        //  showMore.userInteractionEnabled = YES;
        //  [showMore.superview setUserInteractionEnabled:YES];
        //[carousel bringSubviewToFront:showMore];
        
        // Show plus button
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(215.0, 327, 20.0f, 20.0f)];
        [addButton addTarget:self
                      action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        [addButton setImage:([UIImage imageNamed:@"add_icon.png"]) forState:UIControlStateNormal];
        [addButton setTitle:@"" forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont systemFontOfSize:16];
        addButton.userInteractionEnabled = YES;
        [carouselView addSubview:addButton];
        
        // share button
        UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(245.0, 327, 20.0f, 18.0f)];
        [shareButton addTarget:self
                        action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [shareButton setImage:([UIImage imageNamed:@"share_icon.png"]) forState:UIControlStateNormal];
        [shareButton setTitle:@"" forState:UIControlStateNormal];
        shareButton.titleLabel.font = [UIFont systemFontOfSize:16];
        shareButton.userInteractionEnabled = YES;
        [carouselView addSubview:shareButton];
        
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
    
    return carouselView;
}

- (void)buttonPressed:(id)sender {
    NSLog(@"I worked yay");
    
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
            return 1.05; // If the width of your items is 40 e.g, the spacing would be 4 px.
            break;
    }
    return value;
}

@end
