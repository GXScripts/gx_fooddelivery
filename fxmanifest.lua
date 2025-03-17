fx_version 'cerulean'
game 'gta5'
lua54 'yes'

title 'GX Scripts Food Delivery'
author 'GX Scripts'
version '1.1.1'

client_scripts{
    'client/main.lua',
    'client/functions.lua'
}

server_scripts{
    'server/main.lua',
    'server/functions.lua',
    '@oxmysql/lib/MySQL.lua'
}

shared_scripts{
    'config.lua',
    '@ox_lib/init.lua'
}

files{
    'locales/en.json'
}

dependencies{
	'ox_lib'
}

ox_libs{
    'locale',
    'math'
}