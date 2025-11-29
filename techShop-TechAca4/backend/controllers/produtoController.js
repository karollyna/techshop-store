const produtoModel = require('../models/produtoModel');
module.exports = {
  async index(req, res) {
    try { res.json(await produtoModel.list()); } catch(err){ res.status(500).json({error: err.message}); }
  },
  async show(req, res) {
    try { res.json(await produtoModel.find(req.params.id) || {}); } catch(err){ res.status(500).json({error: err.message}); }
  },
  async store(req, res) {
    try { const id = await produtoModel.create(req.body); res.json({ id }); } catch(err){ res.status(500).json({error: err.message}); }
  },
  async update(req, res) {
    try { await produtoModel.update(req.params.id, req.body); res.json({ ok: true }); } catch(err){ res.status(500).json({error: err.message}); }
  },
  async destroy(req, res) {
    try { await produtoModel.remove(req.params.id); res.json({ ok: true }); } catch(err){ res.status(500).json({error: err.message}); }
  }
};
