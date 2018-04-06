//
//  singleFactoid.h
//  climateConvos
//
//  Created by acn96 on 3/26/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface singleFactoid : NSObject
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSDictionary *sources;
@property (strong, nonatomic) NSString *tags;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *text;
@end
