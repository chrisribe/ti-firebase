var fs = require('fs');
var _ = require('underscore');
var xml2js = require('xml2js');

var parser = new xml2js.Parser();
var list = _.filter(fs.readdirSync('.'), function(file) {
    return fs.statSync(file).isDirectory() && fs.existsSync(file+"/AndroidManifest.xml") && fs.statSync(file+"/AndroidManifest.xml").isFile() && fs.existsSync(file+"/classes.jar") ;
});

list.forEach(function(folder) {
    var xml = fs.readFileSync(folder+"/AndroidManifest.xml");
    parser.parseString(xml, function (err, result) {
            var packageName = result.manifest.$.package;
            fs.renameSync(folder+"/classes.jar", packageName+"-9.4.0.jar");
        });

});

//list = list.map(fs.statSync);

console.log(list);
