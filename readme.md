Tradutor para BizHawk
=====================

Este projeto conecta um script Lua do BizHawk a um servidor Node.js. O servidor
recebe texto do jogo, solicita a traducao para portugues e devolve o resultado
para ser exibido como legenda na tela.

Requisitos
----------

- Node.js e npm instalados.
- BizHawk instalado. O arquivo launch.bat espera encontrar EmuHawk.exe na pasta
  atual ou no caminho de execucao usado pelo Windows.
- Acesso a internet para consultar o servico publico do Google Tradutor.

Como iniciar
------------

1. Abra um terminal nesta pasta e instale as dependencias:

       npm install

2. Inicie o servidor:

       node server.js

   Ele fica disponivel em http://localhost:3000 e aceita requisicoes POST em
   /traduzir com um JSON como {"texto":"Hello"}.

3. Inicie o BizHawk com launch.bat ou abra EmuHawk.exe manualmente.
4. Carregue o jogo e execute client.lua pela ferramenta Lua do BizHawk.

Observacoes
-----------

- O servidor escuta na porta 3000. Mantenha-o em execucao enquanto usar o
  script Lua.
- client.lua usa atualmente o endereco de memoria 0x00A1B2 como marcador de
  exemplo. Esse endereco e o tamanho do buffer precisam corresponder ao jogo e
  ao sistema emulado; o script nao detecta automaticamente o texto do jogo.
- A leitura atual inclui apenas bytes ASCII imprimiveis.
- A traducao depende de um servico publico e de acesso a internet; disponibilidade
  e limites desse servico podem variar.
