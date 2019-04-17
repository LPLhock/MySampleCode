# UI卡顿&掉帧原因
 
 ![kjCalT.md.jpg](https://s2.ax1x.com/2019/03/05/kjCalT.md.jpg)
 
## 视图绘制原理

## GPU 与 CPU 分别如何工作

## CPU 工作
* layout
* display
* Prepare
* Commit

## GPU 工作

* 顶点着色: 对位图处理
* 图元装配
* 光栅化
* 片段着色
* 片段处理
* 将其提交到 FrameBuffer

## 缓冲区, 上下文, 位图, 分别又是什么。

## 为什么会卡顿和掉帧

当每 16.7 MS 如果一帧画面绘制不出来的话, 则出现 FPS 过低的情况, 有可能是 CPU 或者在 GPU 工作效率过慢导致。

## 如何有效避免

## 滑动优化方案

针对 UITableView 与 UICollectionView

## 基于 CPU 优化

* 对象创建, 调整, 销毁
* 预排版 (布局计算, 文本计算)
* 预渲染 (文本等异步绘制, 图片编解码等)

## 基于 GPU 优化

* 纹理渲染, 避免离屏渲染。
* 减少视图混合, 减轻 GPU 压力

## Code 上如何进行




