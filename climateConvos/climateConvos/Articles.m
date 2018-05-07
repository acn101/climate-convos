//
//  Articles.m
//  climateConvos
//
//  Created by acn96 on 5/7/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "Articles.h"

@implementation Articles

- (NSString *) description {
    return [NSString stringWithFormat:@"Number: %@\nLocation: %@\nName: %@\nSources: %@\nTags: %@", self.number, self.location, self.name, self.sources, self.tags];
}

@end
