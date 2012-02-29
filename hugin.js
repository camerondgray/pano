var spawn = require('child_process').spawn;
var hugin = module.exports;

hugin.makePanoFromFolder = function(foldername,callback){

    //create the panotools makefile
    var panostart = spawn(__dirname +'/pano.sh',[foldername]);
    console.log('Spawned panostart pid: ' + panostart.pid);
    panostart.stdout.on('data', function(data){
        console.log('panostart stdout:' + data);
    });
    panostart.stderr.on('data', function(data){
        console.log('panostart stderr:' + data);
    });
    panostart.on('exit', function(){
        //run the make file
        var make = spawn('make',['-f', 'ptest'],{ cwd: foldername });
        console.log('Spawned make pid: ' + make.pid);
        make.stdout.on('data', function(data){
           console.log('make stdout:' + data);
        });
        make.stderr.on('data', function(data){
            console.log('make stderr:' + data);
        });
        make.on('exit', function(){
            callback('foo');
        })

    })


}