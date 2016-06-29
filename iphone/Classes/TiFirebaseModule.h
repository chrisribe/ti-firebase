/**
 * ti-firebase
 *
 * Created by Your Name
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import "Firebase.h"

@interface TiFirebaseModule : TiModule

/**
 *  Use Firebase library to configure APIs.
 *
 *  @param unused The proxy-argument handler (remains unused)
 */
- (void)init:(id)unused;

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
+ (void)setUserPropertyString:(id)args;

/**
 *  Creates and, on success, signs in a user with the given email address and password
 *
 *  @param args The arguments to define the user-registration
 */
- (void)createUserWithEmail:(id)args;

/**
 *  Signs in using an email address and password.
 *
 *  @param args The arguments to define the user-login
 */
- (void)signInWithEmail:(id)args;

/**
 *  Signs out the current user.
 *
 *  @param args The arguments to define the user-logout
 */
- (void)signOut:(id)args;

/**
 *  Map error object to NSDictionary
 *
 *  @param error The error-object
 *
 *  @return The dictionary containing the extracted error-infos
 */
- (NSDictionary *)dictionaryFromError:(NSError *)error;

/**
 *  Map firebase user to an NSDictionary
 *
 *  @param user The Firebase user-object
 *
 *  @return The dictionary containing the extracted user-infos
 */
- (NSDictionary *)dictionaryFromUser:(FIRUser *_Nullable) user;

@end
