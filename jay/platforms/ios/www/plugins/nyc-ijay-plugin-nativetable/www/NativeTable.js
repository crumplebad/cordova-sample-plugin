cordova.define("nyc-ijay-plugin-nativetable.NativeTable", function(require, exports, module) {
var exec = require('cordova/exec');

//exports.test = function(arg0, success, error) {
//    exec(success, error, "NativeTable", "test", [arg0]);
//};

exports.createTable = function(arg0, , height, success, error) {
    exec(success, error, "NativeTable", "createTable", [arg0, height]);
};

});
