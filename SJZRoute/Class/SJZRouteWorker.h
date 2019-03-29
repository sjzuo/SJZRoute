//
//  SJZRouteWorker.h
//  SJZRoute
//
//  Created by SJZ on 2019/3/28.
//  Copyright © 2019 SJZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SJZRouteWorker : NSObject


/**
 根据 类名称 创建对象，使用init方法构造

 @param className 类名称
 @return 返回对象
 */
+ (instancetype)createInstance:(NSString * _Nonnull)className;


/**
 根据 类名称 和 属性字典 创建对象，使用init方法构造

 @param className 类名称
 @param params 属性字典
 @return 返回对象
 */
+ (instancetype)createInstance:(NSString * _Nonnull)className withParams:(NSDictionary * _Nullable)params;


/**
 1、根据类名称，实例方法（不带参数），属性字典 创建对象
 2、根据类名称，类方法（不带参数），属性字典，创建对象

 @param className 类名称
 @param selectorName 方法名称
 @param params 属性字典
 @return 返回对象
 */
+ (instancetype)createInstance:(NSString * _Nonnull)className selector:(NSString * _Nonnull)selectorName withParams:(NSDictionary * _Nullable)params;

/**
 1、根据类名称，实例方法，属性字典 创建对象
 2、根据类名称，类方法，属性字典，创建对象
 
 @param className 类名称
 @param selectorName 方法名称
 @param arguments 方法参数
 @param params 属性字典
 @return 返回对象
 */
+ (instancetype)createInstance:(NSString * _Nonnull)className selector:(NSString * _Nonnull)selectorName selArguments:(NSArray * _Nullable)arguments withParams:(NSDictionary * _Nullable)params;


/**
 给实例属性赋值

 @param instance 实例
 @param params 参数字典
 */
+ (void)setProperty:(id)instance params:(NSDictionary *)params;


/**
 1、instance为类名称字符串：调用的是类方法
 2、instance为Class：调用的是类方法
 3、instance为实例：调用的是实例方法
 
 @param instance 对象方法：对象；类方法：类
 @param selector 方法字符串，无参数
 @return 方法返回值
 */
+ (id)routeInvoke:(id)instance selector:(NSString *)selector;

/**
 1、instance为类名称字符串：调用的是类方法
 2、instance为Class：调用的是类方法
 3、instance为实例：调用的是实例方法
 
 @param instance 对象方法：对象；类方法：类
 @param selector 方法字符串，有参数
 @param arguments 方法参数数组
 @return 方法返回值
 */
+ (id)routeInvoke:(id)instance selector:(NSString *)selector arguments:(NSArray *)arguments;

@end

NS_ASSUME_NONNULL_END
