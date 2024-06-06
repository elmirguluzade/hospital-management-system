const router = require('express').Router()
const editController = require('../controllers/editController') 

router.get('/', editController.renderPage)
router.post('/modify/:role', editController.modify)
router.post('/delete/:id/:role', editController.delete)
router.get('/insert/:role', editController.insertPage)
router.post('/insert/:role', editController.insert)
router.post('/search/:type', editController.search)

module.exports = router