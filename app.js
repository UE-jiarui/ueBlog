require('coffee-script');
var express = require("express"),
		routes = require("./routes/routes"),
		mongoose = require('mongoose'),
		config = require('./config'),
		fs = require('fs'),
		log = require('./libs/log'),
    msg = require('./libs/msg'),
    dbSuccess = msg.DB.success,
    dbError = msg.DB.error;
 
var app = express();
app.use(express.logger());

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/app');
  app.set('view engine', 'html');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser('your secret here'));
  app.use(express.session());
  app.use(express.static(__dirname + '/app'));
  app.use(app.router);
});

// Connect DB
mongoose.connect(config.db.CONNECT_STRING);
db = mongoose.connection;
db.on('error', function(err){
    log.error(dbError, err.message);
    process.exit(1);
});
db.once('open', function callback () {
  log.success(dbSuccess);
}); 

// Models
var models_path = __dirname + '/models';
var walk = function(path) {
    fs.readdirSync(path).forEach(function(file) {
        var newPath = path + '/' + file;
        var stat = fs.statSync(newPath);
        if (stat.isFile()) {
            if (/(.*)\.(js$|coffee$)/.test(file)) {
              require(newPath);
            }
        } else if (stat.isDirectory()) {
            walk(newPath);
        }
    });
};
walk(models_path);

routes(app);

var port = process.env.PORT || 5000;
app.listen(port, function() {
  log.success("UEBlog is listening on " + port);
});