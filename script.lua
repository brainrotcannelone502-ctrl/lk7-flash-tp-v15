
- yAngularVelocity = Vector3.zero
-     end
-     
-     e
+ -- LK7 HUB - VERSÃO DEFINITIVA (FIX ARRASTE + SEM LAG)
+ local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
+ 
+ -- Criando a Window com a função Draggable nativa da Kavo
+ local Window = Library.CreateLib("LK7 HUB - IMPÉRIO GG", "DarkTheme")
+ 
+ -- Variáveis (Instrução: Fixo em 91)
+ local targetHeight = 91 
+ 
+ -- ABA PRINCIPAL
+ local Tab = Window:NewTab("Main")
+ local Section = Tab:NewSection("Movimentação & Visual")
+ 
+ -- BOTÃO FLASH TP (Instrução: image_867a65.png)
+ Section:NewButton("Flash TP (Coord 91)", "Teleporte instantâneo (C91)", function()
+     local character = game.Players.LocalPlayer.Character
+     if character and character:FindFirstChild("HumanoidRootPart") then
+         local targetPos = Vector3.new(character.HumanoidRootPart.Position.X, targetHeight, character.HumanoidRootPart.Position.Z)
+         
+         -- Busca automática de Remote para o "Fire"
+         local remote = nil
+         for _, v in pairs(game:GetDescendants()) do
+             if v:IsA("RemoteEvent") and (v.Name:lower():find("flash") or v.Name:lower():find("teleport")) then
+                 remote = v
+                 break
+             end
+         end
+ 
+         if remote then
+             remote:FireServer(targetPos)
+         else
+             character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
+         end
+     end
+ end)
+ 
+ -- BOTÃO BASE RAY X (OTIMIZADO)
+ Section:NewToggle("Base Ray X", "Ver através de paredes", function(state)
+     for _, obj in pairs(game.Workspace:GetDescendants()) do
+         if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
+             obj.LocalTransparencyModifier = state and 0.5 or 0
+         end
+     end
+ end)
+ 
+ -- Adicionando funcionalidade de arraste personalizada
+ local UserInputService = game:GetService("UserInputService")
+ local gui = game.CoreGui:FindFirstChild("LK7 HUB - IMPÉRIO GG") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("LK7 HUB - IMPÉRIO GG")
+ if gui then
+     local main = gui:FindFirstChild("Main")
+     if main then
+         local dragging = false
+         local dragInput
+         local dragStart
+         local startPos
+         local function updateInput(input)
+             local delta = input.Position - dragStart
+             main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
+         end
+         main.InputBegan:Connect(function(input)
+             if input.UserInputType == Enum.UserInputType.MouseButton1 then
+                 dragging = true
+                 dragStart = input.Position
+                 startPos = main.Position
+                 input.Changed:Connect(function()
+                     if input.UserInputState == Enum.UserInputState.End then
+                         dragging = false
+                     end
+                 end)
+             end
+         end)
+         main.InputChanged:Connect(function(input)
+             if input.UserInputType == Enum.UserInputType.MouseMovement then
+                 dragInput = input
+             end
+         end)
+         UserInputService.InputChanged:Connect(function(input)
+             if input == dragInput and dragging then
+                 updateInput(input)
+             end
+         end)
+     end
+ end
+ 
+ Library:Notify("LK7 HUB", "Menu Móvel Ativado! Arraste pelo topo para mover.", 5)
