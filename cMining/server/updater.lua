CreateThread(function()
    Resource = GetCurrentResourceName()
    GitHubrepository = "/rayzenoam/" .. Resource

    function Checkversion(err, responseText, headers)
        CurrentVersion = LoadResourceFile(Resource, "version")
        RepositoryVersion = json.decode(responseText)

        if CurrentVersion ~= RepositoryVersion and tonumber(CurrentVersion) < tonumber(RepositoryVersion) then
            print("^3The version " .. RepositoryVersion .. " of the cMining resource has just been released! (Your version: " .. CurrentVersion .. ")")
            print("https://github.com" .. GitHubrepository .. "^0")

        elseif tonumber(CurrentVersion) > tonumber(RepositoryVersion) then
            print("^1An error occurred while searching for your current version. Please inform the resource developer about it.^0")
        else
            print("^2The " .. Resource .. " resource is up to date! (Your version: " .. CurrentVersion .. ")^0")
        end
    end

    PerformHttpRequest("https://raw.githubusercontent.com"..GitHubrepository.."/main/cMining/version", Checkversion, "GET")
end)