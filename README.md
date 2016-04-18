# iOS_develop_notes
## 分析:
创建容器 reusedViewControllers 来存放可以重用的 视图
创建容器 visibleViewControllers 来存放屏幕中显示的 视图
###scrollView 出现的时候,
首先需要在屏幕中显示一张完整的视图,此刻 做两件事
> 1.将视图 1 添加到 scrollView
> 2.将视图 1 添加到visibleViewControllers进行保存

###一个视图->二个视图

 如果向左滑动,会出现 两个视图 的情况, 视图2 也需要加入显示.当开始滑动的那一刻,做三件事情.
 >1. 在 (存放重用的 VC )reusedViewControllers中查找可重用的 VC, 如果没有找到就创建一个,存在得到的就是视图2 .

>2.将视图2 添加到(可见的)visibleViewControllers中进行保存,如果视图2 是在reusedViewControllers中找到的(不是创建的),那么需要将视图2从reusedViewControllers中移除,相当于将视图2从reusedViewControllers移动到了visibleViewControllers.
>3.将视图2添加到 scrollView 中进行个性设置

###二个视图-->一个视图
如果继续左滑动，直到视图1看不见的那一刻，也做三件事情
> 1.讲视图1从 scrollView 中移除removeFromSuperview
> 2.讲视图1放进reusedViewControllers 中 等待被重用
> 3.将视图1中visibleViewControllers中移除 ,因为它已经属于 reusedViewControllers中了
