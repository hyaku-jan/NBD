//zadanie 1:
MATCH routes=shortestPath((:town{name:"Darjeeling"})-[*]->(:peak{name:'Sandakphu'})) RETURN routes

//zadanie 2:
MATCH routes=shortestPath((:town{name:"Darjeeling"})-[*]->(:peak{name:'Sandakphu'})) WHERE ALL(xr IN RELATIONSHIPS(routes) WHERE xr.winter='true') RETURN routes

//zadanie 3: dopytać

//a:
MATCH path= (:town{name:"Darjeeling"})-[*]->(b:peak{name:'Sandakphu'}) WITH path UNWIND RELATIONSHIPS(path) AS pr RETURN DISTINCT path, sum(pr.distance) AS dst ORDER BY dst
//b:
MATCH path= (:town{name:"Darjeeling"})-[:twowheeler*]->() WHERE ALL(xr IN RELATIONSHIPS(path) WHERE xr.summer='true')RETURN path

//zadanie 4:
MATCH ()-[origin:ORIGIN]->(airport:Airport) RETURN airport, count(origin) as origins ORDER BY origins
MATCH (a:Airport)<-[:ORIGIN]-(f:Flight) RETURN a, count(f) AS flights ORDER BY flights DESC

//zadanie 5:
MATCH path = (origin:Airport { name:"LAX" })<-[:ORIGIN|DESTINATION*..7]->(destination:Airport)
WITH *, [x IN nodes(path) WHERE 'Flight' IN LABELS(x)] AS flights
UNWIND flights AS flightx
WITH DISTINCT flightx AS flight, path
MATCH (flight)-[:ASSIGN]-(t:Ticket)
WITH path, min(t) AS ct
RETURN path, collect(ct) AS dupa


MATCH path = (origin:Airport { name:"LAX" })<-[:ORIGIN]-(flight:Flight)<-[:DESTINATION|ORIGIN]->(destenation:Flight)
WHERE REDUCE(s = 0, n IN [x IN NODES(path) WHERE 'Flight' IN LABELS(x)] |
  s + [(n)<-[:ASSIGN]-(ticket) | ticket.price][0]
  ) < 3000
RETURN path

MATCH path = (origin:Airport { name:"LAX" })<-[:ORIGIN]-(flight:Flight)<-[:ORIGIN|DESTINATION*..5]->(destination:Airport)
WHERE origin<>destination
RETURN path


MATCH path = (origin:Airport { name:"LAX" })<-[:ORIGIN]-(flight:Flight)<-[:ORIGIN|DESTINATION*..3]->(destination:Airport)
WHERE origin<>destination
UNWIND nodes(path) AS nod
RETURN collect(DISTINCT nod)

MATCH path = (origin:Airport { name:"LAX" })<-[:ORIGIN]-(flight:Flight)<-[:DESTINATION|ORIGIN]->(destenation:Airport)
WHERE origin<>destenation AND REDUCE(s = 0, n IN [x IN NODES(path) WHERE 'Flight' IN LABELS(x)] |
  s + apoc.coll.min([(n)<-[:ASSIGN]-(ticket) | ticket.price])
  ) < 3000
RETURN path


MATCH (p:Airport {name: "LAX"})
CALL apoc.path.expand(p, "ORIGIN>|DESTINATION<", ">Airport", 1, 3)
YIELD path
RETURN path, length(path) AS hops
ORDER BY hops;

MATCH (p:Airport {name: "LAX"})
CALL apoc.path.expandConfig(p, {minLevel:1, maxLevel:10, relationshipFilter: "ORIGIN<|>DESTINATION", labelFilter:">Airport", uniqueness: "NODE_GLOBAL"})
YIELD path
WHERE REDUCE(s = 0, n IN [x IN NODES(path) WHERE 'Flight' IN LABELS(x)] |
  s + apoc.coll.min([(n)<-[:ASSIGN]-(ticket) | ticket.price])
  ) < 3000
return path, length(path) as q
order by q desc


MATCH (p:Airport {name: "LAX"})
CALL apoc.path.expandConfig(p, {minLevel:1, maxLevel:-1, relationshipFilter: "ORIGIN<|>DESTINATION", labelFilter:">Airport", uniqueness: "RELATIONSHIP_GLOBAL"})
YIELD path
WITH REDUCE(s = 0, n IN [x IN NODES(path) WHERE 'Flight' IN LABELS(x)] |
  s + apoc.coll.min([(n)<-[:ASSIGN]-(ticket) | ticket.price])
  ) AS cost, path
WHERE cost < 3000
RETURN path, cost
ORDER BY cost DESC

//Zadanie 6 ????:
MATCH (q:Airport {name: "DAY"})
MATCH (w:Airport {name: "MOT"})
CALL apoc.path.expandConfig(q, {minLevel:1, maxLevel:-1, relationshipFilter: ">ORIGIN|DESTINATION<", uniqueness: "RELATIONSHIP_PATH", endNodes:w})
YIELD path
RETURN path

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

//zadanie 9?????:
