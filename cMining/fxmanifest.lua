fx_version 'cerulean'
game 'gta5'

author 'Noam.'
description 'An advanced mining operation system!'
version '1.1'

shared_scripts {
    'configuration/config.lua',
    'configuration/strings.lua',
    --'@ox_lib/init.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

dependencies {
    'qb-core',
    'qb-target',
    'progressbar',
    'LegacyFuel',
    --'ox_lib'
}

lua54 'yes'