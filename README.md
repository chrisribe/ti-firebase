# ti-firebase
Appcelerator / Titanium module project to build and use the google firebase SDK

How to use it:
```
//Firebase init (init from GoogleService-Info.plist in ressources folder)
var _tFireb = require('ti.firebase');
_tFireb.configure();
```

**createUserWithEmail**
```
var email = _v.email_f.value;
var pwd = _v.pwd_f.value;
_tFireb.FIRAuth.createUserWithEmail({
	'email': email,
	'password': pwd,
	'success': function(data){
		alert(JSON.stringify(data));
	},
	'error': function(data){
		alert(JSON.stringify(data));
	}
});
```

*signInWithEmail*
```
var email = _v.email_f.value;
var pwd = _v.pwd_f.value;
_tFireb.FIRAuth.signInWithEmail({
	'email': email,
	'password': pwd,
	'success': function(data){
		alert(JSON.stringify(data));
	},
	'error': function(data){
		alert(JSON.stringify(data));
	}
});
```

*signOut*
```
_tFireb.FIRAuth.signOut({
	'success': function(data){	
		alert(JSON.stringify(data));
	},
	'error': function(data){
		alert(JSON.stringify(data));
	}
});
```

*logEventWithName*
```
_tFireb.FIRAnalytics.logEventWithName({
	‘name’: ‘xyz’,
	‘parameters’:{
		‘VALUE’: 0.99,
		‘CURRENCY’: ‘EUR’
	}
});
```