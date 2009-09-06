//
//  DescriptionBuilder.h
//  DescriptionBuilder
//
//  Created by KISHIKAWA Katsumi on 09/09/07.
//  Copyright 2009 KISHIKAWA Katsumi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum DescriptionStyle {
    DescriptionStyleDefault,
    DescriptionStyleMultiLine,
    DescriptionStyleNoNames,
    DescriptionStyleShortPrefix,
    DescriptionStyleSimple,
} DescriptionStyle;

@interface DescriptionBuilder : NSObject

+ (NSString *)reflectDescription:(id)obj;
+ (NSString *)reflectDescription:(id)obj style:(DescriptionStyle)style;

@end
