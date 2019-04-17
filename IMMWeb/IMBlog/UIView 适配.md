# UIView 适配


## UIView 根据子View 子适应高度

UIView 包含两个子View, 上面子 View 需要根据 Label 自适应高度, 下面View 需要根据 控件数量改变高度,  最后 父View 需要自适应子 View

019-01-16 10:46:24.000544+0800 YZHYolo[12079:2090008] [LayoutConstraints] Unable to simultaneously satisfy constraints.
	Probably at least one of the constraints in the following list is one you don't want. 
	Try this: 
		(1) look at each constraint and try to figure out which you don't expect; 
		(2) find the code that added the unwanted constraint or constraints and fix it. 
7 (
	<NSLayoutConstraint:0x283a1cfa0 UILabel:0x1068d1440.top == UIView:0x1068f3d60.top + 19>,
	<NSLayoutConstraint:0x283a1cbe0 UIView:0x1068f3d60.bottom == UILabel:0x1068f26c0.bottom + 4.5>,
	<NSLayoutConstraint:0x283a1d4a0 UILabel:0x1068f26c0.top == UILabel:0x1068d1440.bottom + 2.5>,
	<NSLayoutConstraint:0x283a1d630 UIView:0x1068f3d60.top == YZHTeamCardHeaderView:0x1068f8890.top>,
	<NSLayoutConstraint:0x283a1d310 YZHLabelShowView:0x1068f2260.top == UIView:0x1068f3d60.bottom>,
	<NSLayoutConstraint:0x283a1d3b0 YZHTeamCardHeaderView:0x1068f8890.bottom == YZHLabelShowView:0x1068f2260.bottom>,
	<NSLayoutConstraint:0x283a6bf70 YZHTeamCardHeaderView:0x1068f8890.height == 0>,
)

##  Setting the background color on UITableViewHeaderFooterView has been deprecated. Please set a custom UIView with your desired background color to the backgroundView property instead.


## 约束警告 width is ambiguous for uilabel


## widht and horizontal position are ambigrous for Label



## 线程安全

Main Thread Checker: UI API called on a background thread: -[UISearchBar methodSignatureForSelector:]
PID: 12223, TID: 2115293, Thread name: (none), Queue name: com.apple.Foundation.NSItemProvider-callback-queue, QoS: 0
Backtrace:
4   YZHYolo                             0x0000000104503d44 -[A2DynamicDelegate methodSignatureForSelector:] + 244
5   CoreFoundation                      0x0000000206756344 <redacted> + 236
6   CoreFoundation                      0x000000020675848c _CF_forwarding_prep_0 + 92
7   Foundation                          0x0000000207158b14 <redacted> + 60
8   UIKitCore                           0x0000000233296bd4 <redacted> + 84
9   UIKitCore                           0x0000000233d29ae0 <redacted> + 80
10  CoreFoundation                      0x00000002067562f8 <redacted> + 160
11  CoreFoundation                      0x000000020675848c _CF_forwarding_prep_0 + 92
12  UIKitCore                           0x0000000233d14d00 <redacted> + 300
13  UIKitCore                           0x0000000233d13fc0 <redacted> + 388
14  UIKitCore                           0x0000000233d15eb0 <redacted> + 468
15  UIKitCore                           0x0000000233d15c64 <redacted> + 420
16  UIKitCore                           0x0000000233d159d4 <redacted> + 260
17  UIKitCore                           0x0000000233d160c0 <redacted> + 168
18  UIKitCore                           0x0000000233d16428 <redacted> + 260
19  UIKitCore                           0x0000000233d164f8 <redacted> + 72
20  Foundation                          0x0000000207210e00 <redacted> + 144
21  libdispatch.dylib                   0x00000001052ef824 _dispatch_call_block_and_release + 24
22  libdispatch.dylib                   0x00000001052f0dc8 _dispatch_client_callout + 16
23  libdispatch.dylib                   0x00000001052f8e6c _dispatch_lane_serial_drain + 720
24  libdispatch.dylib                   0x00000001052f9b60 _dispatch_lane_invoke + 460
25  libdispatch.dylib                   0x0000000105303bfc _dispatch_workloop_worker_thread + 1220
26  libsystem_pthread.dylib             0x000000020636d0dc _pthread_wqthread + 312
27  libsystem_pthread.dylib             0x000000020636fcec start_wqthread + 4
2019-01-16 12:01:37.687035+0800 YZHYolo[12223:2115293] [reports] Main Thread Checker: UI API called on a background thread: -[UISearchBar methodSignatureForSelector:]
PID: 12223, TID: 2115293, Thread name: (none), Queue name: com.apple.Foundation.NSItemProvider-callback-queue, QoS: 0
Backtrace:
4   YZHYolo                             0x0000000104503d44 -[A2DynamicDelegate methodSignatureForSelector:] + 244
5   CoreFoundation                      0x0000000206756344 <redacted> + 236
6   CoreFoundation                      0x000000020675848c _CF_forwarding_prep_0 + 92
7   Foundation                          0x0000000207158b14 <redacted> + 60
8   UIKitCore                           0x0000000233296bd4 <redacted> + 84
9   UIKitCore                           0x0000000233d29ae0 <redacted> + 80
10  CoreFoundation                      0x00000002067562f8 <redacted> + 160
11  CoreFoundation                      0x000000020675848c _CF_forwarding_prep_0 + 92
12  UIKitCore                           0x0000000233d14d00 <redacted> + 300
13  UIKitCore                           0x0000000233d13fc0 <redacted> + 388
14  UIKitCore                           0x0000000233d15eb0 <redacted> + 468
15  UIKitCore                           0x0000000233d15c64 <redacted> + 420
16  UIKitCore                           0x0000000233d159d4 <redacted> + 260
17  UIKitCore                           0x0000000233d160c0 <redacted> + 168
18  UIKitCore                           0x0000000233d16428 <redacted> + 260
19  UIKitCore                           0x0000000233d164f8 <redacted> + 72
20  Foundation                          0x0000000207210e00 <redacted> + 144
21  libdispatch.dylib                   0x00000001052ef824 _dispatch_call_block_and_release + 24
22  libdispatch.dylib                   0x00000001052f0dc8 _dispatch_client_callout + 16
23  libdispatch.dylib                   0x00000001052f8e6c _dispatch_lane_serial_drain + 720
24  libdispatch.dylib                   0x00000001052f9b60 _dispatch_lane_invoke + 460
25  libdispatch.dylib                   0x0000000105303bfc _dispatch_workloop_worker_thread + 1220
26  libsystem_pthread.dylib             0x000000020636d0dc _pthread_wqthread + 312
27  libsystem_pthread.dylib             0x000000020636fcec start_wqthread + 4
=================================================================
Main Thread Checker: UI API called on a background thread: -[UISearchBar respondsToSelector:]
PID: 12223, TID: 2115293, Thread name: (none), Queue name: com.apple.Foundation.NSItemProvider-callback-queue, QoS: 0
Backtrace:
4   YZHYolo                             0x0000000104504064 -[A2DynamicDelegate forwardInvocation:] + 276
5   Foundation                          0x0000000207158b34 <redacted> + 92
6   UIKitCore                           0x0000000233296bd4 <redacted> + 84
7   UIKitCore                           0x0000000233d29ae0 <redacted> + 80
8   CoreFoundation                      0x00000002067562f8 <redacted> + 160
9   CoreFoundation                      0x000000020675848c _CF_forwarding_prep_0 + 92
10  UIKitCore                           0x0000000233d14d00 <redacted> + 300
11  UIKitCore                           0x0000000233d13fc0 <redacted> + 388
12  UIKitCore                           0x0000000233d15eb0 <redacted> + 468
13  UIKitCore                           0x0000000233d15c64 <redacted> + 420
14  UIKitCore                           0x0000000233d159d4 <redacted> + 260
15  UIKitCore                           0x0000000233d160c0 <redacted> + 168
16  UIKitCore                           0x0000000233d16428 <redacted> + 260
17  UIKitCore                           0x0000000233d164f8 <redacted> + 72
18  Foundation                          0x0000000207210e00 <redacted> + 144
19  libdispatch.dylib                   0x00000001052ef824 _dispatch_call_block_and_release + 24
20  libdispatch.dylib                   0x00000001052f0dc8 _dispatch_client_callout + 16
21  libdispatch.dylib                   0x00000001052f8e6c _dispatch_lane_serial_drain + 720
22  libdispatch.dylib                   0x00000001052f9b60 _dispatch_lane_invoke + 460
23  libdispatch.dylib                   0x0000000105303bfc _dispatch_workloop_worker_thread + 1220
24  libsystem_pthread.dylib             0x000000020636d0dc _pthread_wqthread + 312
25  libsystem_pthread.dylib             0x000000020636fcec start_wqthread + 4
2019-01-16 12:01:38.060909+0800 YZHYolo[12223:2115293] [reports] Main Thread Checker: UI API called on a background thread: -[UISearchBar respondsToSelector:]
PID: 12223, TID: 2115293, Thread name: (none), Queue name: com.apple.Foundation.NSItemProvider-callback-queue, QoS: 0
Backtrace:
4   YZHYolo                             0x0000000104504064 -[A2DynamicDelegate forwardInvocation:] + 276
5   Foundation                          0x0000000207158b34 <redacted> + 92
6   UIKitCore                           0x0000000233296bd4 <redacted> + 84
7   UIKitCore                           0x0000000233d29ae0 <redacted> + 80
8   CoreFoundation                      0x00000002067562f8 <redacted> + 160
9   CoreFoundation                      0x000000020675848c _CF_forwarding_prep_0 + 92
10  UIKitCore                           0x0000000233d14d00 <redacted> + 300
11  UIKitCore                           0x0000000233d13fc0 <redacted> + 388
12  UIKitCore                           0x0000000233d15eb0 <redacted> + 468
13  UIKitCore                           0x0000000233d15c64 <redacted> + 420
14  UIKitCore                           0x0000000233d159d4 <redacted> + 260
15  UIKitCore                           0x0000000233d160c0 <redacted> + 168
16  UIKitCore                           0x0000000233d16428 <redacted> + 260
17  UIKitCore                           0x0000000233d164f8 <redacted> + 72
18  Foundation                          0x0000000207210e00 <redacted> + 144
19  libdispatch.dylib                   0x00000001052ef824 _dispatch_call_block_and_release + 24
20  libdispatch.dylib                   0x00000001052f0dc8 _dispatch_client_callout + 16
21  libdispatch.dylib                   0x00000001052f8e6c _dispatch_lane_serial_drain + 720
22  libdispatch.dylib                   0x00000001052f9b60 _dispatch_lane_invoke + 460
23  libdispatch.dylib                   0x0000000105303bfc _dispatch_workloop_worker_thread + 1220
24  libsystem_pthread.dylib             0x000000020636d0dc _pthread_wqthread + 312
25  libsystem_pthread.dylib             0x000000020636fcec start_wqthread + 4

