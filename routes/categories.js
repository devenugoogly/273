/**
 * New node file
 */
var ejs = require("ejs");
var customMysql = require("./mysql");

exports.product = function(req,res)
{
	ejs.renderFile('./views/product.ejs',{session:req.session},function(err, result){
		  if (!err) {
	          res.end(result);
	      }
	      else {
	          res.end('An error occurred');
	          console.log(err);
	      }
	  });	
}


exports.category = function(req,res)
{
	var id = req.params.id;
	var categoryType;
	if(id == 324)
		categoryType = 'Mobiles / Tablets';
	else if(id == 325)
		categoryType = 'Computer / Laptops';
	else if(id == 326)
		categoryType = 'TV';
	else if(id == 327)
		categoryType = 'Cameras';
	else if(id == 328)
		categoryType = 'Cds / Dvds';
	else if(id == 329)
		categoryType = 'Accessories';
	else
		categoryType = 'Others';
	
	console.log("id is "+id);
	customMysql.get_products_for_category(id, function(err, products) {
		if(products.length > 0){
			var jsonString = JSON.stringify(products);
			var productCatalogs = JSON.parse(jsonString);
			ejs.renderFile('./views/categories.ejs',{session:req.session,category:categoryType,productCatalog:productCatalogs},function(err, result){
			if (!err) {
	          res.end(result);
			}
			else {
	          res.end('An error occurred');
	          console.log(err);
			}
			});
		}
	});
}