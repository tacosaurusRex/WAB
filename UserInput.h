//
//  UserInput.h
//  WAB
//
//  Created by Robert Mahoney on 5/22/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInput : NSObject {
    float fuelWeight;
    NSString *someProperty;
}

+(id) sharedInput;

@property (nonatomic, retain) NSString *someProperty;

@property float fuelGal, fuelWeight, fuelMoment;
@property float frontSeatWeight, frontSeatMoment;
@property float rearSeatWeight, rearSeatMoment;
@property float bag1Weight, bag1Moment;
@property float bag2Weight, bag2Moment;
@property float taxiFuelGal, taxiFuelWeight, taxiFuelMoment;
@property float totalMoment, totalWeight, totalARM;

@end
