QBCore = exports['qb-core']:GetCoreObject() -- Touch this and it's your fault the script won't work. Don't touch.
Config = {} -- Touch this and it's your fault the script won't work. Don't touch.

Config.NotifyType = 'qb'  -- 'qb' for QBCore, 'ox' for ox_lib
Config.BankType = "cash" -- cash or bank
Config.VehicleKey = "qs"  -- Choose between "qb" or "qs"

Config.BoostCommand = "boost" Config.OnlyAdmins = true --Boost command between 1-10. Conifg.OnlyAdmins is true or false. If true, only admins can use the command. If false, everyone can use the command.

-- Here's random events that can happen on random places. You can enable/disable them here! The Borkencar may not be 100% done. just so you know.
Config.Events = {BrokenCar = false, AggressivePed = false, RandomExplosion = false,  DrunkPed = true} -- True or false

Config.PedDialogue = {  -- Things peds can say when you walk past them.
    "Hey, watch where you're going!",
    "What's up? Haven't seen you around here before.",
    "I need a vacation... it's too busy here.",
    "Nice day, isn't it?"
}

Config.TalkChance = 0 -- % chance that the NPC will talk when you walk by

-- start/end time for the drunk ped to make it more realistic.
Config.Drunkped = "a_m_y_hipster_01" -- The model that the drunk ped will be.
Config.Drunkscenario = "WORLD_HUMAN_DRINKING"
Config.StartHour = 18         -- Time when drunkped start showing up
Config.EndHour = 6            -- Time when drunkped stop showing up

Config.AggresivePed = "a_m_m_hillbilly_01" -- The model that the aggressive ped will be.
Config.Carmodels = {"bfinjection", "dloader", "rebel", "sultan"} -- The vehicle models for BrokenCar
Config.CarPeds = {"s_m_m_mechanic_01", "a_m_y_beach_02"} -- The ped models for BrokenCar

Config.MaxSpeed = 300 -- This makes every vehicle on the whole server have a max speed of 250 km/h. This is the default speed for all vehicles. You can change it to whatever you want.
Config.SpecialVehicles = { --Under here you can add vehicles that you want to have a different max speed. You can add as many as you want. Just copy the line and change the name of the vehicle and the speed.
    ["police23"] = 260, ["police45"] = 260, ["police18"] = 260, ["police6"]  = 260, ["police19"] = 260, 
    ["police36"] = 260, ["police10"] = 250, ["police26"] = 250, ["police5"]  = 250, ["police31"] = 250, 
    ["police8"]  = 250, ["police30"] = 250, ["police22"] = 250, ["police13"] = 240, ["police25"] = 240,
    ["police7"]  = 240, ["police35"] = 240, ["police32"] = 240, ["police33"] = 240, ["police2"]  = 240, 
    ["police21"] = 240, ["police43"] = 220, ["police16"] = 220, ["police15"] = 220, ["policeb"]  = 270,
    ["massacro"]  = 150,
}


Config.Blips = { -- Here you can add blips.
    {name = "Taxi", coords = vector3(371.52, -1598.01, 29.29), sprite = 227, color = 1, scale = 0.8},
    {name = "Vanilla Unicorn", coords = vector3(113.50, -1294.68, 48.62), sprite = 121, color = 1, scale = 0.8}
}

-- This is for the Config.Peds - These models that are here, Is the models that will be able to spawn on the vectors in Config.Peds
Config.PedModels = {"a_m_y_business_01", "a_f_y_hipster_01", "a_m_m_farmer_01", "u_m_y_baygor","a_f_y_fitness_01"}

-- This is the scenarios for Config.Peds. These scenarios that are here, Is the scenarios that will be able to be on  the peds Config.Peds
Config.PedScenarios = {"WORLD_HUMAN_SMOKING","WORLD_HUMAN_STAND_MOBILE","WORLD_HUMAN_CHEERING","WORLD_HUMAN_AA_COFFEE"}

Config.Peds = { -- Spawn Random peds, And choose if you want they to have a weapon or not. And if they should be aggressive or not. And between different types of peds it will be per restart.
    {coords = vector3(970.99, -3193.93, -17.42), heading = 214.93, aggressive = false, holdWeapon = true, weapon = "WEAPON_BAT", peds = { "mp_m_avongoon", "mp_m_exarmy_01", "mp_m_weapexp_01" }},
    {coords = vector3(993.18, -3216.14, -17.34), heading = 45.0, aggressive = false, holdWeapon = true, weapon = "WEAPON_PISTOL", peds = { "mp_m_avongoon", "mp_m_exarmy_01", "mp_m_weapexp_01" }},
    {coords = vector3(985.41, -3219.56, -17.34), heading = 326.21, aggressive = false, holdWeapon = true, weapon = "WEAPON_PISTOL",peds = { "mp_m_avongoon", "mp_m_exarmy_01", "mp_m_weapexp_01" }},
    {coords = vector3(3080.25, 5464.29, 23.69), heading = 243.45, aggressive = false, holdWeapon = true, weapon = "weapon_assaultrifle", peds = { "csb_mweather", "csb_rashcosvki", "csb_mweather" }}, --Fjäder
    {coords = vector3(3084.35, 5466.88, 23.64), heading = 170.45, aggressive = false, holdWeapon = true, weapon = "weapon_assaultsmg", peds = { "csb_mweather", "csb_rashcosvki", "csb_mweather" }}, --Fjäder
    {coords = vector3(3107.22, 5416.62, 19.59), heading = 51.20, aggressive = false, holdWeapon = true, weapon = "weapon_assaultsmg", peds = { "csb_mweather", "csb_rashcosvki", "csb_mweather" }}, --Fjäder
    {coords = vector3(3104.69, 5415.16, 19.59), heading = 14.39, aggressive = false, holdWeapon = true, weapon = "weapon_assaultsmg", peds = { "csb_mweather", "csb_rashcosvki", "csb_mweather" }} --Fjäder
}


Config.Props = { --Here you can spawn props wherever you want.
    -- { model = "prop_bench_01a", coords = vector3(-265.00, -960.00, 30.22), heading = 0.0 },
    -- { model = "prop_coffee_cup_trailer", coords = vector3(-268.00, -959.50, 31.22), heading = 45.0 }
}

Config.Vehicles = { -- Here you can spawn vehicles wherever you want.
    -- { model = "adder", coords = vector3(-270.0, -960.0, 31.22), heading = 90.0 }
}

Config.Animals = {{ model = "a_c_rottweiler", coords = vector3(3105.40, 5415.54, 19.59), heading = 2.64 }} -- This is the animals that will spawn on the coords in Config.Animals.

Config.PatrolPeds = {
    {model = "csb_mweather", coords = vector3(3102.30, 5424.48, 19.59), 
        waypoints = {vector3(3099.10, 5434.37, 19.59), vector3(3104.38, 5441.64, 19.59), vector3(3112.85, 5442.57, 19.59), vector3(3119.41, 5440.39, 19.59), vector3(3106.64, 5442.14, 19.59),vector3(3099.73, 5448.78, 19.59),vector3(3095.20, 5457.62, 19.59),vector3(3103.37, 5442.63, 19.59),vector3(3099.01, 5433.67, 19.59),},
        weapon = "WEAPON_CARBINERIFLE"},
        --New Ped
    -- {model = "s_m_y_blackops_01", coords = vector3(3120.50, 5460.30, 19.59), 
    --     waypoints = {vector3(3115.30, 5455.20, 19.59),vector3(3110.45, 5448.15, 19.59),vector3(3105.00, 5443.80, 19.59),vector3(3100.60, 5437.50, 19.59),vector3(3106.90, 5441.35, 19.59),vector3(3112.40, 5445.70, 19.59),vector3(3118.85, 5450.25, 19.59),vector3(3125.20, 5455.10, 19.59),
    --     },
    --     weapon = "WEAPON_CARBINERIFLE" 
    -- }
}

Config.Teleports = {
    {from = vector4(3118.93, 5441.83, 19.59, 350.87), to = vector4(3114.25, 5443.87, 19.59, 62.08)},
    {from = vector4(-500.0, 1000.0, 200.0, 90.0), to = vector4(-450.0, 950.0, 190.0, 90.0)}
}


Config.Sellers = {
    {name = "Juvelerare", pedModel = "s_m_y_dealer_01",  
    -- different places the ped will spawn on. Just have one vector if you want it to be one.
        positions = { vector4(123.4, -1234.5, 29.3, 75.0), vector4(125.4, -1200.5, 29.3, 180.0),},
        blip = false,  -- You want a blip on the ped? the name will be the blip name
        itemsForSale = {{
        name = "guldhalsband", minPrice = 500, maxprice = 0}, 
        name = "diamantring", minprice = 0, maxPrice = 2000},
        {}, negotiationChance = 50,  -- How big of a chance it is for the player to be able to negotiate the price
        acceptNegotiate = true,  -- true or false if the ped even accepts negotiation
        -- Different scenarios that the ped can do
        scenarios = { 
            "WORLD_HUMAN_STAND_IMPATIENT", "WORLD_HUMAN_AA_SMOKE",}
    },
    {name = "krim", pedModel = "s_m_y_chef_01",
        positions = {vector4(-1079.66, -1679.98, 4.58, 327.66),
        },
        blip = false,
        itemsForSale = {
            {name = "ring", minPrice = 250, maxPrice = 300},
            {name = "bracelet", minPrice = 100, maxPrice = 150},
            {name = "chain", minPrice = 100, maxPrice = 130},
            {name = "clock", minPrice = 50, maxPrice = 120},
            {name = "painting", minPrice = 120, maxPrice = 500},
            {name = "earrings", minPrice = 100, maxPrice = 800},
            {name = "catalytic_converter", minprice = 0, maxPrice = 2500},
            {name = "rolex", minprice = 0, maxPrice = 2500},
            {name = "diamond_ring", minPrice = 210, maxPrice = 260},
            {name = "goldchain", minPrice = 210, maxPrice = 250},
            {name = "tenkgoldchain", minPrice = 650, maxPrice = 700},
            {name = "goldbar", minPrice = 450, maxPrice = 950},
            {name = "lockpick", minPrice = 100, maxPrice = 120},
        },
        negotiationChance = 40,
        acceptNegotiate = true,
        scenarios = {"WORLD_HUMAN_SMOKING",
        }
    }
}

-- Generell inställning för förhandling och scenario
Config.Negotiation = {
    minIncrease = 100,  -- Minimum ökning om förhandling accepteras
    maxIncrease = 500,  -- Maximal ökning vid förhandling
    minDecrease = 50,   -- Minimum minskning om NPC:n sänker priset
    maxDecrease = 300,  -- Maximal minskning vid förhandling
}

Config.Shops = { -- Job shops
    {name = "Polisbutik", type = "ped", model = "s_m_y_blackops_02", coords = vector4(-403.36, -379.13, 25.10, 351.24), emote = "WORLD_HUMAN_CLIPBOARD", job = "police", grade = 8,
        items = {
            { name = "weapon_combatpistol", label = "Combat Pistol", price = 0 },
            { name = "weapon_stungun", label = "Tazer", price = 0 },
            { name = "weapon_pumpshotgun", label = "Pump Shotugn", price = 0 },
            { name = "weapon_smg", label = "MP5", price = 0 },
            { name = "weapon_carbinerifle", label = "M4", price = 0 },
            { name = "weapon_nightstick", label = "Nightstick", price = 0 },
            { name = "pistol_ammo", label = "Pistol Ammo", price = 0 },
            { name = "smg_ammo", label = "MP5 Ammo", price = 0 },
            { name = "shotgun_ammo", label = "Sotgun Ammo", price = 0 },
            { name = "rifle_ammo", label = "M4 Ammo", price = 0 },
            { name = "pepperspray", label = "Pepparspray", price = 0 },
            { name = "handcuffs", label = "Handcuffs", price = 0 },
            { name = "weapon_flashlight", label = "Flashlight", price = 0 },
            { name = "empty_evidence_bag", label = "Empty evidence bag", price = 0 },
            { name = "police_stormram", label = "Stormarm", price = 0 },
            { name = "armor", label = "armor", price = 0 },
            { name = "radio", label = "Radio", price = 0 },
            { name = "heavyarmor", label = "Heavy Armor", price = 0 },
            { name = "alcoholtester", label = "Alcohol tester", price = 0 },
        }
    },
    {name = "Polisbutik2", type = "ped", model = "s_m_y_blackops_02", coords = vector4(-402.23, -332.43, 53.26, 207.11), emote = "WORLD_HUMAN_CLIPBOARD", job = "police", grade = 0,
        items = {
            { name = "nikon", label = "Nikoff G900", price = 0 },
            { name = "gsrtestkit", label = "GSR Field Test Kit", price = 0 },
            { name = "dnatestkit", label = "GSR Field Test Kit", price = 0 },
            { name = "drugtestkit", label = "Drog Test Kit", price = 0 },
            { name = "breathalyzer", label = "Alkomätare", price = 0 },
            { name = "accesstool", label = "Access Tool", price = 0 },
            { name = "fingerprintreader", label = "Pro Tech XFR8001", price = 0 },
            { name = "sdcard", label = "SD Card", price = 0 },
            { name = "microfibercloth", label = "Microfiber Cloth", price = 0 },
            { name = "blox", label = "Blox Multisurface", price = 0 },
            { name = "fingerprintkit", label = "Fingerprint Kit", price = 0 },
            { name = "mikrosil", label = "Mikrosil", price = 0 },
            { name = "fingerprinttape", label = "Fingerprint Tape", price = 0 },
        }
    },
    {name = "mecko", type = "ped", model = "mp_m_counterfeit_01", coords = vector4(45.10, -1755.25, 29.61, 224.61), emote = "WORLD_HUMAN_SUPERHERO", job = "mechanic", grade = 0,
        items = {
            { name = "engine_oil", label = "Engine Oil", price = 0 },
            { name = "tyre_replacement", label = "Tyre Replacement", price = 0 },
            { name = "clutch_replacement", label = "Clutch Replacement", price = 0 },
            { name = "air_filter", label = "Air Filter", price = 0 },
            { name = "spark_plug", label = "Spark Plug", price = 0 },
            { name = "suspension_parts", label = "Suspension Parts", price = 0 },
            { name = "brakepad_replacement", label = "Brakepad Replacement", price = 0 },
            { name = "i4_engine", label = "I4 Engine", price = 0 },
            { name = "v6_engine", label = "V6 Engine", price = 0 },
            { name = "v8_engine", label = "V8 Engine", price = 0 },
            { name = "v12_engine", label = "V12 Engine", price = 0 },
            { name = "turbocharger", label = "Turbo", price = 0 },
            { name = "ev_motor", label = "EV Motor", price = 0 },
            { name = "ev_battery", label = "EV Battery", price = 0 },
            { name = "ev_coolant", label = "EV Coolant", price = 0 },
            { name = "awd_drivetrain", label = "AWD Drivetrain", price = 0 },
            { name = "rwd_drivetrain", label = "RWD Drivetrain", price = 0 },
            { name = "fwd_drivetrain", label = "FWD Drivetrain", price = 0 },
            { name = "slick_tyres", label = "Slick Tyres", price = 0 },
            { name = "semi_slick_tyres", label = "Semi Slick Tyres", price = 0 },
            { name = "offroad_tyres", label = "Offroad Tyres", price = 0 },
            { name = "ceramic_brakes", label = "Ceramic Brakes", price = 0 },
            { name = "drift_tuning_kit", label = "Drift Tuning Kit", price = 0 },
            { name = "lighting_controller", label = "Lighting Controller", price = 0 },
            { name = "stancing_kit", label = "Stance Kit", price = 0 },
            { name = "cosmetic_part", label = "Body Kit", price = 0 },
            { name = "respray_kit", label = "Respray Kit", price = 0 },
            { name = "vehicle_wheels", label = "Vehicle Wheels Set", price = 0 },
            { name = "tyre_smoke_kit", label = "Tyre Smoke Kit", price = 0 },
            { name = "bulletproof_tyres", label = "Bulletproof Tyres", price = 0 },
            { name = "extras_kit", label = "Extras Kit", price = 0 },
            { name = "nitrous_bottle", label = "Nitrous Bottle", price = 0 },
            { name = "empty_nitrous_bottle", label = "Empty Nitrous Bottle", price = 0 },
            { name = "nitrous_install_kit", label = "Nitrous Install Kit", price = 0 },
            { name = "cleaning_kit", label = "Cleaning Kit", price = 0 },
            { name = "repair_kit", label = "Vehicle Repair Kit", price = 0 },
            { name = "duct_tape", label = "Duct Tape", price = 0 },
            { name = "performance_part", label = "Performance Part", price = 0 },
            { name = "mechanic_tablet", label = "Mechanic Tablet", price = 0 },
            { name = "manual_gearbox", label = "Manual Gearbox", price = 0 },
        }
    },
    { name = "ambulansen", type = "ped", model = "cs_mrs_thornhill", coords = vector4(74.98, -364.33, 39.38, 254.05), emote = "PROP_HUMAN_ATM", job = nil, grade = 3,
        items = {
            { name = "wheelchair", label = "wheelchair", price = 5000 },
            { name = "crutch", label = "crutch", price = 2500 },
            { name = "bandage", label = "bandage", price = 500 },
            { name = "painkiller", label = "painkiller", price = 500 },
        }
    },
    {name = "outbreak2", type = "ped", model = "g_m_y_lost_01", coords = vector4(-1362.44, -1059.04, 3.61, 125.84), emote = "WORLD_HUMAN_COP_IDLES", job = nil, gang = "outbreakmc", grade = 0,
        items = {
            { name = "whiskey", label = "whiskey", price = 50 },
            { name = "vodka", label = "vodka", price = 50 },
            { name = "beer", label = "Öl", price = 50 },
            { name = "water_bottle", label = "Vatten", price = 10 },
            { name = "ale", label = "ale", price = 50 },
            { name = "whiskey", label = "whiskey", price = 50 },
        }
    },
    {name = "vanillaunicorn", type = "ped", model = "a_m_y_business_02", coords = vector4(132.62, -1277.33, 29.26, 104.82), emote = "WORLD_HUMAN_GOLF_PLAYER", job = nil, gang = nil, grade = 0,
        items = {
            { name = "beer", label = "Öl", price = 80 },
            { name = "whiskey", label = "Whiskey", price = 120 },
            { name = "vodka", label = "Vodka", price = 130 },
            { name = "grape", label = "Grape", price = 85 },
            { name = "wine", label = "Vin", price = 100 },
            { name = "blue_lagoon", label = "Blue Lagoon", price = 130 },
            { name = "midori_sour", label = "Midori Sour", price = 130 },
            { name = "moscow_mule", label = "Moscow Mule", price = 130 },
            { name = "gin_tonic", label = "Gin & Tonic", price = 130 },
            { name = "pilsner", label = "pilsner", price = 90 },
            { name = "bordeaux", label = "Bordeaux", price = 95 },
            { name = "pinot_nior", label = "Pinot Nior", price = 120 },
            { name = "bubbletea_strawberry", label = "Strawberry Bubble Tea", price = 40 },
        }
    },
    { name = "sectiond", type = "ped", model = "a_m_m_farmer_01", coords = vector4(415.22, -1502.89,30.11, 71.43), emote = "PROP_HUMAN_SEAT_CHAIR_DRINK_BEER", job = nil, gang = nil, grade = 0,
        items = {
            { name = "beer", label = "Beer", price = 80 },
            { name = "whiskey", label = "Whiskey", price = 120 },
            { name = "vodka", label = "Vodka", price = 130 },
            { name = "grape", label = "Grape", price = 85 },
            { name = "wine", label = "Vin", price = 100 },
            { name = "blue_lagoon", label = "Blue Lagoon", price = 130 },
            { name = "midori_sour", label = "Midori Sour", price = 130 },
            { name = "moscow_mule", label = "Moscow Mule", price = 130 },
            { name = "gin_tonic", label = "Gin & Tonic", price = 130 },
            { name = "pilsner", label = "pilsner", price = 90 },
            { name = "bordeaux", label = "Bordeaux", price = 95 },
            { name = "pinot_nior", label = "Pinot Nior", price = 120 },
            { name = "bubbletea_strawberry", label = "Strawberry Bubble Tea", price = 40 },
        }
    }
}

Config.VehicleSpawns = {
    {
    {name = "Vanilla Unicorn",  type = "ped", model = "a_m_y_beach_03", scenario = "WORLD_HUMAN_CLIPBOARD", 
        coords = vector4(139.73, -1284.93, 29.36, 306.04),
        spawnCoords = vector4(141.98, -1282.58, 29.34, 299.96),
        job = "vanillaunicorn",
        jobgrade = 0,
        blip = false, 
        vehicles = {
            { model = "stretch", label = "stretch"},
            { model = "btype3", label = "btype3"},
            { model = "speedo4", label = "speedo4"},
        }
    },
    {name = "sjukvardare", type = "ped", model = "a_m_m_rurmeth_01", scenario = "WORLD_HUMAN_CLIPBOARD", 
        coords = vector4(85.14, -442.22, 39.38, 68.73),
        spawnCoords = vector4(77.91, -437.64, 39.38, 68.61),
        job = "ambulance",
        jobgrade = 0,
        blip = false, 
        vehicles = {
            { model = "ambulance", label = "ambulance"},

        }
    }
}

