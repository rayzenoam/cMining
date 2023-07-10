QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for _, v in pairs(Config.Blips) do
        Blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(Blip, v.sprite)
        SetBlipScale(Blip, v.scale)
        SetBlipColour(Blip, v.colour)
        SetBlipAsShortRange(Blip, v.asshortrange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(Blip)
    end
end)

CreateThread(function()
    RequestModel(Config.PedHash.Boss)
    while not HasModelLoaded(Config.PedHash.Boss) do
        Wait(1)
    end

    RequestModel(Config.GarageSettings.Vehicle)
    while not HasModelLoaded(Config.GarageSettings.Vehicle) do
        Wait(1)
    end

    RequestModel(Config.PedHash.Buyer)
    while not HasModelLoaded(Config.PedHash.Buyer) do
        Wait(1)
    end

    RequestModel(Config.PropBomb.Prop)
    while not HasModelLoaded(Config.PropBomb.Prop) do
        Wait(1)
    end

    if Config.Debug and HasModelLoaded(Config.PedHash.Boss) and HasModelLoaded(Config.GarageSettings.Vehicle) and HasModelLoaded(Config.PedHash.Buyer) and HasModelLoaded(Config.PropBomb.Prop) then
        print('[cMining - HasModelLoaded] ' .. Debug.HasModelLoaded)
    end

    Boss = CreatePed(1, Config.PedHash.Boss, Config.Coords.Boss.x, Config.Coords.Boss.y, Config.Coords.Boss.z - 1.0, Config.Coords.Boss.w, false, false)
    SetEntityInvincible(Boss, Config.PedSettings.Invincible)
    FreezeEntityPosition(Boss, Config.PedSettings.Freeze)
    SetBlockingOfNonTemporaryEvents(Boss, true)
    TaskStartScenarioInPlace(Boss, "WORLD_HUMAN_LEANING", 0, true)

    Buyer = CreatePed(1, Config.PedHash.Buyer, Config.Coords.Buyer.x, Config.Coords.Buyer.y, Config.Coords.Buyer.z - 1.0, Config.Coords.Buyer.w, false, false)
    SetEntityInvincible(Buyer, Config.PedSettings.Invincible)
    FreezeEntityPosition(Buyer, Config.PedSettings.Freeze)
    SetBlockingOfNonTemporaryEvents(Buyer, true)
end)

CreateThread(function()
    if Config.Target == "qb" then
        exports['qb-target']:AddBoxZone("PedBoxZone", vec3(Config.Coords.Boss.x, Config.Coords.Boss.y, Config.Coords.Boss.z - 0.99), 1.0, 1.0, {
            name = "BossPed",
            heading = Config.Coords.Boss.w,
            debugPoly = Config.Debug,
            minZ = Config.Coords.Boss.z - 1.0,
            maxZ = Config.Coords.Boss.z + 1.0
            }, {
                options = {
                    {
                        num = 1,
                        type = "client",
                        event = "cmining:progress",
                        icon = Config.PedSettings.BossTargetIcon,
                        label = Target.LabelBoss,
                        job = Config.Job,
                        drawDistance = Config.TargetSettings.DrawDistance,
                        drawColor = Config.TargetSettings.DrawColor
                    }
                },
                distance = Config.TargetSettings.Distance
            })

        exports['qb-target']:AddBoxZone("BuyerPedBoxZone", vec3(Config.Coords.Buyer.x, Config.Coords.Buyer.y, Config.Coords.Buyer.z - 0.99), 1.0, 1.0, {
            name = "BuyerPed",
            heading = Config.Coords.Buyer.w,
            debugPoly = Config.Debug,
            minZ = Config.Coords.Buyer.z - 1.0,
            maxZ = Config.Coords.Buyer.z + 1.0
            }, {
                options = {
                    {
                        type = "server",
                        event = "cmining:server:checksell",
                        icon = Config.PedSettings.BuyerTargetIcon,
                        label = Target.LabelBuyer,
                        job = Config.Job,
                        drawDistance = Config.TargetSettings.DrawDistance,
                        drawColor = Config.TargetSettings.DrawColor
                    }
                },
                distance = Config.TargetSettings.Distance
            })

        exports['qb-target']:AddBoxZone("DoorBoxZone", vec3(Config.Coords.Door.x, Config.Coords.Door.y, Config.Coords.Door.z - 0.99), 0.5, 2.0, {
            name = "MineDoor",
            heading = Config.Coords.Door.w,
            debugPoly = Config.Debug,
            minZ = Config.Coords.Door.z - 1.0,
            maxZ = Config.Coords.Door.z + 1.5
            }, {
                options = {
                    {
                        type = "server",
                        event = "cmining:server:checkexplosive",
                        icon = Config.DoorSettings.TargetIcon,
                        label = Target.LabelDoor,
                        job = Config.Job,
                        drawDistance = Config.TargetSettings.DrawDistance,
                        drawColor = Config.TargetSettings.DrawColor
                    }
                },
                distance = Config.DoorSettings.Distance
            })

        exports['qb-target']:AddBoxZone("CleaningRockBoxZone", vec3(Config.Coords.Cleaning.x, Config.Coords.Cleaning.y, Config.Coords.Cleaning.z - 0.99), 3.0, 4.0, {
            name = "CleaningRock",
            heading = Config.Coords.Cleaning.w,
            debugPoly = Config.Debug,
            minZ = Config.Coords.Cleaning.z - 0.5,
            maxZ = Config.Coords.Cleaning.z + 0.5
            }, {
                options = {
                    {
                        type = "server",
                        event = "cmining:server:checkcleaning",
                        icon = Config.CleaningSettings.TargetIcon,
                        label = Target.LabelCleaningRock,
                        job = Config.Job,
                        drawDistance = Config.TargetSettings.DrawDistance,
                        drawColor = Config.TargetSettings.DrawColor
                    }
                },
                distance = Config.TargetSettings.Distance
            })

    elseif Config.Target == "custom" then
        -- You can add your code here!
    end
end)

CreateThread(function()
    if Config.Target == "qb" then
        for k, v in pairs(Rock) do
            exports['qb-target']:AddBoxZone(v.name, vec3(v.coords.x, v.coords.y, v.coords.z), v.size.x, v.size.y, {
                name = v.name,
                heading = v.heading,
                debugPoly = Config.Debug,
                minZ = v.coords.z - 1.0,
                maxZ = v.coords.z + 1.0
                }, {
                    options = {
                        {
                            type = "server",
                            event = "cmining:server:checkpickaxe",
                            icon = Config.RockSettings.TargetIcon,
                            label = Target.LabelRock,
                            job = Config.Job,
                            drawDistance = Config.TargetSettings.DrawDistance,
                            drawColor = Config.TargetSettings.DrawColor
                        }
                    },
                    distance = Config.TargetSettings.Distance
                })
        end

        if Config.BarrelSettings.Enable then
            for k, v in pairs(Barrel) do
                exports['qb-target']:AddBoxZone(v.name, vec3(v.coords.x, v.coords.y, v.coords.z), v.size.x, v.size.y, {
                    name = v.name,
                    heading = v.heading,
                    debugPoly = Config.Debug,
                    minZ = v.coords.z - 0.5,
                    maxZ = v.coords.z + 0.5
                    }, {
                        options = {
                            {
                                type = "client",
                                event = "cmining:search",
                                icon = Config.BarrelSettings.TargetIcon,
                                label = Target.LabelBarrel,
                                job = Config.Job,
                                drawDistance = Config.TargetSettings.DrawDistance,
                                drawColor = Config.TargetSettings.DrawColor
                            }
                        },
                        distance = Config.TargetSettings.Distance
                    })
            end
        else end

    elseif Config.Target == "custom" then
        for k, v in pairs(Rock) do
           -- You can add your code here! 
        end
    end
end)

RegisterNetEvent('cmining:progress', function()
    if Config.PedSettings.ProgressEnable then

        if Config.Progress == "qb" then
            exports['progressbar']:Progress({
                name = "SpeakBossMine",
                label = Menu.ProgressLabel,
                duration = Config.PedSettings.DurationOpenMenu * 1000,
                useWhileDead = false,
                canCancel = Config.PedSettings.Cancellable,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true
                }
            }, function(cancelled)
                if not cancelled then
                    TriggerEvent('cmining:openmenu')
                else end
            end)

        elseif Config.Progress == "progresscircle" then
            FreezeEntityPosition(PlayerPedId(), true)
            if lib.progressCircle({
                label = Menu.ProgressLabel,
                duration = Config.PedSettings.DurationOpenMenu * 1000,
                position = Config.PedSettings.PositionProgress,
                useWhileDead = false,
                canCancel = Config.PedSettings.Cancellable,
                disable = {
                    car = true
                }
            }) then
                TriggerEvent('cmining:openmenu')
                FreezeEntityPosition(PlayerPedId(), false)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end

        elseif Config.Progress == "progressbar" then
            FreezeEntityPosition(PlayerPedId(), true)
            if lib.progressBar({
                label = Menu.ProgressLabel,
                duration = Config.PedSettings.DurationOpenMenu * 1000,
                useWhileDead = false,
                canCancel = Config.PedSettings.Cancellable,
                disable = {
                    car = true
                }
            }) then
                TriggerEvent('cmining:openmenu')
                FreezeEntityPosition(PlayerPedId(), false)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end

        elseif Config.Progress == "custom" then
            -- You can add your code here!
        end
    else
        TriggerEvent('cmining:openmenu')
    end
end)

RegisterNetEvent('cmining:openmenu', function()
    if Config.Menu == "qb" then
        exports['qb-menu']:openMenu({
            {
                header = Menu.TitleBoss,
                isMenuHeader = true,
            },
            {
                header = Menu.TakePickaxe,
                txt = Menu.TakePickaxe_desc .. Config.Prices.Pickaxe,
                icon = Config.PedSettings.TakePickaxeIcon,
                params = {
                    isServer = true,
                    event = 'cmining:server:purchasepickaxe'
                }
            },
            {
                header = Menu.TakeExplosive,
                txt = Menu.TakeExplosive_desc .. Config.Prices.Explosive,
                icon = Config.PedSettings.TakeExplosiveIcon,
                params = {
                    isServer = true,
                    event = 'cmining:server:purchaseexplosive'
                }
            },
            {
                header = Menu.Garage,
                txt = Menu.Garage_desc,
                icon = Config.PedSettings.GarageIcon,
                params = {
                    isServer = false,
                    event = 'cmining:qb-menu:garage'
                }
            },
            {
                header = Menu.Back
            }
        })

    elseif Config.Menu == "ox" then
        lib.registerContext({
            id = "mining_menu",
            title = Menu.TitleBoss,
            options = {
                {
                    title = Menu.TakePickaxe,
                    description = Menu.TakePickaxe_desc .. Config.Prices.Pickaxe,
                    icon = Config.PedSettings.TakePickaxeIcon,
                    onSelect = function()
                        TriggerServerEvent('cmining:server:purchasepickaxe')
                        TriggerEvent('cmining:openmenu')
                    end
                },
                {
                    title = Menu.TakeExplosive,
                    description = Menu.TakeExplosive_desc .. Config.Prices.Explosive,
                    icon = Config.PedSettings.TakeExplosiveIcon,
                    onSelect = function()
                        TriggerServerEvent('cmining:server:purchaseexplosive')
                        TriggerEvent('cmining:openmenu')
                    end
                },
                {
                    title = Menu.Garage,
                    description = Menu.Garage_desc,
                    icon = Config.PedSettings.GarageIcon,
                    arrow = true,
                    menu = "garage_menu",
                    disabled = true
                }
            }
        })
        lib.registerContext({
            id = "garage_menu",
            title = Menu.Garage,
            menu = "mining_menu",
            options = {
                {
                    title = Menu.TakeVehicle,
                    description = Menu.TakeVehicle_desc,
                    icon = Config.GarageSettings.TakeVehicleIcon,
                    onSelect = function()
                        TriggerEvent('cmining:spawnvehicle')
                    end
                }
            }
        })
        lib.showContext('mining_menu')

    elseif Config.Menu == "custom" then
        -- You can add your code here!
    end
end)

RegisterNetEvent('cmining:qb-menu:garage', function()
    exports['qb-menu']:openMenu({
        {
            header = Menu.Garage,
            isMenuHeader = true,
        },
        {
            header = Menu.TakeVehicle,
            txt = Menu.TakeVehicle_desc,
            icon = Config.GarageSettings.TakeVehicleIcon,
            params = {
                isServer = false,
                event = 'cmining:spawnvehicle'
            }
        },
        {
            header = Menu.Back,
            params = {
                isServer = false,
                event = 'cmining:openmenu'
            }
        }
    })
end)

RegisterNetEvent('cmining:spawnvehicle', function()
    Vehicle = CreateVehicle(Config.GarageSettings.Vehicle, Config.Coords.SpawnVehicle.x, Config.Coords.SpawnVehicle.y, Config.Coords.SpawnVehicle.z, Config.Coords.SpawnVehicle.w, true, true)
    SetVehicleHasBeenOwnedByPlayer(Vehicle, false)

    if Config.GarageSettings.PlateText == false then
        SetVehicleNumberPlateText(Vehicle, "cMining")
    else
        SetVehicleNumberPlateText(Vehicle, Config.GarageSettings.PlateText .. math.random(10000000, 20000000))
    end

    if Config.GarageSettings.DisableRadio then
        SetVehRadioStation(Vehicle, 'OFF')
    end

    if Config.GarageSettings.ForcePlayerDriver then
        TaskWarpPedIntoVehicle(PlayerPedId(), Vehicle, -1)
    end
    TriggerEvent('vehiclekeys:client:SetOwner', GetVehicleNumberPlateText(Vehicle))
    exports['LegacyFuel']:SetFuel(Vehicle, 100.0)
end)

RegisterNetEvent('cmining:opendoor', function()
    if Config.DoorSettings.ProgressEnable then
        if Config.Progress == "qb" then
            exports['progressbar']:Progress({
                name = "DoorExplosion",
                label = Target.ProgressLabelDoor,
                duration = Config.DoorSettings.AnimationDuration * 1000,
                useWhileDead = false,
                canCancel = Config.DoorSettings.Cancellable,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true
                },
                animation = {
                    animDict = Config.DoorSettings.AnimationDict,
                    anim = Config.DoorSettings.Animation,
                    flags = 1
                },
            }, function(cancelled)
                if not cancelled then
                    StopAnimTask(PlayerPedId(), Config.DoorSettings.AnimationDict, Config.DoorSettings.Animation, 1.0)
                    TriggerEvent('cmining:activateexplosive')
                else
                    StopAnimTask(PlayerPedId(), Config.DoorSettings.AnimationDict, Config.DoorSettings.Animation, 1.0)
                end
            end)

        elseif Config.Progress == "progresscircle" then
            FreezeEntityPosition(PlayerPedId(), true)
            if lib.progressCircle({
                label = Target.ProgressLabelDoor,
                duration = Config.DoorSettings.AnimationDuration * 1000,
                position = Config.DoorSettings.PositionProgress,
                useWhileDead = false,
                canCancel = Config.DoorSettings.Cancellable,
                disable = {
                    car = true
                },
                anim = {
                    dict = Config.DoorSettings.AnimationDict,
                    clip = Config.DoorSettings.Animation
                }
            }) then
                StopAnimTask(PlayerPedId(), Config.DoorSettings.AnimationDict, Config.DoorSettings.Animation, 1.0)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('cmining:activateexplosive')
            else
                StopAnimTask(PlayerPedId(), Config.DoorSettings.AnimationDict, Config.DoorSettings.Animation, 1.0)
                FreezeEntityPosition(PlayerPedId(), false)
            end
        elseif Config.Progress == "progressbar" then
            FreezeEntityPosition(PlayerPedId(), true)
            if lib.progressBar({
                label = Target.ProgressLabelDoor,
                duration = Config.DoorSettings.AnimationDuration * 1000,
                useWhileDead = false,
                canCancel = Config.DoorSettings.Cancellable,
                disable = {
                    car = true
                },
                anim = {
                    dict = Config.DoorSettings.AnimationDict,
                    clip = Config.DoorSettings.Animation
                }
            }) then
                StopAnimTask(PlayerPedId(), Config.DoorSettings.AnimationDict, Config.DoorSettings.Animation, 1.0)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('cmining:activateexplosive')
            else
                StopAnimTask(PlayerPedId(), Config.DoorSettings.AnimationDict, Config.DoorSettings.Animation, 1.0)
                FreezeEntityPosition(PlayerPedId(), false)
            end
        elseif Config.Progress == "custom" then
            -- You can add your code here!
        end
    else
        TriggerEvent('cmining:activateexplosive')
    end
end)

RegisterNetEvent('cmining:activateexplosive', function()
    Bomb = CreateObject(Config.PropBomb.Prop, Config.PropBomb.PropCoords.x, Config.PropBomb.PropCoords.y, Config.PropBomb.PropCoords.z, true, true, false)
    SetEntityRotation(Bomb, Config.PropBomb.PropRotation.x, Config.PropBomb.PropRotation.y, Config.PropBomb.PropRotation.z, 0, true)
    FreezeEntityPosition(Bomb, true)
    if Config.Progress == "qb" then
        exports['progressbar']:Progress({
            name = "ActivateExplosive",
            label = Target.ProgressLabelExplosive,
            duration = Config.DoorSettings.WaitingDuration * 1000,
            useWhileDead = false,
            canCancel = false,
            controlDisables = {
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = false
            }
        }, function(cancelled)
            if not cancelled then
                AddExplosion(Config.Coords.Door.x, Config.Coords.Door.y, Config.Coords.Door.z, 2, 0.6, true, false, 2.0)
                DeleteObject(Bomb)
            end
        end)

    elseif Config.Progress == "progresscircle" then
        if lib.progressCircle({
            label = Target.ProgressLabelExplosive,
            duration = Config.DoorSettings.WaitingDuration * 1000,
            position = Config.DoorSettings.PositionProgress,
            useWhileDead = false,
            canCancel = false
        }) then
            AddExplosion(Config.Coords.Door.x, Config.Coords.Door.y, Config.Coords.Door.z, 2, 0.5, true, false, 2.0)
            DeleteObject(Bomb)
        end

    elseif Config.Progress == "progressbar" then
        if lib.progressBar({
            label = Target.ProgressLabelExplosive,
            duration = Config.DoorSettings.WaitingDuration * 1000,
            useWhileDead = false,
            canCancel = false
        }) then
            AddExplosion(Config.Coords.Door.x, Config.Coords.Door.y, Config.Coords.Door.z, 2, 0.5, true, false, 2.0)
            DeleteObject(Bomb)
        end

    elseif Config.Progress == "custom" then
        -- You can add your code here!
    end
end)

RegisterNetEvent('cmining:mine', function()
    if Config.Minigame.MinigameEnable then
        local time = math.random(Config.Minigame.MinimumDuration, Config.Minigame.MaximumDuration)
	    local circle = math.random(Config.Minigame.MinimumCircle, Config.Minigame.MaximumCircle)
	    local success = exports['CircleMinigame']:StartLockPickCircle(circle, time, success)

	    if success then
            if Config.RockSettings.ProgressEnable then
                if Config.Progress == "qb" then
                    exports['progressbar']:Progress({
                        name = "ExtractingRock",
                        label = Target.ProgressLabelRock,
                        duration = Config.RockSettings.DurationMining * 1000,
                        useWhileDead = false,
                        canCancel = Config.RockSettings.Cancellable,
                        controlDisables = {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true
                        },
                        animation = {
                            animDict = Config.RockSettings.AnimationDict,
                            anim = Config.RockSettings.Animation,
                            flags = 1
                        },
                        prop = {
                            model = Config.PropPickaxe.Prop,
                            bone = Config.PropPickaxe.PropBone,
                            coords = { x = Config.PropPickaxe.PropCoords.x, y = Config.PropPickaxe.PropCoords.y, z = Config.PropPickaxe.PropCoords.z },
                            rotation = { x = Config.PropPickaxe.PropRotation.x, y = Config.PropPickaxe.PropRotation.y, z = Config.PropPickaxe.PropRotation.z }
                        }
                    }, function(cancelled)
                        if not cancelled then
                            TriggerServerEvent('cmining:server:mining')
                            StopAnimTask(PlayerPedId(), Config.RockSettings.AnimationDict, Config.RockSettings.Animation, 1.0)
                        else
                            StopAnimTask(PlayerPedId(), Config.RockSettings.AnimationDict, Config.RockSettings.Animation, 1.0)
                        end
                    end)

                elseif Config.Progress == "progresscircle" then
                    FreezeEntityPosition(PlayerPedId(), true)
                    if lib.progressCircle({
                        label = Target.ProgressLabelRock,
                        duration = Config.RockSettings.DurationMining * 1000,
                        position = Config.RockSettings.PositionProgress,
                        useWhileDead = false,
                        canCancel = Config.RockSettings.Cancellable,
                        disable = {
                            car = true
                        },
                        anim = {
                            dict = Config.RockSettings.AnimationDict,
                            clip = Config.RockSettings.Animation
                        },
                        prop = {
                            model = Config.PropPickaxe.Prop,
                            bone = Config.PropPickaxe.PropBone,
                            pos = vec3(Config.PropPickaxe.PropCoords.x, Config.PropPickaxe.PropCoords.y, Config.PropPickaxe.PropCoords.z),
                            rot = vec3(Config.PropPickaxe.PropRotation.x, Config.PropPickaxe.PropRotation.y, Config.PropPickaxe.PropRotation.z)
                        }
                    }) then
                        TriggerServerEvent('cmining:server:mining')
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                    end

                elseif Config.Progress == "progressbar" then
                    FreezeEntityPosition(PlayerPedId(), true)
                    if lib.progressBar({
                        label = Target.ProgressLabelRock,
                        duration = Config.RockSettings.DurationMining * 1000,
                        useWhileDead = false,
                        canCancel = Config.RockSettings.Cancellable,
                        disable = {
                            car = true
                        },
                        anim = {
                            dict = Config.RockSettings.AnimationDict,
                            clip = Config.RockSettings.Animation
                        },
                        prop = {
                            model = Config.PropPickaxe.Prop,
                            bone = Config.PropPickaxe.PropBone,
                            pos = vec3(Config.PropPickaxe.PropCoords.x, Config.PropPickaxe.PropCoords.y, Config.PropPickaxe.PropCoords.z),
                            rot = vec3(Config.PropPickaxe.PropRotation.x, Config.PropPickaxe.PropRotation.y, Config.PropPickaxe.PropRotation.z)
                        }
                    }) then
                        TriggerServerEvent('cmining:server:mining')
                        FreezeEntityPosition(PlayerPedId(), false)
                    else
                        FreezeEntityPosition(PlayerPedId(), false)
                    end

                elseif Config.Progress == "custom" then
                    -- You can add your code here!
                end
            else
                TriggerServerEvent('cmining:server:mining')
            end
        else
            TriggerEvent('cmining:notify', Strings.Error, Strings.ExtractFailed, 'error')
        end
    else
        if Config.RockSettings.ProgressEnable then
            if Config.Progress == "qb" then
                exports['progressbar']:Progress({
                    name = "ExtractingRock",
                    label = Target.ProgressLabelRock,
                    duration = Config.RockSettings.DurationMining * 1000,
                    useWhileDead = false,
                    canCancel = Config.RockSettings.Cancellable,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = false,
                        disableMouse = false,
                        disableCombat = true
                    },
                    animation = {
                        animDict = Config.RockSettings.AnimationDict,
                        anim = Config.RockSettings.Animation,
                        flags = 1
                    },
                    prop = {
                        model = Config.PropPickaxe.Prop,
                        bone = Config.PropPickaxe.PropBone,
                        coords = { x = Config.PropPickaxe.PropCoords.x, y = Config.PropPickaxe.PropCoords.y, z = Config.PropPickaxe.PropCoords.z },
                        rotation = { x = Config.PropPickaxe.PropRotation.x, y = Config.PropPickaxe.PropRotation.y, z = Config.PropPickaxe.PropRotation.z }
                    }
                }, function(cancelled)
                    if not cancelled then
                        TriggerServerEvent('cmining:server:mining')
                        StopAnimTask(PlayerPedId(), Config.RockSettings.AnimationDict, Config.RockSettings.Animation, 1.0)
                    else
                        StopAnimTask(PlayerPedId(), Config.RockSettings.AnimationDict, Config.RockSettings.Animation, 1.0)
                    end
                end)

            elseif Config.Progress == "progresscircle" then
                FreezeEntityPosition(PlayerPedId(), true)
                if lib.progressCircle({
                    label = Target.ProgressLabelRock,
                    duration = Config.RockSettings.DurationMining * 1000,
                    position = Config.RockSettings.PositionProgress,
                    useWhileDead = false,
                    canCancel = Config.RockSettings.Cancellable,
                    disable = {
                        car = true
                    },
                    anim = {
                        dict = Config.RockSettings.AnimationDict,
                        clip = Config.RockSettings.Animation
                    },
                    prop = {
                        model = Config.PropPickaxe.Prop,
                        bone = Config.PropPickaxe.PropBone,
                        pos = vec3(Config.PropPickaxe.PropCoords.x, Config.PropPickaxe.PropCoords.y, Config.PropPickaxe.PropCoords.z),
                        rot = vec3(Config.PropPickaxe.PropRotation.x, Config.PropPickaxe.PropRotation.y, Config.PropPickaxe.PropRotation.z)
                    }
                }) then
                    TriggerServerEvent('cmining:server:mining')
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                end

            elseif Config.Progress == "progressbar" then
                FreezeEntityPosition(PlayerPedId(), true)
                if lib.progressBar({
                    label = Target.ProgressLabelRock,
                    duration = Config.RockSettings.DurationMining * 1000,
                    useWhileDead = false,
                    canCancel = Config.RockSettings.Cancellable,
                    disable = {
                        car = true
                    },
                    anim = {
                        dict = Config.RockSettings.AnimationDict,
                        clip = Config.RockSettings.Animation
                    },
                    prop = {
                        model = Config.PropPickaxe.Prop,
                        bone = Config.PropPickaxe.PropBone,
                        pos = vec3(Config.PropPickaxe.PropCoords.x, Config.PropPickaxe.PropCoords.y, Config.PropPickaxe.PropCoords.z),
                        rot = vec3(Config.PropPickaxe.PropRotation.x, Config.PropPickaxe.PropRotation.y, Config.PropPickaxe.PropRotation.z)
                    }
                }) then
                    TriggerServerEvent('cmining:server:mining')
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                end

            elseif Config.Progress == "custom" then
                -- You can add your code here!
            end
        else
            TriggerServerEvent('cmining:server:mining')
        end
    end
end)

RegisterNetEvent('cmining:search', function()
    if Config.BarrelSettings.ProgressEnable then
        if Config.Progress == "qb" then
            exports['progressbar']:Progress({
                name = "SearchBarrel",
                label = Target.ProgressLabelBarrel,
                duration = Config.BarrelSettings.SearchDuration * 1000,
                useWhileDead = false,
                canCancel = Config.BarrelSettings.Cancellable,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                },
                animation = {
                    animDict = Config.BarrelSettings.AnimationDict,
                    anim = Config.BarrelSettings.Animation,
                    flags = 1
                }
            }, function(cancelled)
                if not cancelled then
                    TriggerServerEvent('cmining:server:search')
                    StopAnimTask(PlayerPedId(), Config.BarrelSettings.AnimationDict, Config.BarrelSettings.Animation, 1.0)
                else
                    StopAnimTask(PlayerPedId(), Config.BarrelSettings.AnimationDict, Config.BarrelSettings.Animation, 1.0)
                end
            end)

        elseif Config.Progress == "progresscircle" then
            FreezeEntityPosition(PlayerPedId(), true)
            if lib.progressCircle({
                label = Target.ProgressLabelBarrel,
                duration = Config.BarrelSettings.SearchDuration * 1000,
                position = Config.BarrelSettings.PositionProgress,
                useWhileDead = false,
                canCancel = Config.BarrelSettings.Cancellable,
                disable = {
                    car = true
                },
                anim = {
                    dict = Config.BarrelSettings.AnimationDict,
                    clip = Config.BarrelSettings.Animation
                }
            }) then
                TriggerServerEvent('cmining:server:search')
                FreezeEntityPosition(PlayerPedId(), false)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end

        elseif Config.Progress == "progressbar" then
            FreezeEntityPosition(PlayerPedId(), true)
            if lib.progressBar({
                label = Target.ProgressLabelBarrel,
                duration = Config.BarrelSettings.SearchDuration * 1000,
                useWhileDead = false,
                canCancel = Config.BarrelSettings.Cancellable,
                disable = {
                    car = true
                },
                anim = {
                    dict = Config.BarrelSettings.AnimationDict,
                    clip = Config.BarrelSettings.Animation
                }
            }) then
                TriggerServerEvent('cmining:server:search')
                FreezeEntityPosition(PlayerPedId(), false)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end

        elseif Config.Progress == "custom" then
            -- You can add your code here!
        end
    else
        TriggerServerEvent('cmining:server:search')
    end
end)

RegisterNetEvent('cmining:illness', function()
    Health = GetEntityHealth(PlayerPedId())
    IllnessDamage = SetEntityHealth(PlayerPedId(), Health - Config.BarrelSettings.IllnessDamage)

    TriggerEvent('cmining:notify', Strings.Error, Strings.ObtainingIllness, 'error')
    ShakeGameplayCam(Config.BarrelSettings.Effect, Config.BarrelSettings.EffectIntensity)
    Wait(Config.BarrelSettings.EffectDuration * 1000)
    StopGameplayCamShaking(true)
end)

RegisterNetEvent('cmining:cleaning', function()
    if Config.CleaningSettings.ProgressEnable then
        if Config.Progress == "qb" then
            exports['progressbar']:Progress({
                name = "CleaningRock",
                label = Target.ProgressLabelCleaningRock,
                duration = Config.CleaningSettings.CleaningDuration * 1000,
                useWhileDead = false,
                canCancel = Config.CleaningSettings.Cancellable,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                },
                animation = {
                    animDict = Config.CleaningSettings.AnimationDict,
                    anim = Config.CleaningSettings.Animation,
                    flags = 1
                }
            }, function(cancelled)
                if not cancelled then
                    TriggerServerEvent('cmining:server:cleaning')
                    StopAnimTask(PlayerPedId(), Config.CleaningSettings.AnimationDict, Config.CleaningSettings.Animation, 1.0)
                else
                    StopAnimTask(PlayerPedId(), Config.CleaningSettings.AnimationDict, Config.CleaningSettings.Animation, 1.0)
                end
            end)

        elseif Config.Progress == "progresscircle" then
            FreezeEntityPosition(PlayerPedId(), true)
            if lib.progressCircle({
                label = Target.ProgressLabelCleaningRock,
                duration = Config.CleaningSettings.CleaningDuration * 1000,
                position = Config.CleaningSettings.PositionProgress,
                useWhileDead = false,
                canCancel = Config.CleaningSettings.Cancellable,
                disable = {
                    car = true
                },
                anim = {
                    dict = Config.CleaningSettings.AnimationDict,
                    clip = Config.CleaningSettings.Animation
                }
            }) then
                TriggerServerEvent('cmining:server:cleaning')
                FreezeEntityPosition(PlayerPedId(), false)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end

        elseif Config.Progress == "progressbar" then
            FreezeEntityPosition(PlayerPedId(), true)
            if lib.progressBar({
                label = Target.ProgressLabelCleaningRock,
                duration = Config.CleaningSettings.CleaningDuration * 1000,
                useWhileDead = false,
                canCancel = Config.CleaningSettings.Cancellable,
                disable = {
                    car = true
                },
                anim = {
                    dict = Config.CleaningSettings.AnimationDict,
                    clip = Config.CleaningSettings.Animation
                }
            }) then
                TriggerServerEvent('cmining:server:cleaning')
                FreezeEntityPosition(PlayerPedId(), false)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end

        elseif Config.Progress == "custom" then
            -- You can add your code here!
        end
    else
        TriggerServerEvent('cmining:server:cleaning')
    end
end)

RegisterNetEvent('cmining:sell', function()
    if Config.SellSettings.ProgressEnable then
        if Config.Progress == "qb" then
            exports['progressbar']:Progress({
                name = "CleaningRock",
                label = Target.ProgressLabelSellRock,
                duration = Config.SellSettings.SellDuration * 1000,
                useWhileDead = false,
                canCancel = Config.SellSettings.Cancellable,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                },
                animation = {
                    animDict = Config.SellSettings.AnimationDict,
                    anim = Config.SellSettings.Animation,
                    flags = 1
                },
                prop = {
                    model = Config.PropClipboard.Prop,
                    bone = Config.PropClipboard.PropBone,
                    pos = { x = Config.PropClipboard.PropCoords.x, y = Config.PropClipboard.PropCoords.y, z = Config.PropClipboard.PropCoords.z},
                    rot = { x = Config.PropClipboard.PropRotation.x, y = Config.PropClipboard.PropRotation.y, z = Config.PropClipboard.PropRotation.z},
                },
            }, function(cancelled)
                if not cancelled then
                    TriggerServerEvent('cmining:server:sell')
                    StopAnimTask(PlayerPedId(), Config.SellSettings.AnimationDict, Config.SellSettings.Animation, 1.0)
                else
                    StopAnimTask(PlayerPedId(), Config.SellSettings.AnimationDict, Config.SellSettings.Animation, 1.0)
                end
            end)

        elseif Config.Progress == "progresscircle" then
            FreezeEntityPosition(PlayerPedId(), true)
            if lib.progressCircle({
                label = Target.ProgressLabelSellRock,
                duration = Config.SellSettings.SellDuration * 1000,
                position = Config.SellSettings.PositionProgress,
                useWhileDead = false,
                canCancel = Config.SellSettings.Cancellable,
                disable = {
                    car = true
                },
                anim = {
                    dict = Config.SellSettings.AnimationDict,
                    clip = Config.SellSettings.Animation
                },
                prop = {
                    model = Config.PropClipboard.Prop,
                    bone = Config.PropClipboard.PropBone,
                    pos = vec3(Config.PropClipboard.PropCoords.x, Config.PropClipboard.PropCoords.y, Config.PropClipboard.PropCoords.z),
                    rot = vec3(Config.PropClipboard.PropRotation.x, Config.PropClipboard.PropRotation.y, Config.PropClipboard.PropRotation.z)
                }
            }) then
                TriggerServerEvent('cmining:server:sell')
                FreezeEntityPosition(PlayerPedId(), false)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end

        elseif Config.Progress == "progressbar" then
            FreezeEntityPosition(PlayerPedId(), true)
            if lib.progressBar({
                label = Target.ProgressLabelSellRock,
                duration = Config.SellSettings.SellDuration * 1000,
                useWhileDead = false,
                canCancel = Config.SellSettings.Cancellable,
                disable = {
                    car = true
                },
                anim = {
                    dict = Config.SellSettings.AnimationDict,
                    clip = Config.SellSettings.Animation
                },
                prop = {
                    model = Config.PropClipboard.Prop,
                    bone = Config.PropClipboard.PropBone,
                    pos = vec3(Config.PropClipboard.PropCoords.x, Config.PropClipboard.PropCoords.y, Config.PropClipboard.PropCoords.z),
                    rot = vec3(Config.PropClipboard.PropRotation.x, Config.PropClipboard.PropRotation.y, Config.PropClipboard.PropRotation.z)
                }
            }) then
                TriggerServerEvent('cmining:server:sell')
                FreezeEntityPosition(PlayerPedId(), false)
            else
                FreezeEntityPosition(PlayerPedId(), false)
            end

        elseif Config.Progress == "custom" then
            -- You can add your code here!
        end
    else
        TriggerServerEvent('cmining:server:sell')
    end
end)

RegisterNetEvent('cmining:notify')
AddEventHandler('cmining:notify', function(title, message, msgType)
    if Config.Notification == "qb" then
        QBCore.Functions.Notify(message, msgType, 5000)

    elseif Config.Notification == "ox" then
        lib.notify({
            title = title,
            description = message,
            type = msgType
        })

    elseif Config.Notification == "custom" then
        -- You can add your code here!
    end
end)