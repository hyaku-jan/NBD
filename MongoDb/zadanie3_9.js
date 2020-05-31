print('Docs with first_name:Antonio, and their hobbies')
printjson(db.people.find({'first_name':'Antonio'},{'_id':1, 'hobby':1}).toArray())
db.people.updateMany({'first_name':'Antonio'},{'$set':{'hobby':'pingpong'}})
print('Docs with first_name:Antonio, and their hobbies after update')
printjson(db.people.find({'first_name':'Antonio'},{'_id':1, 'hobby':1}).toArray())


