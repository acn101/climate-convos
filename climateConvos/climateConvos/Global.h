//
//  Global.h
//  climateConvos
//
//  Created by Sandra Le on 5/4/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Global : NSObject
{
    NSMutableArray *factoids;
}

@property (nonatomic, retain) NSMutableArray *factoids;
+(Global*)sharedFactoids;

@end
