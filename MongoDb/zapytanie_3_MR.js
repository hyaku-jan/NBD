db.people.mapReduce(function(){emit(this.job, true);}, function(k,v){},{query:{},out:"MR_zd3"})
printjson(db.MR_zd3.find({}).toArray())
