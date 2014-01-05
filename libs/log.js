/**
 * 多种颜色打印控制台日志，便于调试
 * @date 2013.12.21
 * @author xuhua
 * @quote: NJBlog
 */
require("colors");
var slice = Array.prototype.slice;
exports.create = function (message) {
    var args = slice.call(arguments);
    args[0] = "Create:".green.inverse + message.green;
    console.log.apply(console, args);
};

exports.patch = function (message) {
    var args = slice.call(arguments);
    args[0] = "Patch:".blue.inverse + message.blue;
    console.log.apply(console, args);
};

exports.warn = function (message) {
    var args = slice.call(arguments);
    args[0] = "Warn:".yellow.inverse + message.yellow;
    console.log.apply(console, args);
};

exports.error = function (message) {
    var args = slice.call(arguments);
    args[0] = "Error:".red.inverse + message.red;
    console.log.apply(console, args);
};

exports.success = function (message) {
    var args = slice.call(arguments);
    args[0] = "Success:".green.inverse + message.green;
    console.log.apply(console, args);
};

exports.version = function (message) {
    var args = slice.call(arguments);
    args[0] = "Version:".green.inverse + message.green;
    console.log.apply(console, args);
};

exports.title = function (message) {
    var args = slice.call(arguments);
    args[0] = "Title:".green.inverse + message.green;
    console.log.apply(console, args);
};