//
//  UIViewController+swizzling.m
//  opsseeBaby
//
//  Created by zhangzb on 2018/2/28.
//  Copyright © 2018年 Guangzhou Shirui Electronics Co., Ltd. All rights reserved.
//

#import "UIViewController+swizzling.h"
#import <objc/runtime.h>
@implementation UIViewController (swizzling)
+ (void)load {
    #pragma mark ———viewDidLoad方法重写
    // 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
    /**
     *  我们在这里使用class_addMethod()函数对Method Swizzling做了一层验证，如果self没有实现被交换的方法，会导致失败。
     *  而且self没有交换的方法实现，但是父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的结果了。
     *  所以我们在这里通过class_addMethod()的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO，我们就可以对其进行交换了。
     */
    if (!class_addMethod([self class], @selector(swizzlingViewDidLoad), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
    #pragma mark ——— dealloc方法重写
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);
}


// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
- (void)swizzlingViewDidLoad {
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    // 我们在这里加一个判断，将系统的UIViewController的对象剔除掉
    if(![str containsString:@"UI"]){
//        DSLog(@"统计打点 : %@", self.class);
    }
    [self swizzlingViewDidLoad];
}

//实现delloc方法，增加一个打印日志
- (void)deallocSwizzle{
    DSLog(@"%@ 销毁", self);
    
    [self deallocSwizzle];
}
@end
