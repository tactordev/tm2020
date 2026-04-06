
const net = require('node:net');
const fs = require('node:fs');

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

server.listen(4040, '127.0.0.1', () => {
    console.log('TCP server listening on 127.0.0.1:4040');
});

