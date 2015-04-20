var Profile = require('./profile.js');
var renderer = require('./renderer.js');
var queryString = require('querystring');
var commonHeaders = {'Content-Type': 'text/html'};

function home(request, response){
	if(request.url === "/" ) {
		if(request.method.toLowerCase() === "get"){
			// show search
			response.writeHead(200, commonHeaders);
			renderer.view("header", {}, response);
			renderer.view("search", {}, response);
		  renderer.view("footer", {}, response);
		  response.end();
		} else {
			// if url "/" && POST
			request.on("data", function(postBody){
				var query = queryString.parse(postBody.toString());
				response.writeHead(303, {"Location": "/" + query.username });
				response.end();
			})
		}
	}
}

function user(request, response){
	var username = request.url.replace("/", "")
	if(username.length > 0){
		response.writeHead(200, commonHeaders);
		renderer.view("header", {}, response);
		var studentProfile = new Profile(username);
		studentProfile.on("end", function(profileJSON){
			// show profile
			// store the values which we need
			var values = {
				avatarUrl: profileJSON.gravatar_url,
				username: profileJSON.profile_name,
				badges: profileJSON.badges.length,
				javascriptPoints: profileJSON.points.JavaScript
			};
			// Simple response
		renderer.view("profile", values, response);
	  renderer.view("footer", {}, response);
		response.end();
		});
		// on error..
		studentProfile.on("error", function(error){
			renderer.view("error", {errorMessage: error.message}, response);
			renderer.view("search", {}, response);
	  	renderer.view("footer", {}, response);
	  	response.end();
		});
	}
}


module.exports.home = home;
module.exports.user = user;