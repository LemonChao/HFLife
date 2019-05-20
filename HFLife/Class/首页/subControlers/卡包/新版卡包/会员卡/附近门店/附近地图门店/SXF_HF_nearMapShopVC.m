//
//  SXF_HF_nearMapShopVC.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_nearMapShopVC.h"

@interface SXF_HF_nearMapShopVC ()
@property (nonatomic, strong) MAMapView*locationMap;
@end

@implementation SXF_HF_nearMapShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"附近门店";
    
    [self setUpUI];
}

- (void)setUpUI{
    self.locationMap = [[MAMapView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight - HJBottomHeight)];
    
    self.locationMap.userTrackingMode = MAUserTrackingModeFollow;
    
    
    [self.view addSubview:self.locationMap];
}





@end
