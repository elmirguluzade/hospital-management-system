const express = require('express')
const path = require('path')
const morgan = require('morgan');
require("dotenv").config({ path: "./config.env" });
const liveReload = require('livereload');
const connectLiveReload = require('connect-livereload');

const app = express()

const liveReloadServer = liveReload.createServer();
liveReloadServer.server.once("connection", () => {
    setTimeout(() => {
        liveReloadServer.refresh('/');
    }, 100)
});

app.use(connectLiveReload());
app.use(express.urlencoded({ extended: false }));

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "hbs");

app.use(express.json())
app.use(morgan("dev"))

// Routes
const loginRouter = require('./routes/loginRouter');
const editRouter = require('./routes/editRouter')

app.use('/', loginRouter)
app.use('/enter/edit', editRouter)

app.use((req, res) => {
    res.send(`${req.originalUrl} doesn't exist`)
})

const PORT = process.env.PORT;
app.listen(PORT, () => console.log(`Server is listeninig http://localhost:${PORT}`))