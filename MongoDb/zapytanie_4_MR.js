db.people.mapReduce(function(){var bmi = ((1.0*this.weight)/(0.01*(this.height)^2)); emit(this.nationality, {'min': bmi, 'max': bmi, 'avg':bmi, 'cnt':1});}, function(k,v){
    var a = v[0]; 
    for (var i=1/*!*/; i < v.length; i++){
        var b = v[i]; 

        a.avg += b.avg;
        a.cnt += b.cnt;
        a.min = Math.min(a.min, b.min);
        a.max = Math.max(a.max, b.max);
    }
return a;
},{
    query:{},
    out:"MR_zd4",
    finalize:function(k,v){
        v.avg = v.avg/v.cnt;

        return {'min': v.min, 'max':v.max, 'avg':v.avg};
    }})
printjson(db.MR_zd4.find({}).toArray())
