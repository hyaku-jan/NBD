db.people.mapReduce(function(){for(var card of this.credit){emit(card.currency, card.balance*1.0);}}, function(k,v){return Array.sum(v)},{query:{},out:"MR_zd2"})
printjson(db.MR_zd2.find({}).toArray())
