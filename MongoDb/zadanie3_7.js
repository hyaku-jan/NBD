db.people.remove('this.height > 190')
printjson(db.people.find('this.height > 190').toArray())
