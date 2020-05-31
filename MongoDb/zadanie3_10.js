print('Docs with job:Editor, and their emails')
printjson(db.people.find({'job':'Editor'},{'_id':1, 'email':1}).toArray())
db.people.updateMany({'job':'Editor'},{'$unset':{'email':''}})
print('Docs with job:Editor, and their emails after update')
printjson(db.people.find({'job':'Editor'},{'_id':1, 'email':1}).toArray())


