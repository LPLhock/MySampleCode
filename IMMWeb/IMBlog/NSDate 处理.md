# NSDate 处理

## 获取当前时间戳

```
 NSDate *newDate = [NSDate date];
    long int timeSp = (long)[newDate timeIntervalSince1970];
    NSString *tempTime = [NSString stringWithFormat:@"%ld",timeSp];
    return tempTime;

```

## CGFload 时间戳转 NSString

```
        NSDate* timeDate = [NSDate dateWithTimeIntervalSince1970:notification.timestamp];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm"];
        NSString* strTime = [dateFormatter stringFromDate:timeDate];
        NSLog(@"%@", strTime);
```

## NSString 转 时间戳



## NSDate 转 NSDateComponents

```

        NSDate* timeDate = [NSDate dateWithTimeIntervalSince1970:notification.timestamp];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString* strTime = [dateFormatter stringFromDate:timeDate];
        NSDateComponents *components = [dateFormatter.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:timeDate];
        
        NSDate* currentDate = [NSDate date];
        NSDateComponents *currentComponents = [dateFormatter.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
        NSInteger currentbillYear = [currentComponents year];
        NSInteger currentbillMonth = [currentComponents month];
        
        
        NSInteger billYear = [components year];
        NSInteger billMonth = [components month];

```



