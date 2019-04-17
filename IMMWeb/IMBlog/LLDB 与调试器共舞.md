#LLDB 与调试器共舞
  
## 基础

help
print  可使用缩写 pri prin p  pr不行 因为与process 的歧义 (幸运的是 p 并没有歧义)。 
打印结果是 $0  = 10； 
$0代表的是 要打印的 所以 我们可以使用 p $0 + 10 去进行一个相加的效果。   
任何以美元符开头的东西都是存在于 LLDB 的命名空间的，它们是为了帮助你进行调试而存在的。

expression
当我们想改变一个值的时候  可以使用其  来做。
expression  count = 40 
注意，从现在开始，我们将会偷懒分别以 p 和 e 来代替 print 和 expression。

实际上 p  是 e — 的 简写。    e —代表的是 来表征标识的结束，   e — h +17 意思就是 求 h+17  
e -h — +17  则是  -h  + 17之后结果
输入 help print，然后向下滚动，你会发现：
'print' is an abbreviation for 'expression --'.   
(print是 `expression --` 的缩写) 

幸运的是，e -o -- 有也有个别名，那就是 po (print object 的缩写)，我们可以使用它来进行简化： PO 实际上 是  e -o — 组成的。
-o 表示的意思 是 object  让其一实际上，我们想看的是对象的 description 方法的结果。我么需要使用 -O (字母 O，而不是数字 0) 标志告诉 expression 命令以 对象 (Object) 的方式来打印结果。
打印变量
可以给 print 指定不同的打印格式。它们都是以 print/<fmt> 或者简化的 p/<fmt> 格式书写。下面是一些
十六进制:
(lldb) p/x 16
0x10
二进制 (t 代表 two)：
(lldb) p/t 16 
0b00000000000000000000000000010000
(lldb) p/t (char)16
0b00010000

## 变量
(lldb) e int $a = 2 
(lldb) p $a * 19 
38
(lldb) e NSArray *$array = @[ @"Saturday", @"Sunday", @"Monday" ] 
(lldb) p [$array count]
2
(lldb) po [[$array objectAtIndex:0] uppercaseString] 
SATURDAY
(lldb) p [[$array objectAtIndex:$a] characterAtIndex:0] 
error: no known method '-characterAtIndex:'; cast the message send to the method's return type 
error: 1 errors parsing expression
悲剧了，LLDB 无法确定涉及的类型 (译者注：返回的类型)。这种事情常常发生，给个说明就好了：
(lldb) p (char)[[$array objectAtIndex:$a] characterAtIndex:0] 
'M'
(lldb) p/d (char)[[$array objectAtIndex:$a] characterAtIndex:0] 
77、

## 流程控制
从左到右，四个按钮分别是：continue，step over，step into，step out。
第一个，continue 按钮，会取消程序的暂停，允许程序正常执行 (要么一直执行下去，要么到达下一个断点)。在 LLDB 中，你可以使用 process continue 命令来达到同样的效果，它的别名为 continue，或者也可以缩写为 c。
第二个，step over 按钮，会以黑盒的方式执行一行代码。如果所在这行代码是一个函数调用，那么就不会跳进这个函数，而是会执行这个函数，然后继续。LLDB 则可以使用 thread step-over，next，或者 n 命令。
如果你确实想跳进一个函数调用来调试或者检查程序的执行情况，那就用第三个按钮，step in，或者在LLDB中使用 thread step in，step，或者 s 命令。注意，当前行不是函数调用时，next 和 step 效果是一样的。
大多数人知道 c，n 和 s，但是其实还有第四个按钮，step out。如果你曾经不小心跳进一个函数，但实际上你想跳过它，常见的反应是重复的运行 n 直到函数返回。其实这种情况，step out 按钮是你的救世主。它会继续执行到下一个返回语句 (直到一个堆栈帧结束) 然后再次停止。

 c 表示执行 continue n 表示step over  s表示 step into  finish 表示 step out、 frame info 可以查看当前执行到哪行代码 。

Thread Return
thread return NO 
 伪造返回值、    在执行一个函数线程的时候、  比如 在将执行此函数过程中 ， 我们可以使用 s 进入 此函数，    进入之后，  我们可以 执行  thread return 制造一个假的返回值。   但是此方法会影响到 ARC 

## 创建断点
 直接使用命令 创建 添加断点 。
(lldb) breakpoint set -f main.m -l 16 
也可以使用缩写形式 br。虽然 b 是一个完全不同的命令 (_regexp-break 的缩写)，但恰好也可以实现和上面同样的效果。
(lldb) b main.m:17
也可以在一个符号 (C 语言函数) 上创建断点，而完全不用指定哪一行
(lldb) b isEven
Breakpoint 3: where = DebuggerDance`isEven + 16 at main.m:4, address = 0x000000010a3f6d00 
(lldb) br s -F isEven 
Breakpoint 4: where = DebuggerDance`isEven + 16 at main.m:4, address = 0x000000010a3f6d00 
这些断点会准确的停止在函数的开始。Objective-C 的方法也完全可以：

创建全部方法断点， 包括系统执行的
点击+ 选择 symbolic Breakpoint 然后在条件框的 symbol 里面讲方法 填入即可
-[NSArray objectAtIndex:]

还有一种 编辑 断点的方式 。  在我们已经添加的断点中 邮件 选择 edit breakpoint..即在弹框中 Condition : 中的框框，我们可以填写条件 。   意思是 当 条件成立的时候  才会执行此断点 否则会跳过此断点！。这里，断点已经被修改为只有当 i 是 99 的时候才会停止。你也可以使用 "ignore" 选项来告诉断点最初的 n次调用 (并且条件为真的时候) 的时候不要停止。

## 断点行为 (Action)
 在 Action 框中 可选择 想要执行的类型、 然后输入相关 语句则会在断点执行的时候 会执行这些行为。
查找按钮的 target
想象你在调试器中有一个 $myButton 的变量，可以是创建出来的，也可以是从 UI 上抓取出来的，或者是你停止在断点时的一个局部变量。你想知道，按钮按下的时候谁会接收到按钮发出的 action。非常简单：
(lldb) po [$myButton allTargets] 
{(
    <MagicEventListener: 0x7fb58bd2e240>
)}
(lldb) po [$myButton actionsForTarget:(id)0x7fb58bd2e240 forControlEvent:0] 
<__NSArrayM 0x7fb58bd2aa40>(
_handleTap:
)


## 参考资料
 [OBJC](https://www.objccn.io/issue-19-2/)
 [Facebook 开源工具chisel](https://github.com/facebook/chisel#installation)

