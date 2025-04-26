QBCore = exports['qb-core']:GetCoreObject() -- Touch this and it's your fault the script won't work. Don't touch.
Config = {} -- Touch this and it's your fault the script won't work. Don't touch.

Config.NotifyType = 'qb'  -- 'qb' for QBCore, 'ox' for ox_lib
Config.BankType = "cash" -- cash or bank
Config.VehicleKey = "qs"  -- Choose between "qb" or "qs"

Config.BoostCommand = "vehicleboostadmin" Config.OnlyAdmins = true --Boost command between 1-10. Conifg.OnlyAdmins is true or false. If true, only admins can use the command. If false, everyone can use the command.

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
    ["massacro"]  = 150, ["durangocrb"]  = 240,
}


Config.Blips = { -- Here you can add blips.
    {name = "Fire Department", coords = vector3(386.87, 278.16, 109.02), sprite = 60, color = 3, scale = 0.8},
    {name = "Taxi", coords = vector3(371.52, -1598.01, 29.29), sprite = 227, color = 1, scale = 0.8},
    {name = "Vanilla Unicorn", coords = vector3(113.50, -1294.68, 48.62), sprite = 121, color = 1, scale = 0.8},
    {name = "Colombia ", coords = vector3(1443.46, -2622.43, 48.45), sprite = 84, color = 1, scale = 0.8},
    {name = "Motel", coords = vector3(346.62, -199.56, 58.02), sprite = 475, color = 1, scale = 1.2},
    {name = "Roggans Realestate", coords = vector3(-591.80, -344.46, 35.15), sprite = 475, color = 1, scale = 0.8}
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
    --{ model = "panto", coords = vector3(130.06, -1082.40, 29.19), heading = 2.18 },
   -- { model = "faggio", coords = vector3(132.52, -1082.72, 29.19), heading = 3.84 },
   -- { model = "blista", coords = vector3(135.24, -1082.48, 29.19), heading = 38.80 }
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
    {
        name = "jewellery",
        pedModel = "s_m_y_dealer_01",
        positions = {
            vector4(123.4, -1234.5, 29.3, 75.0),
            vector4(125.4, -1200.5, 29.3, 180.0),
        },
        blip = false,
        itemsForSale = {
            {name = "earrings", minPrice = 500, maxPrice = 1000},
            {name = "bracelet", minPrice = 1000, maxPrice = 2000},
        },
        negotiationChance = 50,
        acceptNegotiate = true,
        scenarios = {
            "WORLD_HUMAN_STAND_IMPATIENT",
            "WORLD_HUMAN_AA_SMOKE",
        }
    },
    {
        name = "krim",
        pedModel = "a_f_o_genstreet_01",
        positions = {
            vector4(-1079.66, -1679.98, 4.58, 327.66),
        },
        blip = false,
        itemsForSale = {
            {name = "ring", minPrice = 500, maxPrice = 650},
            {name = "bracelet", minPrice = 200, maxPrice = 300},
            {name = "chain", minPrice = 250, maxPrice = 350},
            {name = "clock", minPrice = 300, maxPrice = 350},
            {name = "painting", minPrice = 750, maxPrice = 1200},
            {name = "earrings", minPrice = 400, maxPrice = 900},
            {name = "kq_expensive_sneakers", minPrice = 950, maxPrice = 1100},
            {name = "kq_expensive_bag", minPrice = 900, maxPrice = 1050},
            {name = "kq_expensive_watch", minPrice = 1000, maxPrice = 1250},
            {name = "catalytic_converter", minPrice = 1000, maxPrice = 3000},
            {name = "rolex", minPrice = 1500, maxPrice = 2500},
            {name = "diamond_ring", minPrice = 400, maxPrice = 600},
            {name = "goldchain", minPrice = 850, maxPrice = 950},
            {name = "tenkgoldchain", minPrice = 1000, maxPrice = 1250},
            {name = "goldbar", minPrice = 1000, maxPrice = 1500},
            {name = "lockpick", minPrice = 200, maxPrice = 300},
        },
        negotiationChance = 40,
        acceptNegotiate = true,
        scenarios = {
            "WORLD_HUMAN_SMOKING",
        }
    }
}

Config.Negotiation = {
    minIncrease = 100,
    maxIncrease = 500,
    minDecrease = 50,
    maxDecrease = 300,
}


Config.Shops = { -- Job shops
    {name = "Polisbutik", type = "ped", model = "s_m_y_blackops_02", coords = vector4(-403.36, -379.13, 25.10, 351.24), emote = "WORLD_HUMAN_CLIPBOARD", job = "police", grade = 0,
        items = {
            { name = "weapon_combatpistol", label = "Sig Sauer P226", price = 0 },
            { name = "weapon_stungun", label = "Tazer", price = 0 },
            { name = "weapon_pumpshotgun", label = "Pump Shotugn", price = 0 },
            { name = "weapon_smg", label = "MP5", price = 0 },
            { name = "weapon_carbinerifle", label = "M4", price = 0 },
            { name = "weapon_nightstick", label = "nightstick", price = 0 },
            { name = "pistol_ammo", label = "Pistol Ammo", price = 0 },
            { name = "smg_ammo", label = "MP5 Ammo", price = 0 },
            { name = "shotgun_ammo", label = "Shotgun Ammo", price = 0 },
            { name = "rifle_ammo", label = "M4 Ammo", price = 0 },
            { name = "pepperspray", label = "Pepperspray", price = 0 },
            { name = "handcuffs", label = "handcuffs", price = 0 },
            { name = "weapon_flashlight", label = "Flashlight", price = 0 },
            { name = "empty_evidence_bag", label = "Empty Evidence Bag", price = 0 },
            { name = "police_stormram", label = "Stormarm", price = 0 },
            { name = "armor", label = "armor", price = 0 },
            { name = "radio", label = "Radio", price = 0 },
            { name = "heavyarmor", label = "heavy armor", price = 0 },
            { name = "alcoholtester", label = "alcoholtester", price = 0 },
            { name = "polisdator", label = "Polis MDT", price = 0 },
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
    {name = "ambulans", type = "ped", model = "s_m_m_doctor_01", coords = vector4(342.82, -580.92, 48.2, 337.64), emote = "WORLD_HUMAN_CLIPBOARD", job = "ambulance", grade = 0,
        items = {
            { name = "medbag",      label = 'Medical Bag',     price = 0 },
            { name = "medikit",     label = 'First-Aid Kit',   price = 0 },
            { name = "morphine30",  label = 'Morphine 30MG',   price = 0 },
            { name = "morphine15",  label = 'Morphine 15MG',   price = 0 },
            { name = "perc30",      label = 'Percocet 30MG',   price = 0 },
            { name = "perc10",      label = 'Percocet 10MG',   price = 0 },
            { name = "perc5",       label = 'Percocet 5MG',    price = 0 },
            { name = "vic10",       label = 'Vicodin 10MG',    price = 0 },
            { name = "vic5",        label = 'Vicodin 5MG',     price = 0 },
            { name = "defib",        label = 'defib',     price = 0 },
            { name = "sedative",        label = 'sedative',     price = 0 },
        }
    }
}

Config.VehicleSpawns = {
    {
        name = "Mecko", -- Name of the vehicle spawn and blip.
        type = "ped", -- ped or prop
        model = "mp_m_weapexp_01", -- Change to a prop name if type = "prop" NEEDS TO BE A UNIQE MODEL
        scenario = "WORLD_HUMAN_CLIPBOARD", -- Scenario for the ped
        coords = vector4(74.58, -1755.21, 29.61, 51.19),
        spawnCoords = vector4(75.97, -1748.98, 29.61, 49.86),
        job = "mechanic", -- What job should be able to use it?
        -- gang = "ballas" -- Uncomment this line if you want to restrict the vehicle to a specific gang instead.
        jobGrade = 0, -- What grade should be able to use it?
        blip = false,
        vehicles = {
            { model = "flatbed2", label = "Ford Bärningsbil 2008" },
            { model = "towtruck2", label = "Ford S331 Bärgningsbil 2006" },
            { model = "towtruck", label = "Ford S331 Bärgningsbil 2012" },
            { model = "fordvan1", label = "Ford Transport 2015" },
            { model = "veln2", label = "Huyndai 2016 Hyrfordon" }
        }
    },
    {name = "Polisbåt",  type = "ped",  model = "s_m_y_hwaycop_01", scenario = "WORLD_HUMAN_CLIPBOARD", 
        coords = vector4(-778.92, -1399.74, 1.60, 48.81),
        spawnCoords = vector4(-786.94, -1399.12, 0.68, 229.38),
        job = "police", 
        jobgrade = 0,
        blip = false, 
        vehicles = { 
            { model = "pboat", label = "Polis Båt"}, 
        }
    },
    {name = "Brandbåt", type = "ped", model = "s_m_y_fireman_01", scenario = "WORLD_HUMAN_CLIPBOARD",
        coords = vector4(-784.95, -1406.00, 1.60, 49.52),
        spawnCoords = vector4(-787.30, -1398.20, 0.12, 231.70),
        job = "firefighter",
        jobgrade = 0,
        blip = false, 
        vehicles = {
            { model = "Dinghy", label = "Dinghy"},
        }
    },
    {name = "fjader", type = "ped", model = "csb_ramp_marine", scenario = "WORLD_HUMAN_CLIPBOARD",
        coords = vector4(3207.26, 5315.19, 2.16, 300.79),
        spawnCoords = vector4(3219.46, 5316.06, 1.04, 255.71),
        job = nil,
        jobgrade = 0,
        blip = false, 
        vehicles = {
            { model = "submersible", label = "Ubåt"},
            { model = "seashark3", label = "Vattenskoter"},
            { model = "dinghy4", label = "4 sitsig Båt"},
        }
    },
    {name = "Vanilla Unicorn",  type = "ped", model = "a_m_y_beach_03", scenario = "WORLD_HUMAN_CLIPBOARD", 
        coords = vector4(139.73, -1284.93, 29.36, 306.04),
        spawnCoords = vector4(141.98, -1282.58, 29.34, 299.96),
        job = "vanillaunicorn",
        jobgrade = 0,
        blip = false, 
        vehicles = {
            { model = "stretch", label = "Limosin"},
            { model = "btype3", label = "Bil"},
            { model = "speedo4", label = "Skåpbil"},
        }
    },
    {name = "Roggans Fastighetsbyrå AB",  type = "ped", model = "cs_tom", scenario = "WORLD_HUMAN_CLIPBOARD", 
        coords = vector4(-594.54, -338.57, 35.16, 31.52),
        spawnCoords = vector4(-598.88, -334.81, 34.24, 300.10),
        job = "realestate",
        jobgrade = 0,
        blip = false, 
        vehicles = {
            { model = "btype", label = "Roosevelt"},
            { model = "x6mf96", label = "BMW X6"},
            { model = "s63m", label = "Mansory"},
        }
    },
    {name = "sjukvardare", type = "ped", model = "a_m_m_rurmeth_01", scenario = "WORLD_HUMAN_CLIPBOARD", 
        coords = vector4(85.14, -442.22, 39.38, 68.73),
        spawnCoords = vector4(77.91, -437.64, 39.38, 68.61),
        job = "ambulance",
        jobgrade = 0,
        blip = false, 
        vehicles = {
            { model = "ambulance10", label = "Mercedes Sprinter 2018"},
            { model = "ambulance1", label = "Mercedes Sprinter 2020"},
            { model = "ambulance11", label = "Mercedes Vito Akutlakare 2016"},
            { model = "ambulance8", label = "Renault Master 2016"},
            { model = "ambulance4", label = "Volkswagen Amarok 2017"},
            { model = "ambulance9", label = "Volvo V70 Akutbil 2016"},
            { model = "ambulance6", label = "Volvo V70 Nilsson 2016"},
            { model = "ambulance2", label = "Volvo V90 Cross Country Akutlakare 2019"},
            { model = "ambulance7", label = "Volvo V90 Cross Country Jourkakare 2019"},
            { model = "ambulance3", label = "Volvo XC70 Cross Country Nilsson 2017"},
            { model = "ambulance5", label = "Volvo XC90 Cross Country Nilsson 2020"},
        }
    }
}

