//
//  Global.m
//  climateConvos
//
//  Created by Sandra Le on 5/4/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "Global.h"
static Global *sharedFactoids;// = nil;
@implementation Global

@synthesize factoids;

+(Global*)sharedFactoids
{
    if ( !sharedFactoids)
    {
        sharedFactoids = [[Global alloc] init];
        
    }
    return sharedFactoids;
}


- (id)init
{
    self = [super init];
    if (self)
    {
        factoids = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
