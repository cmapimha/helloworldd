const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("Hello World from my Node.js Web Server!");
});

const port = process.env.PORT || 3000;
app.listen(3000, '0.0.0.0', () => {
  console.log("Server is running on port 3000");
});

