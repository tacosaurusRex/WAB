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
#import "UserInput.h"

@interface MomentEnvelopeView : UIView

@property float fuelGal, fuelWeight, fuelMoment;
@property float frontSeatWeight, frontSeatMoment;
@property float rearSeatWeight, rearSeatMoment;
@property float bag1Weight, bag1Moment;
@property float bag2Weight, bag2Moment;
@property float taxiFuelGal, taxiFuelWeight, taxiFuelMoment;
@property float flightFuelGal, flightFuelWeight, flightFuelMoment;
@property float totalMoment, totalWeight, totalARM;

@property float tow; //Take-off Weight
@property float tom; //Take-off Moment
@property float lgw; //Landing Gross Weight
@property float lwm; //Landing Weight Moment
@property float zfw; //Zero Fuel Weight
@property float zfm; //Zero Fuel Moment
@property float bew; //Basic Empty Weight
@property float bem; //Basic Empty Moment


#define mMomentScale 1000
#define mGraphHeight 450
#define mGraphWidth 700
#define mGraphBottom 455
#define mGraphTop 10

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
#define mBottomSpace 30
#define mRightSpace 10
#define mLeftSpace 50

#define mCircleRadius 1.5
#define axisLabelFontSize 8
@end
