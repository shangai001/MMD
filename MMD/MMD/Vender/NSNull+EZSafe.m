//
//  NSNull+EZSafe.m
//  MMD
//
//  Created by pencho on 16/4/13.
//  Copyright © 2016年 Eric.Co.,Ltd. All rights reserved.
//

#import "NSNull+EZSafe.h"
#import <objc/runtime.h>

#define XYNullObjects @[@"",@0,@{},@[]]

@implementation NSNull (EZSafe)

+ (void)load
{
    @autoreleasepool {
        [self __uxy_swizzleInstanceMethodWithClass:[NSNull class] originalSel:@selector(methodSignatureForSelector:) replacementSel:@selector(__uxy_methodSignatureForSelector:)];
        [self __uxy_swizzleInstanceMethodWithClass:[NSNull class] originalSel:@selector(forwardInvocation:) replacementSel:@selector(__uxy_forwardInvocation:)];
    }
}

- (NSMethodSignature *)__uxy_methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    
    if (signature != nil)
        return signature;
    
    for (NSObject *object in XYNullObjects)
    {
        signature = [object methodSignatureForSelector:selector];
        
        if (!signature)
            continue;
        
        if (strcmp(signature.methodReturnType, "@") == 0)
        {
            signature = [[NSNull null] methodSignatureForSelector:@selector(__uxy_nil)];
        }
        
        return signature;
    }
    
    
    return [self __uxy_methodSignatureForSelector:selector];
}

- (void)__uxy_forwardInvocation:(NSInvocation *)anInvocation
{
    if (strcmp(anInvocation.methodSignature.methodReturnType, "@") == 0)
    {
        anInvocation.selector = @selector(__uxy_nil);
        [anInvocation invokeWithTarget:self];
        return;
    }
    
    for (NSObject *object in XYNullObjects)
    {
        if ([object respondsToSelector:anInvocation.selector])
        {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    [self __uxy_forwardInvocation:anInvocation];
}

- (id)__uxy_nil
{
    return nil;
}

+ (void)__uxy_swizzleInstanceMethodWithClass:(Class)clazz originalSel:(SEL)original replacementSel:(SEL)replacement
{
    Method a = class_getInstanceMethod(clazz, original);
    Method b = class_getInstanceMethod(clazz, replacement);
    if (class_addMethod(clazz, original, method_getImplementation(b), method_getTypeEncoding(b)))
    {
        class_replaceMethod(clazz, replacement, method_getImplementation(a), method_getTypeEncoding(a));
    }
    else
    {
        method_exchangeImplementations(a, b);
    }
}


@end
