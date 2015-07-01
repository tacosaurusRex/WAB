//
//  AircraftMenuTableViewController.h
//  WAB
//
//  Created by Robert Mahoney on 6/3/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeightsVC.h"
#import "Singleton.h"

@interface AircraftMenuTableViewController : UITableViewController

@property NSArray *acList;
@property NSString *acDescription, *acID;

@property float fuelGal, fuelWeight, fuelMoment;
@property float frontSeatWeight, frontSeatMoment;
@property float rearSeatWeight, rearSeatMoment;
@property float bag1Weight, bag1Moment;
@property float bag2Weight, bag2Moment;
@property float taxiFuelGal, taxiFuelWeight, taxiFuelMoment;
@property float flightFuelGal, flightFuelWeight, flightFuelMoment;
@property float totalMoment, totalWeight, totalARM;

@end
