printjson(db.people.aggregate([{$project:{h:{$toDouble:"$height"},w:{$toDouble:"$weight"}, sex:1 }},{$group:{_id:{sex:"$sex"}, avgH:{$avg:"$h"}, avgW:{$avg:"$w"}}}]).toArray())
