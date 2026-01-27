fx_version 'cerulean'
game 'gta5'

author 'Naoko Scripts'
description 'NK Starterpack - Free Release'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'qb-core',
    'ox_lib',
    'ox_target',
    'qb-vehiclekeys'
}

lua54 'yes'

