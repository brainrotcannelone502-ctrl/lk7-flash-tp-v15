-- LK7 HUB - VERSÃO DEFINITIVA (FIX ARRASTE + SEM LAG)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Criando a Window com a função Draggable nativa da Kavo
local Window = Library.CreateLib("LK7 HUB - IMPÉRIO GG", "DarkTheme")

-- Variáveis (Instrução: Fixo em 91)
local targetHeight = 91 

-- ABA PRINCIPAL
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Movimentação & Visual")

-- BOTÃO FLASH TP (Instrução: image_867a65.png)
Section:NewButton("Flash TP (Coord 91)", "Teleporte instantâneo (C91)", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local targetPos = Vector3.new(character.HumanoidRootPart.Position.X, targetHeight, character.HumanoidRootPart.Position.Z)
        
        -- Busca automática de Remote para o "Fire"
        local remote = nil
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("RemoteEvent") and (v.Name:lower():find("flash") or v.Name:lower():find("teleport")) then
                remote = v
                break
            end
        end

        if remote then
            remote:FireServer(targetPos)
        else
            character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
        end
    end
end)

-- BOTÃO BASE RAY X (OTIMIZADO)
Section:NewToggle("Base Ray X", "Ver através de paredes", function(state)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            obj.LocalTransparencyModifier = state and 0.5 or 0
        end
    end
end)

-- FORÇANDO O ARRASTE PELO CORE GUI
-- Isso garante que o painel se mova independente do executor
spawn(function()
    pcall(function()
        local gui = game.CoreGui:WaitForChild("LK7 HUB - IMPÉRIO GG") or game.Players.LocalPlayer.PlayerGui:WaitForChild("LK7 HUB - IMPÉRIO GG")
        local main = gui.Main
        main.Active = true
        main.Draggable = true -- Ativa a propriedade nativa do Roblox para objetos móveis
    end)
end)

Library:Notify("LK7 HUB", "Menu Móvel Ativado! Tente arrastar pelo topo.", 5)
