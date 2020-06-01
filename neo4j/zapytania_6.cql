//zadanie 1:
MATCH routes=shortestPath((:town{name:"Darjeeling"})-[*]->(:peak{name:'Sandakphu'})) RETURN routes

//zadanie 2:
MATCH routes=shortestPath((:town{name:"Darjeeling"})-[*]->(:peak{name:'Sandakphu'})) WHERE ALL(xr IN RELATIONSHIPS(routes) WHERE xr.winter='true') RETURN routes

//zadanie 3: dopytać

//a:
MATCH path= (:town{name:"Darjeeling"})-[*]->(b:peak{name:'Sandakphu'}) WITH path UNWIND RELATIONSHIPS(path) AS pr RETURN DISTINCT path, sum(pr.distance) AS dst ORDER BY dst
//b:
MATCH path= (:town{name:"Darjeeling"})-[:twowheeler*]->() WHERE ALL(xr IN RELATIONSHIPS(path) WHERE xr.summer='true')RETURN path