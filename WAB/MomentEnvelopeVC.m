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
@property CGFloat selfHeight;
@property CGFloat selfWidth;

@end

@implementation MomentEnvelopeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setNeedsStatusBarAppearanceUpdate]; //white status bar text
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _selfHeight = self.view.bounds.size.height;
    _selfWidth = self.view.bounds.size.width;
    MomentEnvelopeView *graphView = [[MomentEnvelopeView alloc] init];
    graphView.frame = CGRectMake(0, 20, _selfWidth, _selfHeight-(49+20));
    [self.view addSubview: graphView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle //method for white status bar text
{
    return UIStatusBarStyleLightContent;
}

@end