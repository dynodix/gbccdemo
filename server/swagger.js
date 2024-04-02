const swaggerAutogen = require('swagger-autogen')();

const doc = {
  info: {
    title: 'GBCC Example Swagger autogen',
    description: 'Auto generated documentation for GBCC App'
  },
  host: '192.168.0.9:9080'
};

const outputFile = './swagger-output.json';
const routes = ['./server.js'];

/* NOTE: If you are using the express Router, you must pass in the 'routes' only the 
root file where the route starts, such as index.js, app.js, routes.js, etc ... */

swaggerAutogen(outputFile, routes, doc);