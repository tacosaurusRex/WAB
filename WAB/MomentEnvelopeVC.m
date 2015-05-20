//
//  MomentEnvelopeVC.m
//  WAB
//
//  Created by Robert Mahoney on 5/15/15.
//  Copyright (c) 2015 Robert Mahoney. All rights reserved.
//

#import "MomentEnvelopeVC.h"
#import "WeightsVC.h"

@interface MomentEnvelopeVC ()

@end

@implementation MomentEnvelopeVC

@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    //float fuelWeight = data.fuelWeight;
    NSLog(@"fuel weight in MomentEnvelopeVC is %f", data.fuelWeight);
    
    
    
    //((MomentEnvelopeView*)self.view).theNum = (NSInteger)5;
    
    //self.
    
    //float weight = inputData.fuelWeight;
    //NSLog(@"fuel weight is %f", weight);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _selfHeight = self.view.bounds.size.height;
    _selfWidth = self.view.bounds.size.width;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
