// this sets the background color of the master UIView (when there are no windows/tab groups on it)
Titanium.UI.setBackgroundColor('#FFF');
//Firebase init
var _tFireb = require('ti.firebase');
_tFireb.configure();

var win = Titanium.UI.createWindow({
	fullscreen: true,
    top: 0, left: 0,
    width: Ti.UI.FILL,
    height: Ti.UI.FILL
});
var _v ={};
_v = initUI(_v);

win.add(_v.self);
win.open(); 

function initUI(v){
	var tFieldProps = {
		top: 6, left: 6, right: 6,
		paddingLeft: 6,
		autocapitalization: Titanium.UI.TEXT_AUTOCAPITALIZATION_NONE,
		borderColor:'lightgray', borderWidth:1,
		textAlign: Ti.UI.TEXT_ALIGNMENT_LEFT,
		height: 30, width: Ti.UI.FILL
	};
	v.self = Ti.UI.createScrollView({
		top:20, left: 0,
		layout: 'vertical',
		width: Ti.UI.FILL, height: Ti.UI.SIZE
	});
	v.demo_lbl = Titanium.UI.createLabel({
		text:'Ti Firebase demo',
		width:'auto',
		font:{fontSize: 20}
	});
	v.self.add(v.demo_lbl);
	
//#### Login with email test ####
	v.lBox_v = Ti.UI.createView({
		top:10,
		layout: 'vertical',
		width: '90%', height: Ti.UI.SIZE, 
		borderColor:'black', borderWidth: 1,
		borderRadius: 6
	});
	v.title_lbl = Titanium.UI.createLabel({
		top: 6,
		text:'-- Login/Create user with email --',
		color:'lightgray',
		width: Ti.UI.SIZE, height: Ti.UI.SIZE
	});
	v.lBox_v.add(v.title_lbl);
	
	v.email_f = Ti.UI.createTextField(tFieldProps);
	v.email_f.hintText = 'Email';
	v.lBox_v.add(v.email_f);
	
	v.pwd_f = Ti.UI.createTextField(tFieldProps);
	v.pwd_f.passwordMask = true;
	v.pwd_f.hintText = 'Password';
	v.lBox_v.add(v.pwd_f);
	
	//btn actions
	v.createByEmailBtn = Ti.UI.createButton({
		title: 'Create User',
		with: Ti.UI.SIZE, height: Ti.UI.SIZE
	});
	v.signInByEmailBtn = Ti.UI.createButton({
		title: 'Login User',
		with: Ti.UI.SIZE, height: Ti.UI.SIZE
	});
	v.signOutBtn = Ti.UI.createButton({
		title: 'Signout User',
		with: Ti.UI.SIZE, height: Ti.UI.SIZE
	});
	v.currentUserBtn = Ti.UI.createButton({
		title: 'Current User',
		with: Ti.UI.SIZE, height: Ti.UI.SIZE
	});

	v.lBox_v.add(v.createByEmailBtn);
	v.lBox_v.add(v.signInByEmailBtn);
	v.lBox_v.add(v.signOutBtn);
	v.lBox_v.add(v.currentUserBtn);
	v.self.add(v.lBox_v);
	
//#### log events box ####
	v.evtBox_v = Ti.UI.createView({
		top:10,
		layout: 'vertical',
		width: '90%', height: Ti.UI.SIZE, 
		borderColor:'black', borderWidth: 1,
		borderRadius: 6
	});
	v.self.add(v.evtBox_v);	
	
	v.eTitle_lbl = Titanium.UI.createLabel({
		top: 6,
		text:'-- logEventWithName --',
		color:'lightgray',
		width: Ti.UI.SIZE, height: Ti.UI.SIZE
	});
	v.evtBox_v.add(v.eTitle_lbl);

	v.evtName_f = Ti.UI.createTextField(tFieldProps);
	v.evtName_f.hintText = 'Event Name';
	v.evtBox_v.add(v.evtName_f);

	v.eParams_lbl = Titanium.UI.createLabel({
		top: 6, left: 6,
		text:'Parameters key/values (pipe seperated "|")',
		color:'lightgray',
		width: Ti.UI.SIZE, height: Ti.UI.SIZE
	});
	v.evtBox_v.add(v.eParams_lbl);
		
	v.evtKeys_f = Ti.UI.createTextField(tFieldProps);
	v.evtKeys_f.hintText = 'Keys';
	v.evtBox_v.add(v.evtKeys_f);
	
	v.evtValues_f = Ti.UI.createTextField(tFieldProps);
	v.evtValues_f.hintText = 'Values (use comma for float values)';
	v.evtBox_v.add(v.evtValues_f);

	v.logEventBtn = Ti.UI.createButton({
		title: 'Log event',
		with: Ti.UI.SIZE, height: Ti.UI.SIZE
	});
	v.evtBox_v.add(v.logEventBtn);


//#### setUserPropertyString ####
	v.uPropBox_v = Ti.UI.createView({
		top:10,
		layout: 'vertical',
		width: '90%', height: Ti.UI.SIZE, 
		borderColor:'black', borderWidth: 1,
		borderRadius: 6
	});
	v.self.add(v.uPropBox_v);	
	
	v.uPropTitle_lbl = Titanium.UI.createLabel({
		top: 6,
		text:'-- setUserPropertyString --',
		color:'lightgray',
		width: Ti.UI.SIZE, height: Ti.UI.SIZE
	});
	v.uPropBox_v.add(v.uPropTitle_lbl);

	v.uPropName_f = Ti.UI.createTextField(tFieldProps);
	v.uPropName_f.hintText = 'Name';
	v.uPropBox_v.add(v.uPropName_f);

	v.uPropValue_f = Ti.UI.createTextField(tFieldProps);
	v.uPropValue_f.hintText = 'Value';
	v.uPropBox_v.add(v.uPropValue_f);	
	
	v.setUPropBtn = Ti.UI.createButton({
		title: 'Set property',
		with: Ti.UI.SIZE, height: Ti.UI.SIZE
	});
	v.uPropBox_v.add(v.setUPropBtn);
	
	addEvents(v);
	return(v);
}

function addEvents(v){
	v.createByEmailBtn.addEventListener('click', createUserWithEmailCb);
	v.signInByEmailBtn.addEventListener('click', signInWithEmailCb);
	v.signOutBtn.addEventListener('click', signOutCb);
	
	v.currentUserBtn.addEventListener('click', function(e){
		alert(JSON.stringify(_tFireb.FIRAuth.currentUser));
	});
	
	v.logEventBtn.addEventListener('click', logEventWithNameCb);
	v.setUPropBtn.addEventListener('click', setUPropBtnCb);
}

function createUserWithEmailCb(e){
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
}
function signInWithEmailCb(e){
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
}
function signOutCb(e){
	_tFireb.FIRAuth.signOut({
		'success': function(data){
			alert(JSON.stringify(data));
		},
		'error': function(data){
			alert(JSON.stringify(data));
		}
	});
}
function logEventWithNameCb(e){
	
	var name = _v.evtName_f.value;
	var keys = _v.evtKeys_f.value;
	var values = _v.evtValues_f.value;
	//build key value for parameters
	var aKeys = keys.split('|');
	var aVals = values.split('|');
	if(aKeys.length == 0 || (aKeys.length != aVals.length)){
		alert('Event key/values count does not match!');
		return;
	}
	var paramData = {};
	for(var idx in aKeys){
		paramData[aKeys[idx]] = aVals[idx];
	}
	
	var logParams = {
		'name': name,
		'parameters': paramData
	};
	//Ti.API.info("Sending logEvtData", logParams);
	_tFireb.FIRAnalytics.logEventWithName(logParams);
	alert("Sent Event Data:\n" + JSON.stringify(logParams));
}

function setUPropBtnCb(e){
	
	var name = _v.uPropName_f.value;
	var value = _v.uPropValue_f.value;
	var setParams = {
		'name': name,
		'value': value
	}; 
	_tFireb.FIRAnalytics.setUserPropertyString(setParams);
	alert("Set user property data:\n" + JSON.stringify(setParams) + " for user:" + JSON.stringify(_tFireb.FIRAuth.currentUser));
}
