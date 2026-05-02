-- LK7 HUB - VERSÃO FINAL OTIMIZADA (SEM LAG + ARRASTE)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LK7 HUB - IMPÉRIO GG", "DarkTheme")

-- LÓGICA DE ARRASTE MANUAL (PARA NÃO TRAVAR O MENU NA TELA)
local function MakeDraggable(gui)
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Ativa o arraste no painel da Kavo
spawn(function()
    local MainFrame = game.CoreGui:WaitForChild("LK7 HUB - IMPÉRIO GG", 5) or game.Players.LocalPlayer.PlayerGui:WaitForChild("LK7 HUB - IMPÉRIO GG", 5)
    if MainFrame then
        MakeDraggable(MainFrame.Main)
    end
end)

-- Variáveis (Instrução do amigo: Coordenada fixa em 91)
local targetHeight = 91 

-- ABA PRINCIPAL
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Movimentação & Visual")

-- BOTÃO FLASH TP (Usa coordenadas e tentativa de fire remote)
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

-- BOTÃO BASE RAY X (VERSÃO OTIMIZADA PARA NÃO DAR LAG)
Section:NewToggle("Base Ray X", "Ver através de paredes sem travar", function(state)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        -- Usamos LocalTransparencyModifier para ser mais leve que a Transparency comum
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            obj.LocalTransparencyModifier = state and 0.5 or 0
        end
    end
end)

Library:Notify("LK7 HUB", "Pronto para uso! Painel móvel e X-ray otimizado.", 5)
