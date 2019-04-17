# iOS中事件响应机制与传递机制

iPhone 有很多种事件相应种类, 如摇晃 滑动 点击 长按 3DTouch等等, iOS 系统需要去处理这些不同的事件并作出相应的处理。 

## 事件响应原理

 ![事件相应流程](https://diycode.b0.upaiyun.com/photo/2018/4a30a88500886b784ccf8beb17f803cd.png)

以手指触摸屏幕上 一个 App 为例.
这里先介绍一下一个系统框架  IOKit.framework  是一个专门为系统处理 人机交互事件的框架 IOHID(IO框架前缀表示, Human, Interface, Device) 表示人机交互驱动。

//1. 当通过一个动作触发事件, 首先会将休眠的 cpu 唤醒.
2. 系统接收到触摸事件, 通过 IOKit.framework 将其封装成 IOHIDEvent 对象.
3. 系统通过 mach port (进程通讯端口) 将 IOHIDEvent 对象 转发给 SpringBoard.app   系统的一个跳板App,专门用于处理屏幕上事件。
4. SpringBoard.app 是 iOS 系统桌面 App，它只接收按键、触摸、加速、接近传感器等几种 Event。  它找到可以相应这个事件的 App, 并通过 mach port 将 IOHIDEvent 对象传递到 App内。
5. 前台 App 接收到这个消息之后, 因为是 mach port 其可以直接唤醒  runloop,  通过 Observer 执行 Source1 回调事件。
6.	Source1 回调内部触发了 Source0 回调 __UIApplicationHandleEventQueue()。
7. Source0 回掉内部，将 IOHIDEvent 对象转化为 UIEvent
8. Soucre0 回调内部调用 UIApplication 的 +[sendEvent:] 方法，将 UIEvent 传给UIWindow


##事件传递机制

**UIWindow 的收到的事件，有的是通过响应链传递，找到合适的 view 进行处理的；有的是不用传递，直接用 first responder 来处理的。这里先介绍使用响应链传递的过程，之后再说不通过响应链传递的一些事件。**

**事件传递大致可以分为三个阶段：Hit-Testing（寻找合适的 view）、Recognize Gesture（响应应手势）、Response Chain（touch 事件传递）。通过手去触摸屏幕所产生的事件，都是通过这三步去传递的，例如上文所说的触摸事件和按压事件。**







