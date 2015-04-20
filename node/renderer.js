var fs = require('fs');
// fs stands for filesystem

function mergeValues(values, content){
// cycle over the keys
// replace all {{key}} with the values from teh values object
	for(var key in values) {
		content = content.replace("{{" + key + "}}", values[key])
	}
	// return merged content
	return content;
}

function view(templateName, values, response){
	// read from the template files, 
	var fileContents = fs.readFileSync('./views/' + templateName + '.html', {encoding: "utf8"});
	// insert values into the content, 
	fileContents = mergeValues(values, fileContents);
	// write out to the response
	response.write(fileContents);
}

module.exports.view = view;