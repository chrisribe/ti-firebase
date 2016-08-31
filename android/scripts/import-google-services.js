var opath = require("object-path");
var _ = require("underscore");
var fs = require("fs");

var template1 = _.template('<?xml version="1.0" encoding="utf-8"?>\n' +
    '<resources>\n' +
    '    <! -- Present in all applications -->\n' +
    '    <string name="google_app_id" translatable="false"><%=google_app_id%></string>\n' +
    '    <! -- Present in applications with the appropriate services configured -->\n' +
    '    <string name="gcm_defaultSenderId" translatable="false"><%=gcm_defaultSenderId%></string>\n' +
    '    <string name="default_web_client_id" translatable="false"><%=default_web_client_id%></string>\n' +
    '    <string name="ga_trackingId" translatable="false"><%=ga_trackingId%></string>\n' +
    '    <string name="firebase_database_url" translatable="false"><%=firebase_database_url%></string>\n' +
    '    <string name="google_api_key" translatable="false"><%=google_api_key%></string>\n' +
    '    <string name="google_crash_reporting_api_key" translatable="false"><%=google_crash_reporting_api_key%></string>\n' +
    '</resources>');

var template2 = _.template('<?xml version="1.0" encoding="utf-8"?>\n' +
    '<resources>\n' +
    '    <string name="ga_trackingId" translatable="false"><%=ga_trackingId%></string>\n' +
    '</resources>');


var json = require('./google-services.json');

var cid = 0;
var aid = 0;
var values = {
    google_app_id: opath.get(json, "client." + cid + ".client_info.mobilesdk_app_id"),
    gcm_defaultSenderId: opath.get(json, "project_info.project_number"),
    default_web_client_id: opath.get(json, "client." + cid + ".oauth_client." + cid + ".client_id"),
    ga_trackingId: opath.get(json, "client." + cid + ".services.analytics-service.analytics_property.tracking_id"),
    firebase_database_url: opath.get(json, "project_info.firebase_url"),
    google_api_key: opath.get(json, "client." + cid + ".api_key." + aid + ".current_key"),
    google_crash_reporting_api_key: opath.get(json, "client." + cid + ".api_key." + aid + ".current_key"),
};


var xml1 = template1(values);
var xml2 = template2(values);


fs.writeFileSync("values.xml", xml1);
console.log("values.xml -> ");
fs.writeFileSync("global_tracker.xml", xml2);
