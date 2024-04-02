//Initiallising node modules
var express = require("express");
var bodyParser = require("body-parser");
var mysql = require("mysql");
//var swaggerJsdoc = require('swagger-jsdoc');
var swaggerUi = require('swagger-ui-express');
var swaggerDocument = require('./swagger-output.json'); // Assuming you have a Swagger definition in a file called swagger.json
var app = express(); 

// Body Parser Middleware
app.use(bodyParser.json()); 

//CORS Middleware
app.use(function (req, res, next) {
    //Enabling CORS 
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, contentType,Content-Type, Accept, Authorization");
    next();
});

// Swagger configuration
const swaggerOptions = {
  swaggerDefinition: {
    info: {
      title: 'Swagger documentation for GBCC',
      description: 'Documentation for GBCC App by Dino Gomezel',
      version: '1.0.0',
    },
  },
  // Specify the paths to API routes
  //apis: ['./routes/*.js'],
  //apis: ['server.js'],
  apis: ['./routes/*.js'],
};

//Setting up server
 var server = app.listen(process.env.PORT || 9080, function () {
    var port = server.address().port;
    console.log("App now running on port", port);
 });

//Initiallising connection string
var sql = mysql.createConnection({
  host     : '192.168.0.9',
  user     : 'gbcc',
  password : 'SuperZiherPass202X!',
  database : 'gbcc'
});

//Function to connect to database and execute query
var  executeQuery = function(res, query){             
//     sql.connect();
     sql.query(query, function (err, results, fields) {
                           if (err) {
                                      console.log("Error while querying database :- " + err);
                                      res.send(err);
                                     }
                                     else 
									 {
                                      res.send(results);
                                     }
                               }); 
};

// Swagger
//const swaggerDocs = swaggerJsdoc(swaggerOptions);
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));


//GET API
//app.get("/api//:card/", function(req , res){
//                var query = 'select count(BDGNO) as USEROK from [USER_BADGES] where BDGNO = ' + req.params.card;

// GAMES -------------------------------------------------------------------------------------------------------------------------
app.get("/api/games/", function(req , res){
	/*  #swagger.description = 'List all games.' */
	            var query = 'select * from games';
                executeQuery (res, query);
});

app.get("/api/game/:gamename", function(req , res){
	/*  #swagger.description = 'Search a game by name.' */
	            var query = 'select * from games where title like "%'+ req.params.gamename + '%"';
                executeQuery (res, query);
});

//POST API
app.post("/api/games", function(req , res){
	/*  #swagger.description = '' */
                var query = "INSERT INTO games (title,decription) VALUES (" + req.body.title +","+req.body.description+")";
                executeQuery (res, query);
});

//PUT API
 app.put("/api/games/:id", function(req , res){
	/*  #swagger.description = '' */	 
                var query = "UPDATE games SET title= " + req.body.title  +  " , description=  " + req.body.description + "  WHERE gameuuid= " + req.params.id;
                executeQuery (res, query);
});

// DELETE API
 app.delete("/api/games/:id", function(req , res){
	/*  #swagger.description = '' */	 
                var query = "DELETE FROM games WHERE gameuuid=" + req.params.id;
                executeQuery (res, query);
});

// PLAYERS ---------------------------------------------------------------------------------------------------------------------------------
app.get("/api/players/", function(req , res){
	/*  #swagger.description = '' */	
	            var query = 'select * from players';
                executeQuery (res, query);
});

app.get("/api/player/:searchname", function(req , res){
	/*  #swagger.description = '' */
	            var query = 'select * from players where firstname like "%'+ req.params.searchname + '%" or lastname like "%' + req.params.searchname + '%"';
                executeQuery (res, query);
});

//POST API
app.post("/api/player", function(req , res){
	/*  #swagger.description = '' */	
                var query = "INSERT INTO players (firstname,lastname,borndate,documentnr,gdpraccept) VALUES (" + 
				req.body.firstname +","+req.body.lastname+","+req.body.borndate+","+req.body.documentnr+","+req.body.gdpraccept+")";
                executeQuery (res, query);
});

//PUT API
 app.put("/api/player/:id", function(req , res){
	/*  #swagger.description = '' */	 
                var query = "UPDATE players SET firstname= " + req.body.firstname  +  " , lastname=  " + req.body.lastname + "  WHERE playeruuid= " + req.params.id;
                executeQuery (res, query);
});

// DELETE API
 app.delete("/api/player/:id", function(req , res){
	/*  #swagger.description = '' */	 
                var query = "DELETE FROM players WHERE playeruuid=" + req.params.id;
                executeQuery (res, query);
});

// GAMES IN PLAY ------------------------------------------------------------------------------------------------------------------------
app.get("/api/playedgames/", function(req , res){
	/*  #swagger.description = 'List all games played' */	
	            var query = 'select * from viewplayingames';
                executeQuery (res, query);
});




