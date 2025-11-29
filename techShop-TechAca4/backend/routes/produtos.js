const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/produtoController');

router.get('/', ctrl.index);
router.get('/:id', ctrl.show);
router.post('/', ctrl.store);
router.put('/:id', ctrl.update);
router.delete('/:id', ctrl.destroy);

module.exports = router;
