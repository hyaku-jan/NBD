// zadanie 1:
MATCH (movie:Movie) RETURN movie

//zadanie 2:
MATCH (movie:Movie)<-[:ACTED_IN]-(:Person{name: "Hugo Weaving"}) RETURN movie

//zadanie 3:
MATCH (director:Person)-[:DIRECTED]->(:Movie)<-[:ACTED_IN]-(:Person{name: "Hugo Weaving"}) RETURN director

//zadanie 4:
MATCH (actor:Person)-[:ACTED_IN]->(movie:Movie)<-[:ACTED_IN]-(:Person{name: "Hugo Weaving"}) RETURN actor,movie

//zadanie 5:
MATCH (:Movie{title:"The Matrix"})<-[:ACTED_IN]-(person:Person)-[:ACTED_IN]->(movie:Movie) RETURN movie,person

//zadanie 6:
MATCH (actor:Person)-[m:ACTED_IN]->(:Movie) RETURN a, count(m) as movie_count

//zadanie 7: 
MATCH (screenwriter:Person)-[:WROTE]->(movie:Movie)<-[:DIRECTED]-(director:Person) WHERE screenwriter=director RETURN screenwriter,movie,director

//zadanie 8:
MATCH (:Person{name: "Keanu Reeves"})-[:ACTED_IN]->(movies:Movie)<-[:ACTED_IN]-(:Person{name: "Hugo Weaving"}) RETURN movies

//zadanie 9:
CREATE (CapAmerica:Movie{title:"Captain America: The First Avenger", released:2011})
CREATE (Joe:Person{name:"Joe Johnston", born:1950})
CREATE (ChrisM:Person{name:"Christopher Markus", born:1970})
CREATE (StephM:Person{name:"Stephen McFeely", born:1969})
CREATE (ChrisE:Person{name:"Chris Evans", born:1981})
CREATE (Samuel:Person{name:"Samuel L. Jackson", born:1948})
WITH CapAmerica, Joe, ChrisM, StephM, ChrisE, Samuel
MATCH (Hugo:Person{name: "Hugo Weaving"}) 
CREATE 
(Hugo)-[:ACTED_IN]->(CapAmerica),//Hugo Weaving juz w bazie
(Joe)-[:DIRECTED]->(CapAmerica),
(ChrisM)-[:WROTE]->(CapAmerica),
(StephM)-[:WROTE]->(CapAmerica),
(ChrisE)-[:ACTED_IN]->(CapAmerica),
(Samuel)-[:ACTED_IN]->(CapAmerica)
/////////////////////////////////////////////////////////////////////////////////
MATCH (people:Person)-[:WROTE|:ACTED_IN|:DIRECTED]->(captain:Movie{title:"Captain America: The First Avenger"}) return people, captain
