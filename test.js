var axios = require("axios");
var fs = require("fs");

async function getData(){
    for(var i = 4136; i <= 6666; i++){
        var getFile = await axios.get('https://ipfs.io/ipfs/QmQsTrkFptdGH9SfaLrYixCWBptqME2xqG4dPbQRFF3FuC/' + i + '.json') 
        var json = JSON.stringify(getFile.data)
        fs.writeFileSync(`./json/${i}.json`, json, 'utf8');
    }
}

getData()