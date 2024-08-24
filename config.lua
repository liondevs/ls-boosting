Config = {}

Config.CentralBlip = false
Config.TargetPedLoc = vector4(930.41, -1499.04, 30.35, 356.04)
Config.TargetPed = 's_m_y_strvend_01'
Config.EnemyPed = true
Config.EnemyPeds = 'g_m_y_mexgoon_01' -- Model name of enemy ped
Config.EnemyAmount = 4 -- How many enemy peds to protect the contract vehicle?
Config.EnemyWeapon = 'weapon_bat' -- Weapon used by the enemy ped
Config.notifyType = 'phone' -- phone/chat/false (*false will give you notification)
Config.Menu = 'qb-menu' -- qb-menu/nh-context/esx
Config.Target = 'qb-target' -- QB or OX
Config.EnableCooldown = true
Config.Cooldown = 25 -- Cooldown In Minutes

Config.HackDevice = 'vpntracker' -- Devive to hack the tracker
Config.DealerCurrency = 'lionel' -- Reward and Shop Currency 

Config.items = { -- Exclusive Dealer Shop
  {label = 'Tuner Chip', name = 'tunerlaptop', price = 50000},
  {label = 'Fake Plate', name = 'fakeplate', price = 100000},
  {label = 'Nitrous', name = 'nitrous', price = 200000},
  {label = 'Racing Harness', name = 'harness', price = 100000},
  {label = 'Advanced Lockpick', name = 'advancedlockpick', price = 25000},
  {label = 'Advanced Repairkit', name = 'advancedrepairkit', price = 15000},
  {label = 'Handcuffs', name = 'handcuffs', price = 10000},
  {label = 'Tracking Remover', name = 'vpntracker', price = 5000},
}

Config.List = {
  ['1'] = {
    [1] = {model = 'baller', name = 'Baller', price = 250, reps = 5}, -- price = reward nito money, reps = how much XP u wanna give on job 100XP = 1 Reputation
    [2] = {model = 'tampa', name = 'Tampa', price = 250, reps = 5},
    [3] = {model = 'intruder', name = 'Intruder', price = 100, reps = 5},
    [4] = {model = 'vigero', name = 'Vigero', price = 150, reps = 5},
    [5] = {model = 'ingot', name = 'Ingot', price = 150, reps = 5},
    [6] = {model = 'surge', name = 'Surge', price = 100, reps = 5},
  },
  ['2'] = {
    [1] = {model = 'z190', name = 'Z190', price = 1000, reps = 5},
    [2] = {model = 'zion3', name = 'Zion', price = 1000, reps = 5},
    [3] = {model = 'ztype', name = 'ZType', price = 1500, reps = 10},
    [4] = {model = 'sentinel3', name = 'Sentinel', price = 1750, reps = 10},
    [5] = {model = 'sultan', name = 'Sultan', price = 1000, reps = 5},
    [6] = {model = 'stratum', name = 'Stratum', price = 1500, reps = 5},
  },
  ['3'] = {
    [1] = {model = 'furoregt', name = 'FuroreGT', price = 1750, reps = 5},
    [2] = {model = 'comet2', name = 'Comet', price = 1750, reps = 5},
    [3] = {model = 'blista3', name = 'Blista', price = 2000, reps = 10},
    [4] = {model = 'tailgater', name = 'Tailgater', price = 2250, reps = 10},
    [5] = {model = 'schafter4', name = 'Schafter', price = 1750, reps = 5},
    [6] = {model = 'monroe', name = 'Monroe', price = 2000, reps = 5},
  },
  ['4'] = {
    [1] = {model = 'lynx', name = 'Lynx', price = 2000, reps = 5},
    [2] = {model = 'penumbra', name = 'Penumbra', price = 2000, reps = 5},
    [3] = {model = 'ninef', name = 'NineF', price = 2000, reps = 5},
    [4] = {model = 'coquette', name = 'Coquette', price = 2750, reps = 15},
    [5] = {model = 'rapidgt', name = 'RapidGT', price = 2000, reps = 5},
    [6] = {model = 'banshee', name = 'Banshee', price = 2000, reps = 10},
  },
  ['5'] = {
    [1] = {model = 'kuruma', name = 'Kuruma', price = 2500, reps = 5},
    [2] = {model = 'jester3', name = 'Jester', price = 3000, reps = 15},
    [3] = {model = 'komoda', name = 'Komoda', price = 2250, reps = 5},
    [4] = {model = 'elegy', name = 'Elegy', price = 3250, reps = 15},
    [5] = {model = 'drafter', name = 'Drafter', price = 4000, reps = 10},
    [6] = {model = 'feltzer2', name = 'Feltzer', price = 2500, reps = 10},
  },
  ['6'] = {
    [1] = {model = 'specter2', name = 'Specter', price = 2750, reps = 5},
    [2] = {model = 'seven70', name = 'Seven70', price = 3500, reps = 15},
    [3] = {model = 'schlagen', name = 'Schlagen', price = 1000, reps = 5},
    [4] = {model = 'raiden', name = 'Raiden', price = 2500, reps = 5},
    [5] = {model = 'tenf', name = 'Tenf', price = 4500, reps = 10},
    [6] = {model = 'khamelion', name = 'Khamelion', price = 1750, reps = 5},
  },
  ['7'] = {
    [1] = {model = 'growler', name = 'Growler', price = 3500, reps = 5},
    [2] = {model = 'comet5', name = 'Comet', price = 4000, reps = 15},
    [3] = {model = 'vstr', name = 'VSTR', price = 1500, reps = 5},
    [4] = {model = 'sugoi', name = 'Sugoi', price = 3000, reps = 5},
    [5] = {model = 'sultan3', name = 'Sultan', price = 3500, reps = 10},
    [6] = {model = 'cheetah2', name = 'Cheetah', price = 2250, reps = 5},
  },
  ['8'] = {
    [1] = {model = 'torero', name = 'Torero', price = 4000, reps = 5},
    [2] = {model = 'ardent', name = 'Ardent', price = 4500, reps = 15},
    [3] = {model = 'vectre', name = 'Vectre', price = 5000, reps = 10},
    [4] = {model = 'euros', name = 'Euros', price = 5500, reps = 10},
    [5] = {model = 'jester4', name = 'Jester', price = 4250, reps = 10},
    [6] = {model = 'cypher', name = 'Cypher', price = 5500, reps = 10},
  },
  ['9'] = {
    [1] = {model = 'entityxf', name = 'EntityXF', price = 7500, reps = 15},
    [2] = {model = 'autarch', name = 'Autarch', price = 8000, reps = 10},
    [3] = {model = 'gb200', name = 'GB200', price = 6000, reps = 10},
    [4] = {model = 'furia', name = 'Furia', price = 6500, reps = 10},
    [5] = {model = 'infernus', name = 'Infernus', price = 7500, reps = 15},
    [6] = {model = 'carbonizzare', name = 'Carbonizzare', price = 6500, reps = 10},
  },
  ['10'] = {
    [1] = {model = 'entityxf', name = 'EntityXF', price = 8000, reps = 15},
    [2] = {model = 'fmj', name = 'FMJ', price = 8500, reps = 10},
    [3] = {model = 'turismor', name = 'TurismoR', price = 9500, reps = 10},
    [4] = {model = 'zentorno', name = 'Zentorno', price = 9000, reps = 20},
    [5] = {model = 'sc1', name = 'SC1', price = 8000, reps = 15},
    [6] = {model = 'tigon', name = 'Tigon', price = 8500, reps = 15},
  },
  ['11'] = {
    [1] = {model = 'adder', name = 'adder', price = 12500, reps = 15},
    [2] = {model = 'cheetah', name = 'Cheetah', price = 14000, reps = 10},
    [3] = {model = 'turismor', name = 'TurismoR', price = 13000, reps = 10},
    [4] = {model = 'tyrant', name = 'Tyrant', price = 14500, reps = 20},
    [5] = {model = 't20', name = 'T20', price = 15000, reps = 15},
    [6] = {model = 'vacca', name = 'Vacca', price = 12500, reps = 15},
  },
  ['12'] = {
    [1] = {model = 'thrah', name = 'THRah', price = 25000, reps = 15},
    [2] = {model = 'voltic', name = 'Voltic', price = 22500, reps = 10},
    [3] = {model = 'italigtb', name = 'ItaliGTB', price = 32500, reps = 15},
    [1] = {model = 'osiris', name = 'Osiris', price = 40000, reps = 15},
    [2] = {model = 't20', name = 'T20', price = 25000, reps = 15},
    [3] = {model = 'deveste', name = 'Deveste', price = 37500, reps = 10},
  },
  ['13'] = {
    [1] = {model = 'bullet', name = 'Bullet', price = 42500, reps = 10},
    [2] = {model = 'pfister811', name = 'Pfister811', price = 47500, reps = 10},
    [3] = {model = 'italigtb', name = 'ItaliGTB', price = 45000, reps = 15},
    [1] = {model = 'osiris', name = 'Osiris', price = 50000, reps = 15},
    [2] = {model = 'tempesta', name = 'Tempesta', price = 40000, reps = 10},
    [3] = {model = 'nero', name = 'Nero', price = 42500, reps = 10},
  },
  ['14'] = {
    [1] = {model = 'bullet', name = 'Bullet', price = 75000, reps = 10},
    [2] = {model = 'pfister811', name = 'Pfister811', price = 60000, reps = 10},
    [3] = {model = 'cyclone', name = 'Cyclone', price = 65000, reps = 15},
    [4] = {model = 'reaper', name = 'Reaper', price = 55000, reps = 10},
    [5] = {model = 'tempesta', name = 'Tempesta', price = 52500, reps = 10},
    [6] = {model = 'zentorno', name = 'Zentorno', price = 52500, reps = 10},
  },
  ['15'] = {
    [1] = {model = 'xa21', name = ' XA21', price = 75000, reps = 15},
    [2] = {model = 'emerus', name = 'Emerus', price = 80000, reps = 15},
    [3] = {model = 'cyclone', name = 'Cyclone', price = 70000, reps = 15},
    [4] = {model = 'reaper', name = 'Reaper', price = 65000, reps = 10},
    [5] = {model = 'krieger', name = 'Krieger', price = 87500, reps = 20},
    [6] = {model = 'neon', name = 'Neon', price = 90000, reps = 20},
  },
}