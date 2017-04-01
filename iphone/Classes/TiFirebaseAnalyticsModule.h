/**
 * ti-firebase auth module
 *
 * Created by Your Name
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import "Firebase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiFirebaseAnalyticsModule : TiModule {
    
}

/**
 *  Logs an app event.
 *
 *  @param args The arguments to define the log.
 */
- (void)logEventWithName:(id)args;

/**
 *  Sets a user property to a given value.
 *
 *  @param args The arguments to define the user-property.
 */
- (void)setUserPropertyString:(id)args;

/**
 *  Sets a user ID to a given value.
 *
 *  @param args The arguments to define the user ID.
 */
- (void)setUserID:(id)value;

/**
 *  Sets a screen nam and screen class to a given value.
 *
 *  @param args The arguments to define the screen name and screen class.
 */
- (void)setScreenName:(id)args;

@end

NS_ASSUME_NONNULL_END
