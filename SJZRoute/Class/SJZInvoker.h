//
//  SJZInvoker.h
//  SJZTest
//
//  Created by SJZ on 2019/3/19.
//  Copyright © 2019 SJZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SJZArgumentType) {
    /**
     不确定类型，例如自定义结构体等
     参数使用SetValue、返回值使用GetValue转换
     */
    SJZArgumentTypeUnknown = 0,             // 不确定类型

    /**
     作为参数：需要转为NSNumber，例如@(10)或使用方法初始化为NSNumber
     作为返回值：使用方法 或 属性转为对应类型，例如：intValue、shortValue
     */
    SJZArgumentTypeChar,                    // 字符类型
    SJZArgumentTypeInt,                     // 整型
    SJZArgumentTypeShort,                   // 短整型
    SJZArgumentTypeLong,                    // 长整型
    SJZArgumentTypeLongLong,                // 长长整型
    SJZArgumentTypeUnsignedChar,            // 无符号字符
    SJZArgumentTypeUnsignedInt,             // 无符号整型
    SJZArgumentTypeUnsignedShort,           // 无符号短整型
    SJZArgumentTypeUnsignedLong,            // 无符号长整型
    SJZArgumentTypeUnsignedLongLong,        // 无符号长长整型
    SJZArgumentTypeFloat,                   // 浮点数Float
    SJZArgumentTypeDouble,                  // 浮点数Double
    SJZArgumentTypeBool,                    // 布尔类型

    /**
     目前不知道怎么处理
     */
    SJZArgumentTypeVoid,                    // Void
    
    /**
     作为参数：使用NSString
     作为返回值：使用UTF8String，转为const char *
     */
    SJZArgumentTypeCharacterString,         // C字符串
    
    /**
     作为参数：使用系统方法（例如：valueWithCGPoint:、valueWithCGSize:），转为NSValue
     作为返回值：使用系统方法（例如：CGPointValue、CGSizeValue）,转为对应类型
     
     同样也可以使用下方宏：SetValue GetValue
     */
    SJZArgumentTypeCGPoint,                 // CGPoint
    SJZArgumentTypeCGSize,                  // CGSize
    SJZArgumentTypeCGRect,                  // CGRect
    SJZArgumentTypeUIEdgeInsets,            // UIEdgeInsets

    /**
     作为参数：直接传入
     作为返回值：直接获取
     */
    SJZArgumentTypeObject,                  // 对象
    SJZArgumentTypeClass,                   // 类
    SJZArgumentTypeBlock,                   // block
    
    /**
     作为参数：需要使用valueWithPointer:转为NSValue
     作为返回值:返回为NSValue，pointerValue转为对应的 SEL 或 IMP
     */
    SJZArgumentTypeSEL,                     // selector
    SJZArgumentTypeIMP,                     // IMP 方法指针
};

#pragma mark - SJZArgumentType 里不包括的类型
// value为需要转换的变量
#define SetValue(value) [NSValue valueWithBytes:&value objCType:@encode(typeof(value))]

// value为NSValue返回值，Type为返回值类型
#define GetValue(value, Type)\
({\
NSUInteger valueSize = 0;\
NSGetSizeAndAlignment(@encode(Type), &valueSize, NULL);\
void * par = NULL;\
par = reallocf(par, valueSize);\
if (@available(iOS 11.0, *)) {\
[value getValue:par size:valueSize];\
} else {\
[value getValue:par];\
}\
(*((Type *)par));\
})\

@interface SJZInvoker : NSObject

/**
 1、instance为类名称字符串：调用的是类方法
 2、instance为Class：调用的是类方法
 3、instance为实例：调用的是实例方法
 
 @param instance 对象方法：对象；类方法：类
 @param selector 方法字符串，无参数
 @return 方法返回值
 */
+ (id)invoke:(id)instance selector:(NSString *)selector;

/**
 1、instance为类名称字符串：调用的是类方法
 2、instance为Class：调用的是类方法
 3、instance为实例：调用的是实例方法

 @param instance 对象方法：对象；类方法：类
 @param selector 方法字符串，有参数
 @param arguments 方法参数数组
 @return 方法返回值
 */
+ (id)invoke:(id)instance selector:(NSString *)selector arguments:(nullable NSArray *)arguments;

+ (BOOL)chackExistMethod:(Class)instanceClass methodName:(NSString *)methodName;
@end

NS_ASSUME_NONNULL_END
