//
//  SJZRouteWorker.m
//  SJZRoute
//
//  Created by SJZ on 2019/3/28.
//  Copyright © 2019 SJZ. All rights reserved.
//

#import "SJZRouteWorker.h"
#import "SJZInvoker.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation SJZRouteWorker

+ (instancetype)createInstance:(NSString *)className {
    return [self createInstance:className selector:@"init" selArguments:nil withParams:nil];
}

+ (instancetype)createInstance:(NSString *)className withParams:(NSDictionary *)params {
    return [self createInstance:className selector:@"init" selArguments:nil withParams:params];
}

+ (instancetype)createInstance:(NSString *)className selector:(NSString *)selectorName withParams:(NSDictionary *)params {
    return [self createInstance:className selector:selectorName selArguments:nil withParams:params];
}

+ (instancetype)createInstance:(NSString * _Nonnull)className selector:(NSString * _Nonnull)selectorName selArguments:(NSArray * _Nullable)arguments withParams:(NSDictionary * _Nullable)params {
    Class instanceClass = NSClassFromString(className);
    id instance = nil;
    
    // 创建对象
    Class metaClass = object_getClass(instanceClass);
    if([SJZInvoker chackExistMethod:metaClass methodName:selectorName]) {
        instance = [SJZInvoker invoke:instanceClass selector:selectorName arguments:arguments];
    }else if([SJZInvoker chackExistMethod:instanceClass methodName:selectorName]) {
        instance = [SJZInvoker invoke:[instanceClass alloc] selector:selectorName arguments:arguments];
    }
    
    // 赋值参数
    if(instance && params.count > 0) {
        [self setProperty:instance params:params];
    }
    
    return instance;
}


// 设置属性
+ (void)setProperty:(id)instance params:(NSDictionary *)params {
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if([self checkExistProperty:[instance class] propetyName:key]) {
            [instance setValue:obj forKey:key];
        }
    }];
}

// 检查类里面是否有该属性
+ (BOOL)checkExistProperty:(Class)instanceClass propetyName:(NSString *)pName {
    unsigned int outCount;
    
    objc_property_t * properties = class_copyPropertyList(instanceClass, &outCount);

    for(int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString * propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        if([propertyName isEqualToString:pName]) {
            free(properties);
            return YES;
        }
    }
    
    Class superClass = class_getSuperclass(instanceClass);
    if(superClass) {
        return [self checkExistProperty:superClass propetyName:pName];
    }
    
    return NO;
}

+ (id)routeInvoke:(id)instance selector:(NSString *)selector {
    return [SJZInvoker invoke:instance selector:selector arguments:nil];
}

+ (id)routeInvoke:(id)instance selector:(NSString *)selector arguments:(NSArray *)arguments {
    return [SJZInvoker invoke:instance selector:selector arguments:arguments];
}

@end
