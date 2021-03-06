var fs = require('fs')
    , page = require('webpage').create()
    , t
    , address=phantom.args[0]
    , requests={}
    , responses={}
    , pageInfo={url:address, assets:[]};

if (phantom.args.length === 0) {
    console.log('Usage: speedreport.js <URL>');
    phantom.exit();
}
page.onResourceRequested = function (r) {
    if(r)requests[r.id]=r;
};
page.onResourceReceived = function (r) {
    if(r && !(r.id in responses)){
        responses[r.id]=r;
    } else {
        for(var i in responses[r.id]){
            if(responses[r.id].hasOwnProperty(i) && !(i in r)){
                r[i]=responses[r.id][i];
            }
        }
        r.received=responses[r.id].time;
        pageInfo.assets.push({
            request:requests[r.id],
            response:r
        });
    }
};
page.onError=function(){
    console.error("error");
    console.dir(arguments);
}
t = Date.now();
page.open(address, function (status) {
    pageInfo.requestTime=t;
    pageInfo.responseTime=Date.now();
    if (status !== 'success') {
        console.error('/* FAIL to load the address */');
    } else {
        t = Date.now() - t;
        try {
            var data=JSON.stringify(pageInfo, undefined, 4)
            printToFile(data);
        }catch(e){
            console.error("error writing to file ",e);
        }
    }
    phantom.exit();
});

function printToFile(data) {
    var f
        , g
        , html
        , myfile
        , fileid
        , myjson
        , jspath
        , keys = []
        , values = []
        , extension = 'html';

    if(!phantom.args[1]){
        fileid = phantom.args[0].replace('http://','').replace('https://','').replace(/\//g,'');
        fileid = fileid.split('?')[0];
    }else{
        fileid = phantom.args[1];
        myjson = fileid;
    }
    myjson = 'reports/'+fileid+'/data.js';
    myfile = 'reports/'+fileid+'/index.' + extension;

    if(myfile!==null){
        try {
            data = "var reportdata = " + data + ";";
        if(fs.exists(myfile)){
            fs.remove(myfile);
        }
            if(!fs.exists('speedreport.html')){
                html = fs.read('travis/loadreport/speedreport.html');
            }else{
                html = fs.read('speedreport.html');
            }
            html=html.replace('{{REPORT_DATA_URI}}', 'data.js');
            html=html.replace('{{url}}', phantom.args[0]);
            f = fs.open(myfile, "w");
            f.write(html);
            f.flush();
            f.close();
        } catch (e) {
            console.log("problem writing to file",e);
        }
    }

    try {
        g = fs.open(myjson, "w");
        g.write(data);
        g.flush();
        g.close();
    } catch (e) {
        console.error("problem writing to file",e);
    }
}

