//
//  singleFactoid.m
//  climateConvos
//
//  Created by acn96 on 3/26/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "singleFactoid.h"

@implementation singleFactoid

- (NSString *) description {
    return [NSString stringWithFormat:@"text %@ | tags:%@ | tags:%@ | location:%@ | text:%@", self.number, self.sources, self.tags, self.location, self.texts];
}
@end
