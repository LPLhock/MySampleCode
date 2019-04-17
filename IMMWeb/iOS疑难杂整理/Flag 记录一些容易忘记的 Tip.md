# Flag 记录一些容易忘记的 Tip

self.navigationBar.translucent = NO; // 设置导航栏透明度 为 NO 之后, 默认会对所有显示导航栏情况下使当前 VC 下移 64 pt. 否则 y 为 0. 

2. UITableViewStyleGrouped 分区头, 滚动的时候不会悬浮, UITableViewStylePlain 会悬停. 
3. 约束时需要及时主要考虑 小屏,系统兼容问题等.
4.     // TODO:低版本出现约束冲突.
    YZHWelcomeView* welcomeView = [YZHWelcomeView yzh_viewWithFrame:self.view.bounds];
    [welcomeView.bannerView layoutIfNeeded];
5. navgationController.navigationBar.translucent = NO;    @property(nonatomic,assign,getter=isTranslucent) BOOL translucent NS_AVAILABLE_IOS(3_0) UI_APPEARANCE_SELECTOR; // Default is NO on iOS 6 and earlier. Always YES if barStyle is set to UIBarStyleBlackTranslucent 
其透明会导致严重的离屏渲染.
透明时, View 的 Frame 不会受其影响 下移 64 像素, 如果不透明时 View 会自动下移 64像素. 
6. Frameworks -> foundation -> NSObjectRuntime.h 里面有定义当前系统的宏 
7. CGRect frame = [tableView rectForSection:indexPath.section]; 
[tableView setContentOffset:CGPointMake(0, frame.origin.y) animated:NO];  
- (NSUInteger)sectionOfTableViewDidScroll:(UITableView *)tableView 
- (void)tableView:(UITableView *)tableView didSelectIndexViewAtSection:(NSUInteger)section
tableView 滚动行数等等。
8.RetryPolicy:
 Request failed with fatal error: Request failed: unacceptable content-type: text/plain - Will not try again!
2018-10-11 15:46:04.624396+0800 
YZHYolo[85674:5585782] RetryPolicy: Request failed with fatal error: Request failed: unacceptable content-type: text/plain - Will not try again!
2018-10-11 15:46:04.625321+0800 YZHYolo[85674:5585782] 
 POST error: Error Domain=com.alamofire.error.serialization.response Code=-1016 
 "Request failed: unacceptable content-type: text/plain" UserInfo={NSLocalizedDescription=Request failed: unacceptable content-type: text/plain, NSErrorFailingURLKey=http://192.168.1.190:8084/user/login, com.alamofire.serialization.response.error.data=<7b0a2020
 // 数据序列化处理
        httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];


