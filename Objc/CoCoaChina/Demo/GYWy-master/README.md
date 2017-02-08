# GYWy
用icarousel实现网易新闻标题跳转
====================

---------------------

![Alt text](/http://d.pcs.baidu.com/thumbnail/7bf53308420ec8ccd867c593bc00e2c5?fid=2337801595-250528-359482157322355&time=1457402400&rt=sh&sign=FDTAER-DCb740ccc5511e5e8fedcff06b081203-S7s4LoD%2BALoMpe5c8ytBr3Icw5k%3D&expires=2h&chkv=0&chkbd=0&chkpc=&dp-logid=3476837437&dp-callid=0&size=c850_u580&quality=100/to/img.jpg)




> ## GYNewsViewController中给GYNewsCarouselView提供标题数据
> 
> 这里直接用了Plist文件来提供标题的text和urlstring
> 
> 
> ：
> 
>   GYNewsTableView *tv = [[GYNewsTableView alloc]initWithFrame:CGRectMake(0, 0, carousel.width, carousel.height)];
       
        
        tv.title = self.tempListArray[index];
