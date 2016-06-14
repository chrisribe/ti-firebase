/**
 * ti-firebase
 *
 * Created by Your Name
 * Copyright (c) 2016 Your Company. All rights reserved.
 */

#import "TiFirebaseModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "Firebase.h"

@implementation TiFirebaseModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"1dc51f4a-d89b-4df2-89da-278d5a246c90";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.firebase";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs
//############## Internal Functions #################
// Map error object to NSDictionary
-(NSDictionary *)buildErrorDict:(NSError *)error{
	if(error){
		NSDictionary *errorDict = [
			NSDictionary dictionaryWithObjects:@[
				[NSNumber numberWithLong: error.code],
				[NSString stringWithString:error.localizedDescription]
			]
			forKeys:@[
				@"code",
				@"description"
			]
		];
		return(errorDict);
	}else
		return(nil);
}
// Map firebase user to NSDictionary
-(NSDictionary *)buildUserDict:(FIRUser *_Nullable) user{
	if(user){
		NSDictionary *userDict = [
			NSDictionary dictionaryWithObjects:@[
				user.email, user.providerID, user.uid
			]
			forKeys:@[
				@"email",
				@"providerID",
				@"uid"
			]
		];
		return(userDict);
	}else
		return(nil);
}
//###############################

-(void)init:(id)args{
	//Use Firebase library to configure APIs
	[FIRApp configure];
}

//+ (void) logEventWithName: (NSString *) name
// parameters: (NSDictionary *) parameters

-(void)logEventWithName:(id)args{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_ARG_COUNT(args, 1);
    NSDictionary *dict = args[0];

	NSString *name = ([dict[@"name"] isKindOfClass:[NSString class]] ? dict[@"name"] : nil);
	NSDictionary *pDict = (dict[@"parameters"] ? dict[@"parameters"] : [[[NSDictionary alloc] init] autorelease]);
	
 	[FIRAnalytics logEventWithName:name parameters:pDict];
}

//+ (void) setUserPropertyString:
//(NSString *) 	value
//forName:		(NSString *) 	name
+(void)setUserPropertyString:(id)args{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_ARG_COUNT(args, 1);
    NSDictionary *dict = args[0];

	NSString *value = ([dict[@"value"] isKindOfClass:[NSString class]] ? dict[@"value"] : nil);
	NSString *name = ([dict[@"name"] isKindOfClass:[NSString class]] ? dict[@"name"] : nil);
	
	[FIRAnalytics setUserPropertyString:value forName:name];
}

/*
[[FIRAuth auth]
createUserWithEmail:email password:password
 completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
   // ...
 }];
*/

-(void)createUserWithEmail:(id)args{

    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_ARG_COUNT(args, 1);
    NSDictionary *dict = args[0];

	NSString *email = ([dict[@"email"] isKindOfClass:[NSString class]] ? dict[@"email"] : nil);
	NSString *password = ([dict[@"password"] isKindOfClass:[NSString class]] ? dict[@"password"] : nil);

	KrollCallback *onSuccess = ([dict[@"success"] isKindOfClass:[KrollCallback class]] ? dict[@"success"] : nil);
	KrollCallback *onError = ([dict[@"error"] isKindOfClass:[KrollCallback class]] ? dict[@"error"] : nil);

	[[FIRAuth auth]
    	createUserWithEmail:email
		password:password
		completion:^(FIRUser *_Nullable user, NSError *_Nullable error) {

			if(onError != nil && error){
				[onError call:@[[self buildErrorDict:error]] thisObject:nil];
			}
			else if(onSuccess != nil){
				[onSuccess call:@[[self buildUserDict:user]] thisObject:nil];
			}
		}];

}


/*
[[FIRAuth auth] signInWithEmail:email
					password: password
					completion:^(FIRUser *user, NSError *error) {
                       // ...
}];
*/
-(void)signInWithEmail:(id)args{

    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_ARG_COUNT(args, 1);
    NSDictionary *dict = args[0];

	NSString *email = ([dict[@"email"] isKindOfClass:[NSString class]] ? dict[@"email"] : nil);
	NSString *password = ([dict[@"password"] isKindOfClass:[NSString class]] ? dict[@"password"] : nil);
	
	KrollCallback *onSuccess = ([dict[@"success"] isKindOfClass:[KrollCallback class]] ? dict[@"success"] : nil);
	KrollCallback *onError = ([dict[@"error"] isKindOfClass:[KrollCallback class]] ? dict[@"error"] : nil);

	[[FIRAuth auth] signInWithEmail:email
		password: password
		completion:^(FIRUser *user, NSError *error) {

			if(onError != nil && error){
				[onError call:@[[self buildErrorDict:error]] thisObject:nil];
			}
			else if(onSuccess != nil){
				[onSuccess call:@[[self buildUserDict:user]] thisObject:nil];
			}
	}];
}
/*
- signOut: (NSError *_Nullable *_Nullable) error
Signs out the current user.
*/
-(void)signOut:(id)args{
    ENSURE_UI_THREAD_1_ARG(args);
    ENSURE_ARG_COUNT(args, 1);
    NSDictionary *dict = args[0];

	KrollCallback *onSuccess = ([dict[@"success"] isKindOfClass:[KrollCallback class]] ? dict[@"success"] : nil);
	KrollCallback *onError = ([dict[@"error"] isKindOfClass:[KrollCallback class]] ? dict[@"error"] : nil);

	NSError *error;
	[[FIRAuth auth] signOut:&error];
	if(!error && (onSuccess != nil)){
		// Sign-out succeeded
		[onSuccess call:@[@"success"] thisObject:nil];
	}else if((onError != nil) && error){
		//Here this error case occurs always after 1st signin success
		//the generated error seems invalid. Set a simple "error" string for now.
		//[self buildUserDict:user]
		[onError call:@[@"error"] thisObject:nil];
	}
}

/*
NSDictionary *userInfo = @{
  NSLocalizedDescriptionKey: NSLocalizedString(@"Operation was unsuccessful.", nil)
                          };
NSError *cError = [NSError errorWithDomain:@"myDom"
                                     code:-57
                                 userInfo:userInfo];
*/

@end
