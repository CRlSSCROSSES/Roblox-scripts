local function autoParry()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local function onParry()
        if character and humanoid then
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
    end

    local function onAttack()
        if character and humanoid then
            local tool = character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
            end
        end
    end

    humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        if humanoid.Health > 0 then
            onParry()
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if character and humanoid and humanoid.Health > 0 then
            onAttack()
        end
    end)
end

autoParry()
