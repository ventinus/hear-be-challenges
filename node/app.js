// Problem: we need a simple way to look at a users badge count and JavaScript points from the web browser
// Solution: use nodejs to perform the profile lookups and serve our templates via HTTP



// Plan: 1. create a Web Server
var router = require('./router.js');
var http = require('http');
http.createServer(function (request, response) {
 	router.home(request, response);
 	router.user(request, response);

  // response.end('Hello World\n');
}).listen(3000);
console.log('Server running at http://localhost:3000/');

// 2. Handle HTTP route GET / and POST / 


	// if url == "/...."
		// get JSON feed
			 // on "end" - show profile
			 // on "error" - show error


