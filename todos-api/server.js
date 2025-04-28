'use strict';

const express = require('express');
const bodyParser = require('body-parser');
const jwt = require('express-jwt');
const cors = require('cors');
const {Tracer, BatchRecorder, jsonEncoder: {JSON_V2}} = require('zipkin');
const CLSContext = require('zipkin-context-cls');
const {HttpLogger} = require('zipkin-transport-http');
const zipkinMiddleware = require('zipkin-instrumentation-express').expressMiddleware;
const redis = require('redis');

// Configuración
const ZIPKIN_URL = 'https://zipkin-111693207847.us-central1.run.app/api/v2/spans';
const logChannel = process.env.REDIS_CHANNEL || 'log_channel';
const redisClient = redis.createClient({
  host: process.env.REDIS_HOST || 'localhost',
  port: process.env.REDIS_PORT || 6379,
  retry_strategy: function (options) {
    if (options.error && options.error.code === 'ECONNREFUSED') {
      return new Error('The server refused the connection');
    }
    if (options.total_retry_time > 1000 * 60 * 60) {
      return new Error('Retry time exhausted');
    }
    if (options.attempt > 10) {
      console.log('reattempting to connect to redis, attempt #' + options.attempt);
      return undefined;
    }
    return Math.min(options.attempt * 100, 2000);
  }
});

const port = process.env.TODO_API_PORT || 8082;
const jwtSecret = process.env.JWT_SECRET || "foo";

const app = express();

// -------- CONFIGURAR CORS PRIMERO --------
const corsOptions = {
  origin: 'https://frontend-111693207847.us-central1.run.app',
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: [
    'Content-Type',
    'Authorization',
    'x-b3-traceid',
    'x-b3-spanid',
    'x-b3-parentspanid',
    'x-b3-sampled',
    'x-b3-flags',
    'x-request-id'
  ]
};
app.use(cors(corsOptions));
app.options('*', cors(corsOptions)); // Habilitar CORS para todas las rutas OPTIONS

// -------- DEMÁS MIDDLEWARES --------
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Tracing
const ctxImpl = new CLSContext('zipkin');
const recorder = new BatchRecorder({
  logger: new HttpLogger({
    endpoint: ZIPKIN_URL,
    jsonEncoder: JSON_V2
  })
});
const tracer = new Tracer({ctxImpl, recorder, localServiceName: 'todos-api'});
app.use(zipkinMiddleware({tracer}));

// 🔵 SOLO después de CORS aplicamos JWT, pero ignoramos OPTIONS
app.use((req, res, next) => {
  if (req.method === 'OPTIONS') {
    res.sendStatus(200);
  } else {
    jwt({ secret: jwtSecret })(req, res, next);
  }
});

// Manejar errores de JWT
app.use(function (err, req, res, next) {
  if (err.name === 'UnauthorizedError') {
    res.status(401).send({ message: 'invalid token' });
  }
});

// Rutas
const routes = require('./routes');
routes(app, {tracer, redisClient, logChannel});

// Iniciar el servidor
app.listen(port, function () {
  console.log('todo list RESTful API server started on: ' + port);
});
