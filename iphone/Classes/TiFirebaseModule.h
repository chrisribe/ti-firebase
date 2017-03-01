/**
 * ti-firebase
 *
 * Created by Your Name
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import "Firebase.h"
#import "TiFirebaseAuthModule.h"
#import "TiFirebaseAnalyticsModule.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiFirebaseModule : TiModule
{
	TiFirebaseAuthModule *firAuth;
	TiFirebaseAnalyticsModule *firAnalytics;
}

/**
 *  Initialize and configure FIRApp.
 *
 *  @param unused The proxy-argument handler (remains unused)
 */
- (void)configure:(_Nullable id)unused;

/**
*  Manages authentication for Firebase apps
*
*  @param unused The proxy-argument handler (remains unused)
*/
- (TiFirebaseAuthModule *_Nonnull)FIRAuth;

/**
*  Manages analytics for Firebase apps
*
*  @param unused The proxy-argument handler (remains unused)
*/
- (TiFirebaseAnalyticsModule*_Nonnull)FIRAnalytics;


/**
 *  Map error object to NSDictionary
 *
 *  @param error The error-object
 *
 *  @return The dictionary containing the extracted error-infos
 */
+ (NSDictionary * _Nullable)dictionaryFromError:(NSError *_Nullable)error;

/**
 *  Map firebase user to an NSDictionary
 *
 *  @param user The Firebase user-object
 *
 *  @return The dictionary containing the extracted user-infos
 */
+ (NSDictionary * _Nullable)dictionaryFromUser:(FIRUser *_Nullable) user;

@end

NS_ASSUME_NONNULL_END
