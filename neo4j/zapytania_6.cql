//zadanie 1:
MATCH routes=shortestPath((:town{name:"Darjeeling"})-[*]->(:peak{name:'Sandakphu'})) RETURN routes

//zadanie 2:
MATCH routes=shortestPath((:town{name:"Darjeeling"})-[*]->(:peak{name:'Sandakphu'})) WHERE ALL(xr IN RELATIONSHIPS(routes) WHERE xr.winter='true') RETURN routes

//zadanie 3:

//a:
MATCH path= (:town{name:"Darjeeling"})-[*]->(b:peak{name:'Sandakphu'}) WITH path UNWIND RELATIONSHIPS(path) AS pr RETURN DISTINCT path, sum(pr.distance) AS dst ORDER BY dst
//b:
MATCH path= (:town{name:"Darjeeling"})-[:twowheeler*]->() WHERE ALL(xr IN RELATIONSHIPS(path) WHERE xr.summer='true')RETURN path
//Pusty wynik, brak eksportu


// Dodanie pomocniczych powiązań. Będą wykorzystywane w kolejnych punktach
MATCH (o:Airport)<-[:ORIGIN]-(f:Flight)-[:DESTINATION]->(d:Airport)
MATCH (f)<-[:ASSIGN]-(t:Ticket)
CREATE (o)-[rf:FLIGHT{class:t.class, price:t.price, operator:f.airline}]->(d)
RETURN rf

//zadanie 4:
MATCH (a:Airport)<-[:ORIGIN]-(f:Flight) RETURN a, count(f) AS flights ORDER BY flights DESC

//zadanie 5:
MATCH (o:Airport {name: "LAX"})
CALL apoc.path.expandConfig(o, {minLevel:1, maxLevel:-1, relationshipFilter: "FLIGHT>", labelFilter:">Airport", uniqueness: "RELATIONSHIP_GLOBAL"})
YIELD path
WITH REDUCE(c = 0,r in  RELATIONSHIPS(path) | c + r.price) as cost, path
WHERE cost <3000
RETURN last(nodes(path)) as destenation, cost ORDER BY cost DESC

//Zadanie 6:
MATCH (q:Airport {name: "DAY"})
MATCH (w:Airport {name: "LAX"})
CALL apoc.path.expandConfig(q, {minLevel:1, maxLevel:-1, relationshipFilter: "FLIGHT<", uniqueness: "RELATIONSHIP_PATH", endNodes:w})
YIELD path
WITH REDUCE(c = 0,r in  RELATIONSHIPS(path) | c + r.price) as cost, path
RETURN path, cost ORDER BY cost DESC
//Pusty wynik, brak eksportu

//zadanie 7:
MATCH (q:Airport {name: "DAY"})
MATCH (w:Airport {name: "LAX"})
CALL apoc.path.expandConfig(q, {minLevel:1, maxLevel:-1, relationshipFilter: ">ORIGIN|DESTINATION<", uniqueness: "RELATIONSHIP_PATH", endNodes:w})
YIELD path
WITH REDUCE(s = 0, n IN [x IN NODES(path) WHERE 'Flight' IN LABELS(x)] |
  s + apoc.coll.min([(n)<-[:ASSIGN]-(ticket) | ticket.price])
  ) AS cost, path
RETURN path, cost
ORDER BY cost LIMIT 1
//Pusty wynik, brak eksportu

//zadanie 8:
MATCH (q:Airport {name: "DAY"})
MATCH (w:Airport {name: "LAX"})
CALL apoc.path.expandConfig(q, {minLevel:1, maxLevel:-1, relationshipFilter: ">ORIGIN|DESTINATION<", uniqueness: "RELATIONSHIP_PATH", endNodes:w})
YIELD path
WITH REDUCE(s = 0, n IN [x IN NODES(path) WHERE 'Flight' IN LABELS(x)] |
  s + apoc.coll.min([(n)<-[:ASSIGN]-(ticket) WHERE ticket.class = 'business' | ticket.price])
  ) AS cost, path
RETURN path, cost
ORDER BY cost LIMIT 1
//Pusty wynik, brak eksportu

//zadanie 9:
// Nie mam pomysłu :(

//Zadanie 10:
MATCH path= (o:Airport)-[:FLIGHT]->(l1:Airport)-[:FLIGHT]->(d:Airport)
WHERE o<>l1 AND o<>d AND l1<>d
WITH REDUCE(c = 0,r in  RELATIONSHIPS(path) | c + r.price) as cost, path
RETURN path, cost
ORDER BY cost LIMIT 1