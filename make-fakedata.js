require('iced-coffee-script')
var fakeData = require('./lib/fakedata');
var db = require('./lib/database');

fakeData.populateDatabase({
	clearExistingData: true
}, function(err) {
	db.close();
});

