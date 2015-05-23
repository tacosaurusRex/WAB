//
//  MomentEnvelopeVC.h
//  WAB
//
//  Created by Robert Mahoney on 5/15/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MomentEnvelopeView.h"

@class WeightsVC;

@interface MomentEnvelopeVC : UIViewController {
    WeightsVC *data;
}

@property (nonatomic, retain) WeightsVC *data;

@property CGFloat selfHeight;

@property CGFloat selfWidth;

@end

