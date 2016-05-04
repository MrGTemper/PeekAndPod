# PeekAndPod
iPhone6s/iPhone6s plus  peek和pod的实现

简单的实现iPhone6s/iPhone6s plus应用内的3DTouch 功能

1. 简述Peek和Pod：

苹果公司在推出iPhone6s/iPhone6s plus的硬件基础上，提供的一种新的交互方式，

简单的说就是iPhone设备根据用户不同的按压力度展示的不同的效果

当然用户同样可以选择轻触屏幕达到普通效果，在用户稍微用力按压屏幕的时候，展示的是Peek功能的效果，

同时在peek的界面下手势上滑，将出现UIActionSheet的功能效果，

而再次用力按压，则是Pod功能；

2. 实现步骤如下：

  * 2.1 遵循《UIViewControllerPreviewingDelegate》协议
  
  * 2.2 向ViewController注册3D Touch功能
  ``` Objective-C
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
  ```
  

  * 2.3 实现协议方法，
    
   ``` Objective-C
    //Peek实现
    - (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{ 
    
        //创建或者是传入你要展示的view
        ......
    
    }
  ```
  ``` Objective-C
   //Pod实现
   - (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
        //实现pod要执行的操作
        ......
    }
  ``` 
  
  实现效果：
  
  ![image](https://github.com/MrGTemper/PeekAndPod/blob/master/IMG_0139.jpg)
  ![image](https://github.com/MrGTemper/PeekAndPod/blob/master/IMG_0141.jpg)
    

