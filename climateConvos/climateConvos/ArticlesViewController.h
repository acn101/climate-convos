//
//  ArticlesViewController.h
//  climateConvos
//
//  Created by Sandra Le on 4/15/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
#import "iCarousel.h"

@interface ArticlesViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (strong, nonatomic) NSString *selectedCategory;

@end
