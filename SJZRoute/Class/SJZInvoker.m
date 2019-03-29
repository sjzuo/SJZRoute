//
//  SJZInvoker.m
//  SJZTest
//
//  Created by SJZ on 2019/3/19.
//  Copyright © 2019 SJZ. All rights reserved.
//

#import "SJZInvoker.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSMethodSignature (Invoker)

- (SJZArgumentType)returnType {
    const char * encode = [self methodReturnType];
    return [self argumentTypeWithEncode:encode];
}

- (SJZArgumentType)argumentTypeWithEncode:(const char *)encode {
    if (strcmp(encode, @encode(char)) == 0) {
        return SJZArgumentTypeChar;
    } else if (strcmp(encode, @encode(int)) == 0) {
        return SJZArgumentTypeInt;
    } else if (strcmp(encode, @encode(short)) == 0) {
        return SJZArgumentTypeShort;
    } else if (strcmp(encode, @encode(long)) == 0) {
        return SJZArgumentTypeLong;
    } else if (strcmp(encode, @encode(long long)) == 0) {
        return SJZArgumentTypeLongLong;
    } else if (strcmp(encode, @encode(unsigned char)) == 0) {
        return SJZArgumentTypeUnsignedChar;
    } else if (strcmp(encode, @encode(unsigned int)) == 0) {
        return SJZArgumentTypeUnsignedInt;
    } else if (strcmp(encode, @encode(unsigned short)) == 0) {
        return SJZArgumentTypeUnsignedShort;
    } else if (strcmp(encode, @encode(unsigned long)) == 0) {
        return SJZArgumentTypeUnsignedLong;
    } else if (strcmp(encode, @encode(unsigned long long)) == 0) {
        return SJZArgumentTypeUnsignedLongLong;
    } else if (strcmp(encode, @encode(float)) == 0) {
        return SJZArgumentTypeFloat;
    } else if (strcmp(encode, @encode(double)) == 0) {
        return SJZArgumentTypeDouble;
    } else if (strcmp(encode, @encode(BOOL)) == 0) {
        return SJZArgumentTypeBool;
    } else if (strcmp(encode, @encode(void)) == 0) {
        return SJZArgumentTypeVoid;
    } else if (strcmp(encode, @encode(char *)) == 0) {
        return SJZArgumentTypeCharacterString;
    } else if (strcmp(encode, @encode(id)) == 0) {
        return SJZArgumentTypeObject;
    } else if (strcmp(encode, @encode(Class)) == 0) {
        return SJZArgumentTypeClass;
    } else if (strcmp(encode, @encode(CGPoint)) == 0) {
        return SJZArgumentTypeCGPoint;
    } else if (strcmp(encode, @encode(CGSize)) == 0) {
        return SJZArgumentTypeCGSize;
    } else if (strcmp(encode, @encode(CGRect)) == 0) {
        return SJZArgumentTypeCGRect;
    } else if (strcmp(encode, @encode(UIEdgeInsets)) == 0) {
        return SJZArgumentTypeUIEdgeInsets;
    } else if (strcmp(encode, @encode(SEL)) == 0) {
        return SJZArgumentTypeSEL;
    }  else if (strcmp(encode, @encode(IMP)) == 0) {
        return SJZArgumentTypeIMP;
    } else if(strcmp(encode, @encode(void (^)(void))) == 0) {
        return SJZArgumentTypeBlock;
    } else {
        return SJZArgumentTypeUnknown;
    }
}

- (SJZArgumentType)argumentTypeAtIndex:(NSInteger)index {
    const char * encode = [self getArgumentTypeAtIndex:index];
    return [self argumentTypeWithEncode:encode];
}

- (NSInvocation *)invocationWithArguments:(NSArray *)arguments {
    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:self];
    
    [arguments enumerateObjectsUsingBlock:^(id  _Nonnull argument, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = idx + 2;
        const char * encode = [self getArgumentTypeAtIndex:index];
        SJZArgumentType type = [self argumentTypeAtIndex:index];
        
        switch (type) {
            case SJZArgumentTypeChar: {
                char value = [argument charValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeInt: {
                int value = [argument intValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeShort: {
                short value = [argument shortValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeLong: {
                long value = [argument longValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeLongLong: {
                long long value = [argument longLongValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeUnsignedChar: {
                unsigned char value = [argument unsignedCharValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeUnsignedInt: {
                unsigned int value = [argument unsignedIntValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeUnsignedShort: {
                unsigned short value = [argument unsignedShortValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeUnsignedLong: {
                unsigned long value = [argument unsignedLongValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeUnsignedLongLong: {
                unsigned long long value = [argument unsignedLongLongValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeFloat: {
                float value = [argument floatValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeDouble: {
                double value = [argument doubleValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeBool: {
                BOOL value = [argument boolValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeCharacterString: {
                const char *value = [argument UTF8String];
                [invocation setArgument:&value atIndex:index];
            } break;case SJZArgumentTypeCGPoint: {
                CGPoint value = [argument CGPointValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeCGSize: {
                CGSize value = [argument CGSizeValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeCGRect: {
                CGRect value = [argument CGRectValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeUIEdgeInsets: {
                UIEdgeInsets value = [argument UIEdgeInsetsValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeObject: {
                [invocation setArgument:&argument atIndex:index];
            } break;
            case SJZArgumentTypeClass: {
                Class value = [argument class];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SJZArgumentTypeIMP: {
                IMP imp = [argument pointerValue];
                [invocation setArgument:&imp atIndex:index];
            } break;
            case SJZArgumentTypeSEL: {
                SEL sel = [argument pointerValue];
                [invocation setArgument:&sel atIndex:index];
            } break;
            case SJZArgumentTypeBlock: {
                [invocation setArgument:&argument atIndex:index];
            } break;
            case SJZArgumentTypeVoid: {
                // 不做操作
            } break;
            default:{
                // 不确定类型
                NSUInteger valueSize = 0;
                NSGetSizeAndAlignment(encode, &valueSize, NULL);
                
                void * par = NULL;
                par = reallocf(par, valueSize);
                if (@available(iOS 11.0, *)) {
                    [argument getValue:par size:valueSize];
                } else {
                    [argument getValue:par];
                }
                
                [invocation setArgument:par atIndex:index];
            } break;
        }
    }];
    
    return invocation;
}

@end

@implementation NSInvocation (Invoker)

- (id)invoker:(id)target selector:(SEL)selector returnType:(SJZArgumentType)type {
    self.target = target;
    self.selector = selector;
    [self invoke];
    
    return [self returnValueForType:type];
}

- (id)returnValueForType:(SJZArgumentType)type {
    __unsafe_unretained id returnValue = nil;
    switch (type) {
        case SJZArgumentTypeChar: {
            char value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeInt:  {
            int value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeShort:  {
            short value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeLong:  {
            long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeLongLong:  {
            long long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeUnsignedChar:  {
            unsigned char value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeUnsignedInt:  {
            unsigned int value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeUnsignedShort:  {
            unsigned short value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeUnsignedLong:  {
            unsigned long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeUnsignedLongLong:  {
            unsigned long long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeFloat:  {
            float value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeDouble:  {
            double value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeBool: {
            BOOL value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SJZArgumentTypeCharacterString: {
            const char *value;
            [self getReturnValue:&value];
            returnValue = [NSString stringWithUTF8String:value];
        } break;
        case SJZArgumentTypeCGPoint: {
            CGPoint value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGPoint:value];
        } break;
        case SJZArgumentTypeCGSize: {
            CGSize value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGSize:value];
        } break;
        case SJZArgumentTypeCGRect: {
            CGRect value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGRect:value];
        } break;
        case SJZArgumentTypeUIEdgeInsets: {
            UIEdgeInsets value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithUIEdgeInsets:value];
        } break;
        case SJZArgumentTypeSEL: {
            SEL sel;
            [self getReturnValue:&sel];
            returnValue = [NSValue valueWithPointer:sel];
        } break;
        case SJZArgumentTypeIMP: {
            IMP imp;
            [self getReturnValue:&imp];
            returnValue = [NSValue valueWithPointer:imp];
        } break;
        case SJZArgumentTypeObject:
        case SJZArgumentTypeClass:
        case SJZArgumentTypeBlock: {
            [self getReturnValue:&returnValue];
        }break;
        case SJZArgumentTypeVoid:{
            // 不做操作
        }break;
        default: {
            // 不确定类型
            const char * encode = [self.methodSignature methodReturnType];
            
            NSUInteger valueSize = 0;
            NSGetSizeAndAlignment(encode, &valueSize, NULL);
            
            void * par = NULL;
            par = reallocf(par, valueSize);
            [self getReturnValue:par];
            returnValue = [NSValue valueWithBytes:par objCType:encode];
        }break;
    }
    
    id value = returnValue;
    return value;
}

@end

@implementation SJZInvoker

+ (id)invoke:(id)instance selector:(NSString *)selector {
    return [self invoke:instance selector:selector arguments:@[]];
}

+ (id)invoke:(id)instance selector:(NSString *)selector arguments:(NSArray *)arguments {
    id privateInstance;
    if([instance isKindOfClass:[NSString class]]) {
        privateInstance = NSClassFromString(instance);
    }else {
        privateInstance = instance;
    }
    
    if([self chackExistMethod:object_getClass(privateInstance) methodName:selector]) {
        SEL sel= NSSelectorFromString(selector);
        NSMethodSignature * signature = [privateInstance methodSignatureForSelector:sel];
        if(signature) {
            NSInvocation * invocation = [signature invocationWithArguments:arguments];
            id returnValue = [invocation invoker:instance selector:sel returnType:[signature returnType]];
            return returnValue;
        }
    }

    return nil;
}

// 检查类是否实现了某方法
+ (BOOL)chackExistMethod:(Class)instanceClass methodName:(NSString *)methodName {
    unsigned int count = 0;
    Method * methods = class_copyMethodList(instanceClass, &count);
    
    for(int i = 0; i < count; i++) {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        
        if([name isEqualToString:methodName]) {
            free(methods);
            return YES;
        }
    }
    free(methods);
    
    // 类方法 只调用自己的，不再去寻找父类的
    if(!class_isMetaClass(instanceClass)) {
        // 遍历循环
        Class superClass = class_getSuperclass(instanceClass);
        if(superClass) {
            return [self chackExistMethod:superClass methodName:methodName];
        }
    }
    
    return NO;
}

@end
