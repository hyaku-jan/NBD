print('Docs with "Moscow"')
printjson(db.people.find({'location.city':'Moscow'},{'_id':1}).toArray())
db.people.updateMany({'location.city':'Moscow'},{'$set':{'location.city':'Moskwa'}})
print('Docs with "Moskwa"')
printjson(db.people.find({'location.city':'Moskwa'},{'_id':1}).toArray())

