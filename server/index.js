
const net = require('node:net');
const fs = require('node:fs');

const PORT = process.env.PORT || 4040;


const server = net.createServer((socket) => {
    console.log('Client connected.');
    socket.setEncoding('utf8');

    socket.on('data', (data) => {
        socket.write(`Echo: ${data.trim()}`);
        console.log(`Received data from client: ${data.trim()}`);
    })

    socket.on('end', () => {
        console.log('Client disconnected.');
    });

    socket.on('error', (err) => {
        console.log(`Client socket error: ${err.code ?? err.message}`);
    });
});

server.listen(PORT, '0.0.0.0', () => {
    console.log(`TCP server listening on port ${PORT}`);
});

