db.people.mapReduce(function(){emit(this.sex, {w:this.weight*1.0, h:this.height*1.0, c:1});}, 
function(k,v){
    var a = v[0]; 
    for (var i=1/*!*/; i < v.length; i++){
        var b = v[i];     
        a.w += b.w;
        a.h += b.h;
        a.c += b.c;
    }
return a;
},
{query:{},out:"MR_zd1",
finalize:function(k,v){
    v.w = v.w/v.c;
    v.h = v.h/v.c;
    return {'avgH': v.h, 'avgW':v.w};
}})
printjson(db.MR_zd1.find({}).toArray())
