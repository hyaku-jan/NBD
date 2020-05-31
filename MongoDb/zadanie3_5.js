printjson(db.people.find("new Date(this.birth_date) >= new Date('2001-01-01T00:00:00Z')",{'first_name':1, 'last_name':1, 'location.city':1 }).toArray())
