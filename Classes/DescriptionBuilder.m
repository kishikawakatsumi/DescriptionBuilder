//
//  DescriptionBuilder.m
//  DescriptionBuilder
//
//  Created by KISHIKAWA Katsumi on 09/09/07.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import "DescriptionBuilder.h"
#import <objc/runtime.h>

@implementation DescriptionBuilder

+ (NSString *)reflectDescription:(id)obj {
    return [DescriptionBuilder reflectDescription:obj style:DescriptionStyleDefault];
}

/**
 c char
 C unsigned char
 i int
 I unsigned int
 s short
 S unsigned short
 l long
 L unsigned long
 q long long
 Q unsigned long long
 f float
 d double
 B C++のbool、またはC99の_Bool
 ^v void*
 * 文字列(char*)
 @ オブジェクト (静的に型定義されているもの、または id として型定義されているもの)
 # クラスオブジェクト(Class)
 : メソッドセレクタ(SEL)
 { 構造体
 */
+ (NSString *)reflectDescription:(id)obj style:(DescriptionStyle)style {
	id objValue;
    Class classValue;
    SEL selValue;
	signed char charValue;
	unsigned char ucharValue;
	signed int intValue;
	unsigned int uintValue;
	signed short shortValue;
	unsigned short ushortValue;
	signed long longValue;
	unsigned long ulongValue;
	signed long long longlongValue;
	unsigned long long ulonglongValue;
	float floatValue;
	double doubleValue;
	char *charPtrValue;
	void *voidPtrValue;
    
	NSMutableString *description = [[[NSMutableString alloc] init] autorelease];
    
    Class clazz = [obj class];
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList(clazz, &outCount);
    
    if (style == DescriptionStyleMultiLine) {
        [description appendFormat:@"<%s: 0x%x;\n", class_getName(clazz), [obj hash]];
    } else if (style == DescriptionStyleNoNames) {
        [description appendFormat:@"<%s: 0x%x; ", class_getName(clazz), [obj hash]];
    } else if (style == DescriptionStyleShortPrefix) {
        [description appendFormat:@"<%s; ", class_getName(clazz)];
    } else if (style == DescriptionStyleSimple) {
        [description appendString:@"<"];
    } else {
        [description appendFormat:@"<%s: 0x%x; ", class_getName(clazz), [obj hash]];
    }
    
    for (int i = 0; i < outCount; i++) {
        if (i > 0) {
            if (style == DescriptionStyleMultiLine) {
                [description appendString:@";\n"];
            } else if (style == DescriptionStyleNoNames) {
                [description appendString:@"; "];
            } else if (style == DescriptionStyleShortPrefix) {
                [description appendString:@"; "];
            } else if (style == DescriptionStyleSimple) {
                [description appendString:@"; "];
            } else {
                [description appendString:@"; "];
            }
        }
        
        Ivar ivar = ivars[i];
		const char *ivar_name = ivar_getName(ivar);
		const char *ivar_type = ivar_getTypeEncoding(ivar);
        
        if (style == DescriptionStyleMultiLine) {
            [description appendFormat:@"%s = ", ivar_name];
        } else if (style == DescriptionStyleNoNames) {
            //Nothing to do.;
        } else if (style == DescriptionStyleShortPrefix) {
            [description appendFormat:@"%s = ", ivar_name];
        } else if (style == DescriptionStyleSimple) {
            //Nothing to do.;
        } else {
            [description appendFormat:@"%s = ", ivar_name];
        }
        
		switch(*ivar_type) {
            case '@':
                object_getInstanceVariable(obj, ivar_name, (void **)&objValue);
                if (!objValue) {
                    [description appendFormat:@"%@", [NSNull null]];
                    break;
                }
                if ([objValue respondsToSelector:@selector(description)]) {
                    NSString *type = [NSString stringWithUTF8String:ivar_type];
                    if ([type length] > 3) {
                        NSString *className = [type substringWithRange:NSMakeRange(2, [type length] - 3)];
                        Class ivarClass = NSClassFromString(className);
                        if ([NSString isSubclassOfClass:ivarClass]) {
                            [description appendFormat:@"\"%@\"", [objValue description]];
                            break;
                        }
                    }
                    [description appendFormat:@"%@", [objValue description]];
                } else {
                    [description appendFormat:@"<%s: 0x%x>", class_getName([objValue class]), [objValue hash]];
                }
                break;
            case '#':
                object_getInstanceVariable(obj, ivar_name, (void **)&classValue);
                [description appendFormat:@"%@", NSStringFromClass(classValue)];
                break;
            case ':':
                object_getInstanceVariable(obj, ivar_name, (void **)&selValue);
                [description appendFormat:@"%@", NSStringFromSelector(selValue)];
                break;
            case 'c':
                object_getInstanceVariable(obj, ivar_name, (void **)&charValue);
                [description appendFormat:@"%@", charValue == 0 ? @"NO" : @"YES"];
                break;
            case 'C':
                object_getInstanceVariable(obj, ivar_name, (void **)&ucharValue);
                [description appendFormat:@"%c", ucharValue];
                break;
            case 'i':
                object_getInstanceVariable(obj, ivar_name, (void **)&intValue);
                [description appendFormat:@"%d", intValue];
                break;
            case 'I':
                object_getInstanceVariable(obj, ivar_name, (void **)&uintValue);
                [description appendFormat:@"%u", uintValue];
                break;
            case 's':
                object_getInstanceVariable(obj, ivar_name, (void **)&shortValue);
                [description appendFormat:@"%hi", shortValue];
                break;
            case 'S':
                object_getInstanceVariable(obj, ivar_name, (void **)&ushortValue);
                [description appendFormat:@"%hu", ushortValue];
                break;
            case 'l':
                object_getInstanceVariable(obj, ivar_name, (void **)&longValue);
                [description appendFormat:@"%d", longValue];
                break;
            case 'L':
                object_getInstanceVariable(obj, ivar_name, (void **)&ulongValue);
                [description appendFormat:@"%u", ulongValue];
                break;
            case 'q':
                object_getInstanceVariable(obj, ivar_name, (void **)&longlongValue);
                [description appendFormat:@"%qi", longlongValue];
                break;
            case 'Q':
                object_getInstanceVariable(obj, ivar_name, (void **)&ulonglongValue);
                [description appendFormat:@"%qu", ulonglongValue];
                break;
            case 'f':
                object_getInstanceVariable(obj, ivar_name, (void **)&floatValue);
                [description appendFormat:@"%f", floatValue];
                break;
            case 'd':
                object_getInstanceVariable(obj, ivar_name, (void **)&doubleValue);
                [description appendFormat:@"f", doubleValue];
                break;
            case 'B':
                object_getInstanceVariable(obj, ivar_name, (void **)&intValue);
                [description appendFormat:@"%@", intValue == 0 ? @"false" : @"true"];
                break;
            case '*':
                object_getInstanceVariable(obj, ivar_name, (void **)&charPtrValue);
                [description appendFormat:@"%s", charPtrValue];
                break;
            case '^':
                object_getInstanceVariable(obj, ivar_name, (void **)&voidPtrValue);
                [description appendFormat:@"%p", voidPtrValue];
                break;
            case '{':
            {
                NSString *type = [NSString stringWithUTF8String:ivar_type];
                NSString *structName = [type substringWithRange:NSMakeRange(1, [type rangeOfString:@"="].location - 1)];
                if ([structName isEqualToString:@"CGAffineTransform"]) {
                    CGAffineTransform transform;
                    object_getInstanceVariable(obj, ivar_name, (void **)&transform);
                    [description appendFormat:@"%@", NSStringFromCGAffineTransform(transform)];
                } else if ([structName isEqualToString:@"CGPoint"]) {
                    CGPoint point;
                    object_getInstanceVariable(obj, ivar_name, (void **)&point);
                    [description appendFormat:@"%@", NSStringFromCGPoint(point)];
                } else if ([structName isEqualToString:@"CGRect"]) {
                    CGRect rect;
                    object_getInstanceVariable(obj, ivar_name, (void **)&rect);
                    [description appendFormat:@"%@", NSStringFromCGRect(rect)];
                } else if ([structName isEqualToString:@"CGSize"]) {
                    CGSize size;
                    object_getInstanceVariable(obj, ivar_name, (void **)&size);
                    [description appendFormat:@"%@", NSStringFromCGSize(size)];
                } else if ([structName isEqualToString:@"_NSRange"]) {
                    NSRange range;
                    object_getInstanceVariable(obj, ivar_name, (void **)&range);
                    [description appendFormat:@"%@", NSStringFromRange(range)];
                } else if ([structName isEqualToString:@"UIEdgeInsets"]) {
                    UIEdgeInsets insets;
                    object_getInstanceVariable(obj, ivar_name, (void **)&insets);
                    [description appendFormat:@"%@", NSStringFromUIEdgeInsets(insets)];
                }
                break;
            }
            default:
                [description appendFormat:@"%s", ivar_type];
                break;
		}
	}
    [description appendString:@">"];
    if (outCount > 0) { free(ivars); }
    return description;
}

@end
