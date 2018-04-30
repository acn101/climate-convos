//
//  Tip.m
//  
//
//  Created by SENG NGOR on 4/30/18.
//

#import "Tip.h"

@implementation Tip

- (NSString *) description {
    return [NSString stringWithFormat:@"number %@ | text %@ | tags:%@", self.number, self.text, self.tags];
}

@end
