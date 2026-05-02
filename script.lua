-- LK7 HUB - VERSÃO CORRIGIDA (ARRASTE FORÇADO)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LK7 HUB - IMPÉRIO GG", "DarkTheme")

-- LÓGICA DE ARRASTE MANUAL (PARA NÃO TRAVAR MAIS)
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

-- Localiza a MainFrame da Kavo e aplica o arraste
local MainFrame = game.CoreGui:FindFirstChild("LK7 HUB - IMPÉRIO GG") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("LK7 HUB - IMPÉRIO GG")
if MainFrame then
    MakeDraggable(MainFrame.Main)
end

-- Variáveis (Dica do amigo: Fixo em 91)
local targetHeight = 91 

-- ABA PRINCIPAL
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Movimentação & Visual")

-- BOTÃO FLASH TP (Usa coordenadas e fire remote)
Section:NewButton("Flash TP (Coord 91)", "Teleporte instantâneo", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local targetPos = Vector3.new(character.HumanoidRootPart.Position.X, targetHeight, character.HumanoidRootPart.Position.Z)
        
        -- Tenta disparar o remote de flash se existir
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

-- BOTÃO BASE RAY X
Section:NewToggle("Base Ray X", "Enxergar através das paredes", function(state)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            obj.Transparency = state and 0.5 or 0
        end
    end
end)

Library:Notify("LK7 HUB", "Painel Móvel Ativado!", 5)
