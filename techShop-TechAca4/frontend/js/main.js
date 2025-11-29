async function fetchProdutos() {
  try {
    const res = await fetch('/api/produtos');
    const produtos = await res.json();
    const container = document.getElementById('produtos-list');
    if (!container) return;
    container.innerHTML = '';
    produtos.forEach(p => {
      const img = p.imagem || 'assets/images/laptop.svg';
      const card = document.createElement('div');
      card.className = 'col-md-4';
      card.innerHTML = `
        <div class="card mb-4 shadow-sm">
          <img src="${img}" class="card-img-top" alt="${p.nome}">
          <div class="card-body">
            <h5 class="card-title">${p.nome}</h5>
            <p class="card-text">${p.descricao || ''}</p>
            <p class="card-text"><strong>R$ ${parseFloat(p.preco).toFixed(2)}</strong></p>
            <button class="btn btn-primary" onclick="addToCart(${p.id})">Adicionar</button>
          </div>
        </div>
      `;
      container.appendChild(card);
    });
  } catch (err) {
    console.error(err);
  }
}

function addToCart(prodId) {
  let cart = JSON.parse(localStorage.getItem('cart') || '[]');
  const item = cart.find(i => i.id === prodId);
  if (item) item.qtd++;
  else cart.push({ id: prodId, qtd: 1 });
  localStorage.setItem('cart', JSON.stringify(cart));
  alert('Adicionado ao carrinho');
}

window.onload = fetchProdutos;
