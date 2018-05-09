//
//  DiscoverViewController.h
//  climateConvos
//
//  Created by Sandra Le on 2/7/18.
//  Copyright © 2018 acn96. All rights reserved.
//

@import Firebase;
#import "iCarousel.h"

#import <UIKit/UIKit.h>

@interface DiscoverViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) NSMutableArray *savedFactoids;

@end
