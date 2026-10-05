const express = require('express');
const { translate } = require('@vitalets/google-translate-api');
const app = express();

app.use(express.json());

app.post('/traduzir', async (req, res) => {
    const textoOriginal = req.body.texto;
    
    if (!textoOriginal || textoOriginal.trim() === "") {
        return res.json({ traduzido: "" });
    }

    try {
        // Envia o texto direto para o servidor público do Google Tradutor
        // auto = detecta automaticamente o idioma (inglês, japonês, etc)
        // to: 'pt' = traduz para o português
        const resultado = await translate(textoOriginal, { to: 'pt', from: 'auto' });
        
        console.log(`[Original]: ${textoOriginal} -> [Traduzido]: ${resultado.text}`);
        res.json({ traduzido: resultado.text });
    } catch (err) {
        console.error("Erro ao conectar com o Google Tradutor público:", err);
        // Retorna o texto original para o jogo não travar se a internet oscilar
        res.json({ traduzido: "[Erro de Conexão Google]" }); 
    }
});

app.listen(3000, () => console.log("Servidor Google Tradutor Gratuito rodando na porta 3000!"));
