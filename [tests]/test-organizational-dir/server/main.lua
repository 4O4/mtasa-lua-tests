assert("[gamemodes]/[assault]/[maps]" == Resource.getFromName("as-cliff").organizationalPath)
assert(""                             == Resource.getFromName("editor_dump").organizationalPath)
assert("[editor]"                     == Resource.getFromName("editor"):getOrganizationalPath())
assert("[web]"                        == getResourceOrganizationalPath(getResourceFromName("resourcemanager")))

--- This should also throw warning:
-- Bad argument @ 'getResourceOrganizationalPath' [Expected resource-data at argument 1, got string 'rubbish']
assert(false                          == getResourceOrganizationalPath("rubbish"))

outputDebugString("You have placed this resource in 'resources/" .. resource.organizationalPath .. " directory'")