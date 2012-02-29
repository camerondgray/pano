var hugin  = require('./hugin.js');
var pano = module.exports;
    pano.makePano = function (inputFolder,callback){
        hugin.makePanoFromFolder(inputFolder,function(result){
            callback(result);
        })

    };

