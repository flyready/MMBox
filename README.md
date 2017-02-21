# MMBox
一款类似网页中盒子的控件  只需将MMComBoxView提取到工程中 再按照自己项目中需求设置数据即可~初始化方法如下所示
MMComBoxView *box = [[MMComBoxView alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    box.backgroundColor = [UIColor whiteColor];
    box.arrowImgName = @"down_dark";
    box.titlesList = [NSMutableArray arrayWithArray:AllProNamelist];
    box.delegate = self;
    box.supView = self.view;
    [box defaultSettings];
    [self.view addSubview:box];
    
    /**
     *如果地址是网络请求 
     将请求回来的数组赋值给box的titlesList;
     刷新box
     [box reloadData]
     *
     */
