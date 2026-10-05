-- Buffer padrão (vamos ajustar o endereço correto de memória jajá)
local ENDERECO_RAM_TEXTO = 0x00A1B2  
local TAMANHO_BUFFER = 64

local textoAntigo = ""
local textoTraduzido = ""

console.clear()
print("Tradutor Oficial BizHawk + Node.js Ativo!")

while true do
    -- Lê byte a byte da RAM
    local textoAtual = ""
    for i = 0, TAMANHO_BUFFER - 1 do
        local byte = mainmemory.readbyte(ENDERECO_RAM_TEXTO + i)
        if byte == 0 or byte == 0x00 then 
            break 
        elseif byte >= 32 and byte <= 126 then 
            textoAtual = textoAtual .. string.char(byte)
        end
    end
    
    textoAtual = textoAtual:gsub("[%c]", ""):gsub('"', '\\"'):gsub("\\", "\\\\")
    
    -- Dispara a requisição para o Node se o texto mudou
    if textoAtual ~= textoAntigo and textoAtual ~= "" and #textoAtual > 2 then
        textoAntigo = textoAtual
        local payload = '{"texto":"' .. textoAtual .. '"}'
        
        -- Utiliza a função nativa liberada pelo arquivo .bat
        local sucesso, resposta = pcall(function() 
            return comm.httpPost("http://localhost:3000/traduzir", payload) 
        end)
        
        if sucesso and resposta then
            local traduzido = resposta:match('"traduzido"%s*:%s*"(.-)"')
            if traduzido then
                textoTraduzido = traduzido
                print("[Node.js]: Texto traduzido com sucesso!")
            end
        end
    end
    
    -- Desenha a legenda na tela
    if textoTraduzido ~= "" then
        gui.drawRectangle(0, 180, 256, 40, "black", "black")
        gui.drawString(8, 185, textoTraduzido, "white", "black", 11, "Arial", "bold")
    end
    
    emu.frameadvance()
end
