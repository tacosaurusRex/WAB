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
    //MomentEnvelopeView *graphView;
}


@property (nonatomic, retain) WeightsVC *data;
//@property (nonatomic, weak) MomentEnvelopeView *graphView;

@property CGFloat selfHeight;

@property CGFloat selfWidth;

- (void) setData:(NSString **)buffer range:(NSRange)inRange;


@end

