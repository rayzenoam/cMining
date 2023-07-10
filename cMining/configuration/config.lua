Config = {
Debug = false, -- Enable debug mode.

Menu = "qb", -- qb: qbcore | ox: ox_lib
Target = "qb", -- qb: qbcore
Notification = "qb", -- qb: qbcore | ox: ox_lib
Progress = "qb", -- qb: qbcore | progresscircle: ox_lib (https://imgur.com/2tLbgrW) | progressbar : ox_lib (https://imgur.com/7ZJgLjl)
Key = "qb", -- qb: qbcore
Fuel = "legacy", -- legacy: LegacyFuel

-- "job": You can set exclusive access to a specific job.
-- false: It allows you to bypass the restricted access to a specific job.
Job = false,

-- List of blip sprites and colors: https://docs.fivem.net/docs/game-references/blips/
Blips = {
    {
        label = "Boss",
        coords = vec3(-598.0, 2091.38, 131.40),
        sprite = 801,
        scale = 0.6,
        colour = 5,
        asshortrange = true
    },
    {
        label = "Cleaning",
        coords = vec3(-668.34, 2414.32, 49.42),
        sprite = 464,
        scale = 0.6,
        colour = 0,
        asshortrange = true
    },
    {
        label = "Buyer",
        coords = vec3(2571.54, 2721.63, 42.98),
        sprite = 500,
        scale = 0.6,
        colour = 11,
        asshortrange = true
    }
},

-- You are required to use a Vector4 to define the location of the peds.
-- The resource may not function properly if this requirement is not met.
Coords = {
    Boss = vec4(-598.0, 2091.38, 131.40, 345.51),
    Door = vec4(-596.0, 2088.50, 131.41, 13.96),
    Cleaning = vec4(-668.34, 2414.32, 49.42, 340.94),
    Buyer = vec4(2571.54, 2721.63, 42.98, 213.07),
    SpawnVehicle = vec4(-607.89, 2108.28, 126.91, 108.57)
},

-- List of peds: https://docs.fivem.net/docs/game-references/ped-models/
PedHash = {
    Boss = "s_m_m_dockwork_01",
    Buyer = "a_m_m_indian_01"
},

TargetSettings = {
    Distance = 2.5, -- Maximum interaction distance
    DrawDistance = 10.0, -- Maximum distance of the "DrawSprite" option in qb-target.
    DrawColor = {255, 255, 255, 255} -- HTML color code of the "DrawSprite" option in qb-target. (https://htmlcolorcodes.com/)
},

PedSettings = {
    Invincible = true, -- Determines if the ped is invincible or not.
    Freeze = true, -- Determines if the ped is frozen or not.
    BossTargetIcon = "fa-solid fa-comment", -- Ped Boss targeting icon
    BuyerTargetIcon = "fa-solid fa-store", -- Ped Buyer targeting icon
    TakePickaxeIcon = "cart-shopping", -- Icon for the "Take a pickaxe" option in the boss menu.
    TakeExplosiveIcon = "cart-shopping", -- Icon for the "Take an explosive" option in the boss menu.
    GarageIcon = "warehouse", -- Icon for the "Garage" option in the boss menu.
    ProgressEnable = true, -- Determines if the progress bar is active or not.
    PositionProgress = "bottom", -- Determines the position of the progress bar.
    DurationOpenMenu = 5, -- Determines the duration of the progress bar to open the menu.
    Cancellable = true -- Determines if the progress bar can be stopped or no.
},

GarageSettings = {
    TakeVehicleIcon = "truck", -- Icon for the "To take a vehicle" option in the boss menu.
    ReturnVehicleIcon = "handshake-simple", -- Icon for the "Park your vehicle in the garage" option in the boss menu.
    Vehicle = "speedo", -- Model of the vehicle you want to put in the garage.
    ForcePlayerDriver = true, -- Determine whether you want the player to be placed directly in the driver's seat of the vehicle upon its appearance or not.
    DisableRadio = true, -- Determine whether you want to disable the radio when the player enters the vehicle or not.
    PlateText = false -- You can set a custom license plate on the mine vehicles. You can also disable this option by setting it to false.
},

MeansOfPayment = "cash", -- Payment method used for purchasing and selling items.
AlreadyPickaxe = true, -- Determines if you want the player to have a maximum of one pickaxe in their inventory or not.
AlreadyExplosive = true, -- Determines if you want the player to have a maximum of one explosive in their inventory or not.
Prices = {
    Pickaxe = 200, -- Sets the price of the pickaxe.
    Explosive = 1000, -- Sets the price of an explosive.
    SellCleanRock = 10 -- Sets the selling price of a cleaned rock.
},

DoorSettings = {
    TargetIcon = "fa-solid fa-bomb", -- Door targeting icon
    Distance = 1.0, -- Maximum interaction distance
    ProgressEnable = true, -- Determines if the progress bar is active or not.
    PositionProgress = "bottom", -- Determines the position of the progress bar.
    Cancellable = true, -- Determines if the progress bar can be stopped or no.
    RequiredItem = "explosive", -- Item required to perform the action.
    -- The "AnimationDict" configuration allows you to set the animation that will be played during the interaction.
    -- You can find the list of animations here: https://alexguirre.github.io/animations-list/
    AnimationDict = "weapons@projectile@sticky_bomb",
    Animation = "plant_vertical",
    AnimationDuration = 1.5, -- Duration of the animation.
    WaitingDuration = 10 -- Sets the waiting time before the explosive detonation.
},

PropBomb = {
    Prop = "prop_bomb_01", -- Prop model
    PropCoords = vec3(-596.50, 2088.45, 131.41), -- Prop coordinates on the player.
    PropRotation = vec3(-90.0, -75.0, 16.52) -- Prop rotations on the player.
},

Minigame = {
    MinigameEnable = true, -- Determines if the mini-game during mining is active or not.
    MinimumDuration = 10, -- Minimum duration of the mini-game.
    MaximumDuration = 15, -- Maximum duration of the mini-game.
    MinimumCircle = 1, -- Minimum circle of the mini-game.
    MaximumCircle = 3 -- Maximum circle of the mini-game.
},


-- Minimum amount = Determines the minimum amount that can be given to the player.
-- Maximum amount = Determines the maximum amount that can be given to the player.
-- TotalItem = Determines the total amount of items in the category.
RewardSettings = {
    Rock = {
        MinimumAmount = 1,
        MaximumAmount = 3
    },
    Barrel = {
        MinimumAmount = 1,
        MaximumAmount = 3,
        TotalItem = 2
    },
    Cleaning = {
        MinimumAmount = 1,
        MaximumAmount = 3,
    }
},

RockSettings = {
    TargetIcon = "fa-regular fa-gem", -- Rock targeting icon
    ProgressEnable = true, -- Determines if the progress bar is active or not.
    PositionProgress = "bottom", -- Determines the position of the progress bar.
    DurationMining = 10, -- Determines the duration of the progress bar.
    Cancellable = true, -- Determines if the progress bar can be stopped or no.
    RequiredItem = "pickaxe", -- Determines the required item to perform the action.
    LuckDestroy = 15, -- It allows you to set a percentage chance for the pickaxe to break. You can also disable this option by setting it to false.
    -- The "AnimationDict" configuration allows you to set the animation that will be played during the interaction.
    -- You can find the list of animations here: https://alexguirre.github.io/animations-list/
    AnimationDict = "melee@hatchet@streamed_core",
    Animation = "plyr_front_takedown",
    ReceiveItem = "rock" -- Determines the item received during mining.
},

PropPickaxe = {
    Prop = "prop_tool_pickaxe", -- Prop model
    PropBone = 28422, -- BoneIndex of the prop.
    PropCoords = vec3(0.09, 0.03, -0.02), -- Prop coordinates on the player.
    PropRotation = vec3(-78.00, 13.00, -28.00) -- Prop rotations on the player.
},

BarrelSettings = {
    Enable = true, -- Determines if the barrels are active or not.
    TargetIcon = "fa-regular fa-hand-spock", -- Barrel targeting icon
    ProgressEnable = true, -- Determines if the progress bar is active or not.
    PositionProgress = "bottom", -- Determines the position of the progress bar.
    SearchDuration = 10, -- Determines the duration of the progress bar.
    Cancellable = true, -- Determines if the progress bar can be stopped or no.
    ChanceOfIllness = 5, -- It allows you to set a percentage chance for acquiring an illness. You can also disable this option by setting it to false.
    IllnessDamage = 10, -- Damage that the player will receive upon acquiring the illness.
    Effect = "FAMILY5_DRUG_TRIP_SHAKE", -- Effect that the player obtains upon acquiring the illness. (List of effects: https://docs.fivem.net/natives/?_0xFD55E49555E017CF)
    EffectDuration = 15, -- Duration of the effect upon acquiring the illness.
    EffectIntensity = 0.4, -- Intensity of the effect on the player's screen.
    -- The "AnimationDict" configuration allows you to set the animation that will be played during the interaction.
    -- You can find the list of animations here: https://alexguirre.github.io/animations-list/
    AnimationDict = "amb@prop_human_bum_bin@idle_a",
    Animation = "idle_a",
    ReceiveItem = { -- Determines the items received when searching the barrels.
        "plastic",
        "steel"
    }
},

CleaningSettings = {
    TargetIcon = "fa-solid fa-soap", -- Cleaning targeting icon
    ProgressEnable = true, -- Determines if the progress bar is active or not.
    PositionProgress = "bottom", -- Determines the position of the progress bar.
    CleaningDuration = 5, -- Determines the duration of the progress bar.
    Cancellable = true, -- Determines if the progress bar can be stopped or no.
    RequiredItem = "rock", -- Determines the required item to perform the action.
    -- The "AnimationDict" configuration allows you to set the animation that will be played during the interaction.
    -- You can find the list of animations here: https://alexguirre.github.io/animations-list/
    AnimationDict = "amb@prop_human_bum_bin@idle_a",
    Animation = "idle_a",
    ReceiveItem = "cleanrock" -- Determines the item received when cleaning the rocks.
},

SellSettings = {
    TargetIcon = "fa-solid fa-store", -- Sell targeting icon
    ProgressEnable = true, -- Determines if the progress bar is active or not.
    PositionProgress = "bottom", -- Determines the position of the progress bar.
    SellDuration = 10, -- Determines the duration of the progress bar.
    Cancellable = true, -- Determines if the progress bar can be stopped or no.
    RequiredItem = "cleanrock", -- Determines the required item to perform the action.
    -- The "AnimationDict" configuration allows you to set the animation that will be played during the interaction.
    -- You can find the list of animations here: https://alexguirre.github.io/animations-list/
    AnimationDict = "missfam4",
    Animation = "base"
},

PropClipboard = {
    Prop = "p_amb_clipboard_01", -- Prop model
    PropBone = 60309, -- BoneIndex of the prop.
    PropCoords = vec3(0.00, 0.00, 0.00), -- Prop coordinates on the player.
    PropRotation = vec3(0.0, 0.0, 0.00) -- Prop rotations on the player.
}

}