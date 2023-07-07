fx_version 'cerulean'
game 'gta5'

author 'Noam.'
description 'An advanced mining operation system!'
version '1.0'

shared_scripts {
    'configuration/config.lua',
    'configuration/strings.lua',
    --'@ox_lib/init.lua'
}

server_scripts {
    'server/*.lua'
}

client_scripts {
    'client/*.lua'
}

dependencies {
    'qb-core',
    'qb-target',
    'progressbar',
    --'ox_lib'
}

escrow_ignore {
    'configuration/*.lua',
    'configuration/strings_others/*.lua',
    'client/*.lua',
    'installation/items.txt',
    'installation/images/info.txt',
    'version'
}

lua54 'yes'