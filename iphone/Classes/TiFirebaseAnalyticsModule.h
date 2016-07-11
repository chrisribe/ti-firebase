/**
 * ti-firebase auth module
 *
 * Created by Your Name
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import "Firebase.h"

@interface TiFirebaseAnalyticsModule : TiModule
{
}

/**
 *  Logs an app event.
 *
 *  @param args The arguments to define the log
 */
- (void)logEventWithName:(id)args;

/**
 *  Sets a user property to a given value
 *
 *  @param args The arguments to define the user-property
 */
- (void)setUserPropertyString:(id)args;

@end
