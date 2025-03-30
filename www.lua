local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function CreateOutlineForPlayer(player)
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        -- Crear el contorno (SelectionBox) alrededor del jugador
        local selectionBox = Instance.new("SelectionBox")
        selectionBox.Parent = character
        selectionBox.Adornee = character.HumanoidRootPart
        selectionBox.Color3 = Color3.fromRGB(255, 0, 0)  -- Rojo
        selectionBox.LineThickness = 0.1  -- Grosor de las líneas del contorno
        selectionBox.Transparency = 0.5  -- Transparencia del contorno
        selectionBox.SurfaceTransparency = 0.7  -- Transparencia de las superficies
        selectionBox.Parent = character
        
        -- Asegurar que el contorno no desaparezca si el jugador respawnea
        player.CharacterAdded:Connect(function()
            if character:FindFirstChild("HumanoidRootPart") then
                selectionBox.Adornee = character.HumanoidRootPart
            end
        end)
    end
end

local function RemoveOutlineForPlayer(player)
    local character = player.Character
    if character and character:FindFirstChild("SelectionBox") then
        local selectionBox = character:FindFirstChild("SelectionBox")
        if selectionBox then
            selectionBox:Destroy()  -- Eliminar el contorno si el jugador deja de estar en el juego
        end
    end
end

-- Crear el contorno para los jugadores que ya están en el juego
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        CreateOutlineForPlayer(player)
    end
end

-- Crear el contorno cuando un nuevo jugador entra al juego
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        CreateOutlineForPlayer(player)
    end)
end)

-- Eliminar el contorno cuando un jugador se va
Players.PlayerRemoving:Connect(function(player)
    RemoveOutlineForPlayer(player)
end)

-- Crear el contorno para el jugador local
LocalPlayer.CharacterAdded:Connect(function()
    CreateOutlineForPlayer(LocalPlayer)
end)
