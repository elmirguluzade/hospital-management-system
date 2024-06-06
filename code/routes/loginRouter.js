const router = require('express').Router()
const loginController = require('../controllers/loginController') 
const expressSession = require('express-session');
const cookieParser = require("cookie-parser");

router.use(cookieParser());
router.use(expressSession({
    secret: 'hospitalSecret',
    resave: true,
    saveUninitialized: true,
}))

router.get('/', loginController.renderPage)
router.get('/logout', loginController.logout)
router.post('/', loginController.checkLogin)

module.exports = router