/**
 * ti-firebase FIRAuth
 *
 * Created by cribe
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiModule.h"
#import "Firebase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiFirebaseAuthModule : TiModule {
    
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
 *  Creates and, on success, signs in a user with the given email address and password.
 *
 *  @param args The arguments to define the user-registration.
 */
- (void)createUserWithEmail:(id)args;

/**
 *  Signs in using an email address and password.
 *
 *  @param args The arguments to define the user-login.
 */
- (void)signInWithEmail:(id)args;

/**
 *  Signs out the current user.
 *
 *  @param args The arguments to define the user-logout.
 */
- (void)signOut:(id)args;

/**
 *  Sends a password reset email.
 *
 *  @param args The arguments to define the reset email receiver.
 */
- (void)sendPasswordResetWithEmail:(id)args;

/**
 *  Synchronously gets the cached current user, or null if there is none.
 */
- (NSDictionary *_Nullable)currentUser;

@end

NS_ASSUME_NONNULL_END
