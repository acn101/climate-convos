//
//  ButtonHandler.m
//  climateConvos
//
//  Created by Senglong on 4/10/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import "ButtonHandler.h"

@implementation ButtonHandler




-(IBAction)segmentChnage:(id)sender){
    
    self.segmentControl = sender;
    
    switch(self.segmentControl.selectedSegmentIndex){
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"topicButtonPressed" object:self];
            break;
        case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"educationButtonPressed" object:self];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getActiveButtonPressed" object:self];
            break;
        default:
            break;
            
            
    }
}


@end
