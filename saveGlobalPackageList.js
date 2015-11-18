var exec = require('child_process').exec;
var fs = require('fs');

var packageListCmd = 'npm ls -g -depth 0'

function parsePackages(npmPackageString){
  var matcherRegExp = /[a-z]*@[0-9].[0-9].[0-9]/ig;
  var packages = npmPackageString.match(matcherRegExp);

  return packages.join(' ');
}

exec(packageListCmd, function(err, stdOut, stdErr){
  var packageList = parsePackages(stdOut);
  fs.writeFile('consoleOutput.txt', packageList);
});
