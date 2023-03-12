const express = require('express');
const {createServer} = require("http");
const {Server} = require("socket.io");

const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer);

app.route("/").get((req,res)=>{
res.json("Wellcome!")
});

io.on("connection",(socket)=>{
    socket.join("anonymous_group");
    console.log("Backend connected...");

    socket.on("sendMsg",(msg)=>{
      console.log(msg,{...msg, type:"otherMsg"});

      // socket.emit("getMsg", {...msg, type:"otherMsg"});
    io.to("anonymous_group").emit("getMsg", {...msg, type:"otherMsg"});


   
    })
});

httpServer.listen(8081);