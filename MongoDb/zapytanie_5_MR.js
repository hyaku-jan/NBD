db.people.mapReduce(
    function(){for(var card of this.credit){emit(card.currency, {'sum':card.balance*1.0, 'avg':1});}}, 
    function(k,v){
        var a = v[0]; 
        for (var i=1/*!*/; i < v.length; i++){
            var b = v[i];     
            a.sum += b.sum;
            a.avg += b.avg;
        }
    return a;
    },
    {query:{"nationality": "Poland", "sex":"Female"},out:"MR_zd5",
    finalize:function(k,v){
        v.avg = v.sum/v.avg;

        return {'sum': v.sum, 'avg':v.avg};
    }})
printjson(db.MR_zd5.find({}).toArray())
