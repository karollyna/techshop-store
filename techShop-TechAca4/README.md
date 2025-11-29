# TechShop Store — Entrega Final com Imagens (Eletrônicos)

## O que este projeto contém
- Backend Node.js + Express organizado em MVC (models/controllers/routes)
- API REST para CRUD de produtos (implementado)
- Banco MySQL com tabelas, índices, trigger de auditoria, procedure de inserção massiva e função para verificar estoque
- Frontend em HTML + Bootstrap + JS (listagem de produtos, carrinho e dashboard)
- Imagens de produtos (SVGs) incluídas em frontend/assets/images/

## Como rodar (resumo)
1. Instale Node.js e MySQL.
2. No MySQL, execute `db/schema.sql` para criar banco, tabelas e objetos (triggers, procedures, functions).
3. Opcional: popular produtos manualmente ou executar `CALL inserir_produtos_massivo(5);` após importar o SQL.
4. Copie `backend/.env.example` → `backend/.env` e ajuste as credenciais.
5. No terminal, em `backend/` rode: `npm install` e `npm run dev`.
6. Abra `http://localhost:3000` (o servidor serve os arquivos do frontend automaticamente).

## Observações
- As imagens usadas são vetoriais (SVG) simples e sem marca; substitua por fotos reais se desejar.
- Integração de pagamentos e envio não estão incluídos (checkout simulado).
