QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('cmining:server:purchasepickaxe', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return
    end

    if Config.AlreadyPickaxe then
        if Player.Functions.GetItemByName(Config.RockSettings.RequiredItem) ~= nil then
            TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.PurchaseFailed, 'error')
        else
            Cash = Player.PlayerData.money.cash
            Bank = Player.PlayerData.money.bank

            if Config.MeansOfPayment == "cash" then
                if Cash >= Config.Prices.Pickaxe then
                    Player.Functions.RemoveMoney("cash", Config.Prices.Pickaxe)
                    Player.Functions.AddItem(Config.RockSettings.RequiredItem, 1)
                    TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.Purchase, 'success')
                else
                    TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NotEnoughCash, 'error')
                end

            elseif Config.MeansOfPayment == "bank" then
                if Bank >= Config.Prices.Pickaxe then
                    Player.Functions.RemoveMoney("bank", Config.Prices.Pickaxe)
                    Player.Functions.AddItem(Config.RockSettings.RequiredItem, 1)
                    TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.Purchase, 'success')
                else
                    TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NotEnoughCash, 'error')
                end
            end
        end
    else
        Cash = Player.PlayerData.money.cash
        Bank = Player.PlayerData.money.bank

        if Config.MeansOfPayment == "cash" then
            if Cash >= Config.Prices.Pickaxe then
                Player.Functions.RemoveMoney("cash", Config.Prices.Pickaxe)
                Player.Functions.AddItem(Config.RockSettings.RequiredItem, 1)
                TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.Purchase, 'success')
            else
                TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NotEnoughCash, 'error')
            end

        elseif Config.MeansOfPayment == "bank" then
            if Bank >= Config.Prices.Pickaxe then
                Player.Functions.RemoveMoney("bank", Config.Prices.Pickaxe)
                Player.Functions.AddItem(Config.RockSettings.RequiredItem, 1)
                TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.Purchase, 'success')
            else
                TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NotEnoughCash, 'error')
            end
        end
    end
end)

RegisterServerEvent('cmining:server:purchaseexplosive', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return
    end

    if Config.AlreadyExplosive then
        if Player.Functions.GetItemByName(Config.DoorSettings.RequiredItem) ~= nil then
            TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.PurchaseFailed, 'error')
        else
            Cash = Player.PlayerData.money.cash
            Bank = Player.PlayerData.money.bank

            if Config.MeansOfPayment == "cash" then
                if Cash >= Config.Prices.Explosive then
                    Player.Functions.RemoveMoney("cash", Config.Prices.Explosive)
                    Player.Functions.AddItem(Config.DoorSettings.RequiredItem, 1)
                    TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.Purchase, 'success')
                else
                    TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NotEnoughCash, 'error')
                end

            elseif Config.MeansOfPayment == "bank" then
                if Bank >= Config.Prices.Explosive then
                    Player.Functions.RemoveMoney("bank", Config.Prices.Explosive)
                    Player.Functions.AddItem(Config.DoorSettings.RequiredItem, 1)
                    TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.Purchase, 'success')
                else
                    TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NotEnoughCash, 'error')
                end
            end
        end
    else
        Cash = Player.PlayerData.money.cash
        Bank = Player.PlayerData.money.bank

        if Config.MeansOfPayment == "cash" then
            if Cash >= Config.Prices.Explosive then
                Player.Functions.RemoveMoney("cash", Config.Prices.Explosive)
                Player.Functions.AddItem(Config.DoorSettings.RequiredItem, 1)
                TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.Purchase, 'success')
            else
                TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NotEnoughCash, 'error')
            end

        elseif Config.MeansOfPayment == "bank" then
            if Bank >= Config.Prices.Explosive then
                Player.Functions.RemoveMoney("bank", Config.Prices.Explosive)
                Player.Functions.AddItem(Config.DoorSettings.RequiredItem, 1)
                TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.Purchase, 'success')
            else
                TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NotEnoughCash, 'error')
            end
        end
    end
end)

RegisterServerEvent('cmining:server:checkexplosive', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return
    end

    if Player.Functions.GetItemByName(Config.DoorSettings.RequiredItem) ~= nil then
        Player.Functions.RemoveItem(Config.DoorSettings.RequiredItem, 1)
        TriggerClientEvent('cmining:opendoor', source)
    else
        TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NoExplosive, 'error')
    end
end)

RegisterServerEvent('cmining:server:checkpickaxe', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return
    end

    if Player.Functions.GetItemByName(Config.RockSettings.RequiredItem) ~= nil then
        TriggerClientEvent('cmining:mine', source)
    else
        TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NoPickaxe, 'error')
    end
end)

RegisterServerEvent('cmining:server:mining', function()
    local Player = QBCore.Functions.GetPlayer(source)

    Player.Functions.AddItem(Config.RockSettings.ReceiveItem, math.random(Config.RewardSettings.Rock.MinimumAmount, Config.RewardSettings.Rock.MaximumAmount))
    TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.ExtractSuccess, 'success')
end)

RegisterServerEvent('cmining:server:search', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return
    end

    Item = Config.BarrelSettings.ReceiveItem[math.random(1, Config.RewardSettings.Barrel.TotalItem)]
    Amount = math.random(Config.RewardSettings.Barrel.MinimumAmount, Config.RewardSettings.Barrel.MaximumAmount)

    Player.Functions.AddItem(Item, Amount)
    TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.SearchSuccess .. Amount .. " " .. Item .. "!", 'success')
end)

RegisterServerEvent('cmining:server:checkcleaning', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return
    end

    if Player.Functions.GetItemByName(Config.CleaningSettings.RequiredItem) ~= nil then
        Player.Functions.RemoveItem(Config.CleaningSettings.RequiredItem, 1)
        TriggerClientEvent('cmining:cleaning', source)
    else
        TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NoRock, 'error')
    end
end)

RegisterServerEvent('cmining:server:cleaning', function()
    local Player = QBCore.Functions.GetPlayer(source)

    Item = Config.CleaningSettings.ReceiveItem
    Amount = math.random(Config.RewardSettings.Cleaning.MinimumAmount, Config.RewardSettings.Cleaning.MaximumAmount)

    Player.Functions.AddItem(Item, Amount)
    TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.CleaningSuccess, 'success')
end)

RegisterServerEvent('cmining:server:checksell', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return
    end

    if Player.Functions.GetItemByName(Config.SellSettings.RequiredItem) then
        TriggerClientEvent('cmining:sell', source)
    else
        TriggerClientEvent('cmining:notify', source, Strings.Error, Strings.NoRock, 'error')
    end
end)

RegisterServerEvent('cmining:server:sell', function()
    local Player = QBCore.Functions.GetPlayer(source)

    Item = Config.SellSettings.RequiredItem
    AmountItem = Player.Functions.GetItemByName(Config.SellSettings.RequiredItem).amount
    Amount = Config.Prices.SellCleanRock * Player.Functions.GetItemByName(Config.SellSettings.RequiredItem).amount

    Player.Functions.RemoveItem(Item, AmountItem)

    if Config.MeansOfPayment == "cash" then
        Player.Functions.AddMoney("cash", Amount)
    elseif Config.MeansOfPayment == "bank" then
        Player.Functions.AddMoney("bank", Amount)
    end
    TriggerClientEvent('cmining:notify', source, Strings.Success, Strings.SellSuccess .. Amount .. "!", 'success')
end)