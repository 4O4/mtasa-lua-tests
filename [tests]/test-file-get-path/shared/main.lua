local expectedPath = ":editor/test.txt"
local file = File.exists(expectedPath) and File(expectedPath) or File.new(expectedPath) 
local env = triggerClientEvent and "SERVER" or "CLIENT"

function assertEqual(value1, value2)
	local status, err = pcall(
		function ()
			if value1 ~= value2 then
				error(("[%.2f] %s: Expected '%s' to equal '%s'"):format(math.random(), env, value1, value2), 4)
			end
		end
	)

	if err then
		outputDebugString(err, 1)
	else
		outputDebugString(("[%.2f] %s: '%s' equals '%s', test passed"):format(math.random(), env, value1, value2))
	end
end

if file then 
	assertEqual(expectedPath, fileGetPath(file))
	assertEqual(expectedPath, file.path)
	assertEqual(expectedPath, file:getPath())

	file:close()
end