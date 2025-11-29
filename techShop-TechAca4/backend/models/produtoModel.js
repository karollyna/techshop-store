const pool = require('../db/pool');
module.exports = {
  async list() {
    const [rows] = await pool.query('SELECT id, nome, descricao, preco, estoque, imagem FROM produtos');
    return rows;
  },
  async find(id) {
    const [rows] = await pool.query('SELECT * FROM produtos WHERE id = ?', [id]);
    return rows[0];
  },
  async create(data) {
    const { nome, descricao, preco, estoque, imagem } = data;
    const [result] = await pool.query('INSERT INTO produtos (nome, descricao, preco, estoque, imagem) VALUES (?, ?, ?, ?, ?)', [nome, descricao, preco, estoque, imagem]);
    return result.insertId;
  },
  async update(id, data) {
    const { nome, descricao, preco, estoque, imagem } = data;
    await pool.query('UPDATE produtos SET nome = ?, descricao = ?, preco = ?, estoque = ?, imagem = ? WHERE id = ?', [nome, descricao, preco, estoque, imagem, id]);
    return true;
  },
  async remove(id) {
    await pool.query('DELETE FROM produtos WHERE id = ?', [id]);
    return true;
  }
};
