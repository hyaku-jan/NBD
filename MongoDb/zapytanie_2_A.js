printjson(db.people.aggregate([{$unwind:{path:"$credit"}},{$project:{curr:"$credit.currency", val:{$toDouble:"$credit.balance"}}},{$group:{_id:{currency:"$curr"},value:{$sum:"$val"}}}]).toArray())
