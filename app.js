
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , user = require('./routes/user')
  , http = require('http')
  , url = require('url')
  , mysql = require('./routes/mysql')
  , path = require('path')
  , categories = require('./routes/categories')
  ,ejs= require('ejs');

var app = express();

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.cookieParser());
app.use(express.session({secret:'abcd'}));
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);
app.get('/index', routes.index);
app.get('/users', user.list);
app.get('/signin',routes.signin); // redirects to signin page
app.post('/login', routes.login); // signs in by performing db read and update
app.get('/logout', routes.logout); // logout and display logout page
app.get('/signup',routes.signup); //redirects to signup page
app.post('/signup',routes.register) //signs up a new user by performing db update
app.get('/profile',routes.profile) //signs up a new user by performing db update
app.get('/categories/:id',categories.category) //handles and displays products related to give category id
app.get('/sellers',user.seller) //get all sellers of the system
app.get('/seller/:id',user.sellerprofile)//returns a seller profile+reviews+products sold when a userid is passed.
app.get('/search',categories.search) //get the product searched by user
app.get('/add_product',routes.addproduct);
app.post('/add_product',routes.addproducts);
app.get('/product/:prodId',categories.product) //handles and displays particular product
app.get('/auction',routes.auction)//get all auctions and display on auction page
app.get('/addtocart/:prodId',categories.addtocart);
app.get('/getbid/:prodId',categories.getbid);
app.post('/addbid/:prodId',categories.addbid);
app.get('/getcart',user.getcart);
app.get('/checkout',user.checkout);
app.post('/addreview/:id',routes.addreview);
app.post('/profile',routes.editprofile);
app.get('/deletereview',routes.deletereview);
app.get('/contact',routes.index);
app.get('/deletefromcart',routes.deletefromcart)
//app.get('*',function(req,res){
//	ejs.renderFile('./views/error.ejs', function(err, result){
//		  if (!err) {
//		          res.end(result);
//		      }
//		      else {
//		          res.end('An error occurred');
//		          console.log(err);
//		      }
//		  });
//		});

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
