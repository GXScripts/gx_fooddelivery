Config = {}

Config.Debug = false 

Config.Framework = 'qb' -- can be 'qb', 'qbx'
Config.Inventory = 'codem' -- Can be 'qb', 'ox', 'codem', 'qs'
Config.Progress = 'ox' -- 'ox', 'qb_core' or 'custom' Custom can be added in client/functions.lua
Config.Target = 'qb' -- 'ox' or 'qb' 
Config.Notify = 'ox' --'ox', 'qb', 'okok', 'sd', 'wasabi_notify', or 'custom' can be added in client/functions.lua

Config.JobName = 'Dash Eats'

Config.BossPed = {
    model = `a_m_m_mexlabor_01`, 
    coords =  vector4(-138.6666, -257.1736, 43.5950, 296.4822) 
}

Config.OrderWait = {
    minWait =  10 * 1000,
    maxWait = 15 * 1000
}

Config.Rewards = {
    minReward = 85,
    maxReward = 115
}

Config.Levels = {    -- MAXIMUM OF 5, IF NOT SCRIPT WILL BREAK!!!!! 
    [1] = {
        minRep = 0,
        minBags = 1,
        maxBags = 1,
    },
    [2] = {
        minRep = 100,
        minBags = 1,
        maxBags = 2,
    },
    [3] = {
        minRep = 250,
        minBags = 1,
        maxBags = 3,
    },
    [4] = {
        minRep = 500,
        minBags = 2,
        maxBags = 4,
    },
    [5] = {
        minRep = 1000,
        minBags = 3,
        maxBags = 6,
    },
}


-- DO NOT TOUCH BELOW THIS LINE UNLESS YOU KNOW WHAT YOU ARE DOING!!!



Config.Anims = {
    Boss = {
        label = 'Speaking with boss...',
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = { car = true, move = true, combat = true },
        anim = { dict = 'switch@michael@argue_with_amanda', clip = 'argue_with_amanda_exit_amanda' },
        prop = {} --{ model = 'm23_2_prop_m32_clipboard_01a', bone = 40269, pos = vec3(0.0454, 0.2131, -0.1887), rot = vec3(66.4762, 7.2424, -71.9051) }
    },
    Pickup = {
        label = 'Picking up order...',
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = { car = true, move = true, combat = true },
        anim = { dict = 'mp_common', clip = 'givetake1_a' },
        prop = {} --{ model = 'm23_2_prop_m32_clipboard_01a', bone = 40269, pos = vec3(0.0454, 0.2131, -0.1887), rot = vec3(66.4762, 7.2424, -71.9051) }
    },
    Dropoff = {
        label = 'Delivering order...',
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = { car = true, move = true, combat = true },
        anim = { dict = 'mp_common', clip = 'givetake1_a' },
        prop = { model = 'hei_prop_hei_paper_bag', bone = 40269, pos = vec3(0.0454, 0.2131, -0.1887), rot = vec3(66.4762, 7.2424, -71.9051) }
    },
    Endjob = {
        label = 'Speaking with boss...',
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = { car = true, move = true, combat = true },
        anim = { dict = 'switch@michael@argue_with_amanda', clip = 'argue_with_amanda_exit_amanda' },
        prop = {} --{ model = 'm23_2_prop_m32_clipboard_01a', bone = 40269, pos = vec3(0.0454, 0.2131, -0.1887), rot = vec3(66.4762, 7.2424, -71.9051) }
    },
}

Config.DeliveryPeds = {
    models = {
        [1] = `a_m_m_golfer_01`,
        [2] = `a_m_m_eastsa_02`,
        [3] = `a_f_m_eastsa_02`,
        [4] = `a_f_m_ktown_02`,
        [5] = `a_f_y_epsilon_01`,
        [6] = `a_f_y_hiker_01`,
        [7] = `a_m_m_indian_01`,
        [8] = `a_m_m_prolhost_01`,
    },
    coords = {
        [1] = vec4(-345.2654, 17.8326, 47.8589, 347.3954),
        [2] = vec4(-336.1473, 30.8340, 47.8590, 76.4150),
        [3] = vec4(16.7156, -1443.7799, 30.9495, 152.9087),
        [4] = vec4(-151.4043, -1622.4202, 33.6497, 228.5624),
        [5] = vec4(-150.3365, -1625.7061, 36.8483, 48.8635),
        [6] = vec4(-223.1201, -1585.8873, 34.8693, 271.1638),
        [7] = vec4(-215.7913, -1576.2014, 34.8693, 142.6550),
        [8] = vec4(-205.5922, -1585.5043, 38.0548, 77.3651),
        [9] = vec4(-219.3747, -1579.8755, 38.0545, 232.6063),
        [10] = vec4(-223.1643, -1601.1794, 38.0545, 269.2108),
        [11] = vec4(-208.6817, -1600.7179, 38.0493, 78.3829),
        [12] = vec4(-212.9450, -1618.1766, 38.0545, 357.4903),
        [13] = vec4(46.1221, -1864.2208, 23.2783, 137.4585),
        [14] = vec4(38.9170, -1911.5482, 21.9535, 233.0855),
        [15] = vec4(126.7741, -1930.0903, 21.3824, 30.8791),
        [16] = vec4(338.6404, -1829.6252, 28.3375, 314.5788),
        [17] = vec4(412.3914, -1856.4137, 27.3231, 304.6501),
        [18] = vec4(924.4999, -525.9905, 59.7889, 29.6798),
        [19] = vec4(-712.1069, -1028.6533, 16.4189, 296.9664),
        [20] = vec4(-741.6287, -982.3206, 17.4376, 23.2143),
        [21] = vec4(-938.6498, -1087.8685, 2.1503, 119.7935),
        [22] = vec4(-1034.5640, -1147.1436, 2.1586, 22.2222)
    },
}

Config.PickupPed = `a_m_y_business_02`

Config.PickupLocations = {
    [1] = vec4(-385.1468, 270.1986, 86.3676, 34.5577),
    [2] = vec4(166.3908, -1451.1007, 29.2416, 141.1026),
    [3] = vec4(142.2934, -1520.6729, 29.8369, 321.1959),
    [4] = vec4(144.4549, -1480.3584, 29.3570, 140.1835),
    [5] = vec4(-512.4493, -683.4478, 33.1838, 357.5073),
    [6] = vec4(-584.9154, -896.9753, 25.9460, 176.7270),
    [7] = vec4(-1562.6283, -457.4980, 36.1960, 141.1603),
    [8] = vec4(90.7024, 297.8507, 110.2102, 341.9925),
    [9] = vec4(1247.2024, -350.1788, 69.2048, 346.8612),
    [10] = vec4(1150.5575, -400.5697, 71.5452, 74.3756),
}

AddEventHandler("onResourceStart", function ()
    Wait(2000)
    if GetResourceState('ox_inventory') == 'started' then 
        Config.Inventory = 'ox'
    elseif GetResourceState('qb-inventory') == 'started' then 
        Config.Inventory = 'qb'
    elseif GetResourceState('codem-inventory') == 'started' then
        Config.Inventory = 'codem'
    end
end)