//
//  DescriptionBuilderAppDelegate.m
//  DescriptionBuilder
//
//  Created by KISHIKAWA Katsumi on 09/09/07.
//  Copyright KISHIKAWA Katsumi 2009. All rights reserved.
//

#import "DescriptionBuilderAppDelegate.h"
#import "Settings.h"

@implementation DescriptionBuilderAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    Settings *settings = [Settings sharedSettings];
    NSLog(@"%@", settings);
    [window makeKeyAndVisible];
}

- (void)dealloc {
    [window release];
    [super dealloc];
}

@end
