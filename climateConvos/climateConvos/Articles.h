//
//  Articles.h
//  climateConvos
//
//  Created by acn96 on 5/7/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Articles : NSObject

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDictionary *sources;
@property (strong, nonatomic) NSString *tags;

@end
