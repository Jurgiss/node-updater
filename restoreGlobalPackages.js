var exec = require('child_process').exec;
var fs = require('fs');

var packageListCmd = 'npm install -g '

fs.readFile('consoleOutput.txt', function(err, data){
  var npmCommand = packageListCmd + data;
  console.log(npmCommand);
  exec(npmCommand, function(err, stdOut, stdErr){
    if (err){
      console.log('Error restoring packages!');
      console.log(err, stdOut, stdErr);
    }
  });
});
