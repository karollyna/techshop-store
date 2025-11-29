CREATE DATABASE IF NOT EXISTS techshop_store;
USE techshop_store;

-- Tabelas
CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  senha_hash VARCHAR(255) NOT NULL,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(200) NOT NULL,
  descricao TEXT,
  preco DECIMAL(10,2) NOT NULL,
  estoque INT DEFAULT 0,
  imagem VARCHAR(255),
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  status VARCHAR(50) DEFAULT 'PENDENTE',
  total DECIMAL(10,2) DEFAULT 0,
  criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE pedido_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id INT,
  produto_id INT,
  quantidade INT,
  preco_unit DECIMAL(10,2),
  FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
  FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Índices para otimizar consultas
CREATE INDEX idx_produtos_nome ON produtos(nome);
CREATE INDEX idx_pedidos_cliente ON pedidos(cliente_id);
CREATE INDEX idx_produtos_preco ON produtos(preco);

-- Tabela de auditoria de preço
CREATE TABLE preco_auditoria (
  id INT AUTO_INCREMENT PRIMARY KEY,
  produto_id INT,
  preco_antigo DECIMAL(10,2),
  preco_novo DECIMAL(10,2),
  alterado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER trg_preco_update
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
  IF NEW.preco <> OLD.preco THEN
    INSERT INTO preco_auditoria (produto_id, preco_antigo, preco_novo) VALUES (OLD.id, OLD.preco, NEW.preco);
  END IF;
END$$
DELIMITER ;

-- Procedure para inserção massiva
DELIMITER $$
CREATE PROCEDURE inserir_produtos_massivo(IN linhas INT)
BEGIN
  DECLARE i INT DEFAULT 1;
  WHILE i <= linhas DO
    INSERT INTO produtos (nome, descricao, preco, estoque, imagem) VALUES (CONCAT('Produto ', i), 'Produto adicionado em massa', 199.90 + i, 50 + i, 'assets/images/laptop.svg');
    SET i = i + 1;
  END WHILE;
END$$
DELIMITER ;

-- Função para verificar estoque
DELIMITER $$
CREATE FUNCTION verificar_estoque(prod_id INT, qtd INT) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
  DECLARE s INT;
  SELECT estoque INTO s FROM produtos WHERE id = prod_id;
  IF s >= qtd THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;
END$$
DELIMITER ;
