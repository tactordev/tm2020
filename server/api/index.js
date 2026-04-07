
const express = require('express');
const cors = require('cors');

const corsOptions = {
    origin: '*',
    optionsSuccessStatus: 200
};

const app = express();
app.use(cors(corsOptions));


const port = process.env.PORT || 4050;

app.get('/join-room', (req, res) => {
})