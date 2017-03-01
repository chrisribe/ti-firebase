# Ti.Firebase
Appcelerator Titanium module to build and use the google Firebase SDK 3.9.0.

How to use it:
```js
// Firebase init
// iOS: Initialize from GoogleService-Info.plist in "Resources" (Classic) or "app/platform/ios" (Alloy) folder
var Firebase = require('ti.firebase');
Firebase.configure();
```

**createUserWithEmail**
```js
var email = myEmailField.getValue();
var pwd = myPasswordField.getValue();

Firebase.FIRAuth.createUserWithEmail({
	email: email,
	password: pwd,
	success: function(data) {
		alert(JSON.stringify(data));
	},
	error: function(data) {
		alert(JSON.stringify(data));
	}
});
```

**signInWithEmail**
```js
var email = myEmailField.getValue();
var pwd = myPasswordField.getValue();

Firebase.FIRAuth.signInWithEmail({
	email: email,
	password: pwd,
	success: function(data) {
		alert(JSON.stringify(data));
	},
	error: function(data) {
		alert(JSON.stringify(data));
	}
});
```

**signOut**
```js
Firebase.FIRAuth.signOut({
	success: function(data) {	
		alert(JSON.stringify(data));
	},
	error: function(data) {
		alert(JSON.stringify(data));
	}
});
```

**logEventWithName**
```js
Firebase.FIRAnalytics.logEventWithName({
	name: 'xyz',
	parameters: {
		'VALUE': 0.99,
		'CURRENCY': 'EUR'
	}
});
```

**setUserPropertyString**
```js
Firebase.FIRAnalytics.setUserPropertyString({
	name: 'value_name',
	value: 'the_value'
});
```

# Firebase Debug Mode

Firebase is setup in this module so that if you build your app in debug mode you will see debug logs from Firebase.
The required argument passed on launch “-FIRAnalyticsDebugEnabled” is set in this module’s Xcode project product scheme. The scheme is set to “share” it’s settings with the project including the module.

