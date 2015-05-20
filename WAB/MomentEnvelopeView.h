//
//  MomentEnvelopeView.h
//  WAB
//
//  Created by Robert Mahoney on 5/15/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MomentEnvelopeVC.h"
#import "WeightsVC.h"
#import <CoreText/CoreText.h>

@interface MomentEnvelopeView : UIView {
    NSInteger theNum;
}

@property(assign) NSInteger theNum;

#define mGraphHeight 450
#define mGraphWidth 700
#define mGraphBottom 455
#define mGraphTop 10

#define mXScaleFactor 10
#define mXscaleStart 45

#define mOffsetX 10
#define mStepX 50
#define mOffsetY 10
#define mStepY 50

#define mXAxisMin 45
#define mXAxisMax 115
#define mXGridMajor 5
#define mXGridMinor 1
#define mYAxisMin 1500
#define mYAxisMax 2400
#define mYGridMajor 100
#define mYGridMinor 20
#define mTopSpace 10
#define mBottomSpace 10
#define mRightSpace 10
#define mLeftSpace 10


@end
