# Git 冲突解决

    self.sharedFunctionView.firendSharedBlock = ^(UIButton *sender) {
<<<<<<< Updated upstream
        [YZHAlertManage showAlertMessage:@"暂不支持分享功能"];
    };
    self.sharedFunctionView.teamSharedBlock = ^(UIButton *sender) {
        [YZHAlertManage showAlertMessage:@"暂不支持分享功能"];
=======
        [YZHRouter openURL:kYZHRouterSessionSharedCard info:@{
                                                              @"sharedType": @(1),
                                                              kYZHRouteSegue: kYZHRouteSegueModal,
                                                              kYZHRouteSegueNewNavigation: @(YES),
                                                              }];
    };
    self.sharedFunctionView.teamSharedBlock = ^(UIButton *sender) {
        [YZHRouter openURL:kYZHRouterSessionSharedCard info:@{
                                                              @"sharedType": @(2),
                                                              kYZHRouteSegue: kYZHRouteSegueModal,
                                                              kYZHRouteSegueNewNavigation: @(YES),
                                                              }];
>>>>>>> Stashed changes
    };

