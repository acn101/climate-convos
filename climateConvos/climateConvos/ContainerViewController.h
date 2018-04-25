//
//  ContainerViewController.h
//  climateConvos
//
//  Created by Senglong on 4/9/18.
//  Copyright © 2018 acn96. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerViewController : UIViewController


-(void)segueIdentifierReceivedFromParent:(NSString*)button;
@property NSString *segueIdentifier;
@property (nonatomic,assign) UIViewController* vc;


@end
