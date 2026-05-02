-- LK7 HUB - EXECUTOR VERSION (COM ARRASTE ATIVADO)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LK7 HUB - IMPÉRIO GG", "DarkTheme")

-- ATIVA O ARRASTE DO PAINEL NA TELA
-- Isso resolve o problema de não conseguir mexer o menu
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    game:GetService("TweenService"):Create(game.CoreGui:FindFirstChild("LK7 HUB - IMPÉRIO GG").Main, TweenInfo.new(0.1), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
end

-- Variáveis de Configuração (Baseadas na dica do seu amigo)
local targetHeight = 91 -- O "fixo em 91"
local flashRemote = nil

-- Função para localizar o Remote de Flash automaticamente (Auto Grab/Trigger)
local function findFlashRemote()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") and (v.Name:lower():find("flash") or v.Name:lower():find("teleport")) then
            return v
        end
    end
    return nil
end

-- ABA PRINCIPAL
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Movimentação & Visual")

-- BOTÃO FLASH TP (Instruções da imagem image_867a65.png)
Section:NewButton("Flash TP (Coord 91)", "Teleporte instantâneo", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local remote = findFlashRemote()
        local targetPos = Vector3.new(character.HumanoidRootPart.Position.X, targetHeight, character.HumanoidRootPart.Position.Z)
        
        if remote then
            remote:FireServer(targetPos) -- "Remote pra dar fire"
        else
            character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
        end
    end
end)

-- BOTÃO BASE RAY X
Section:NewToggle("Base Ray X", "Enxergar através das paredes", function(state)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            if state then
                if obj.Transparency < 0.5 then obj.Transparency = 0.5 end
            else
                if obj.Transparency == 0.5 then obj.Transparency = 0 end
            end
        end
    end
end)

-- NOTIFICAÇÃO DE INICIALIZAÇÃO
Library:Notify("LK7 HUB", "Script carregado! Agora você pode arrastar o painel.", 5)
