# 初始化 Label UIButton 控件时

初始化这些控件时, 如何设置其宽高, 能让其自适应内容

UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 2, SCREEN_WIDTH-30, 35)];

好像都是直接写死.

或者通过计算字体长度高度等方式在放进去,但是感觉这样做法太不合理了, 每次都要去算一次.


```

   YMExpeTicketIncomeCellHeader *header = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YMExpeTicketIncomeCellHeader class]) owner:nil options:nil] lastObject];
    header.monthLabel.text = self.viewModel.headerIncomes[section].month;
    
    UIView *view = [[UIView alloc] initWithFrame:header.bounds];
    [view addSubview:header];
    
    NSString *vfl0 = @"H:|-0-[header]-0-|";
    NSString *vfl1 = @"V:|-0-[header]-0-|";
    NSDictionary *views = NSDictionaryOfVariableBindings(header);
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl0 options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl1 options:0 metrics:nil views:views]];
```



