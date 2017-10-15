local env = triggerClientEvent and "SERVER" or "CLIENT"
local tester = createObject(1337, -100, -100, 0) 
tester.id = "tester" .. env

-- As in https://bugs.mtasa.com/view.php?id=9742
local testShapeVec = ColShape.Polygon(
	Vector2(0,0),
	Vector2(20,10),
	Vector2(300,10),
	Vector2(10,300),
	Vector2(250,3000),
	Vector2(500,600)
)
testShapeVec.id = "testShapeVec" .. env

local testShapeNum = ColShape.Polygon(0, 0, 20, 10, 300, 10, 10, 300, 250, 3000, 500, 600)
testShapeNum.id = "testShapeNum" .. env

-- For extra tests
outputDebugString("----------- START - THE WARNINGS BELOW REGARDING EXPECTED ARGUMENTS TYPES ARE FINE")
local testInvalidShapesVec = {
	ColShape.Polygon(
		Vector2(0,0)
	),
	
	ColShape.Polygon(
		Vector2(0,0),
		Vector2(20,10)
	),

	ColShape.Polygon(
		Vector2(0,0),
		Vector2(20,10),
		Vector2(300,10)
	),
}

local testInvalidShapesNum = {
	ColShape.Polygon(0, 0),
	
	ColShape.Polygon(0, 0, 20, 10),

	ColShape.Polygon(0, 0, 20, 10, 300, 10)
}
outputDebugString("----------- END - THE WARNINGS ABOVE REGARDING EXPECTED ARGUMENTS TYPES ARE FINE")

function assertEqual(value1, value2)
	local status, err = pcall(
		function ()
			if value1 ~= value2 then
				error(("[%.2f] %s: Expected '%s' to equal '%s'"):format(math.random(), env, tostring(value1), tostring(value2)), 4)
			end
		end
	)

	if err then
		outputDebugString(err, 1)
		return false
	else
		outputDebugString(("[%.2f] %s: '%s' equals '%s', test passed"):format(math.random(), env, tostring(value1), tostring(value2)))
		return true
	end
end

function assertElementWithinColShape(element, colshape)
	local status, err = pcall(
		function ()
			if not element:isWithinColShape(colshape) then
				error(("[%.2f] %s: Expected element '%s' to be within ColShape '%s'"):format(math.random(), env, element.id, colshape.id), 4)
			end
		end
	)

	if err then
		outputDebugString(err, 1)
		return false
	else
		outputDebugString(("[%.2f] %s: '%s' is within ColShape '%s', test passed"):format(math.random(), env, element.id, colshape.id))
		return true
	end
end

outputDebugString("Check if dummy tester is element")
assertEqual(isElement(tester), true)

outputDebugString("Check if testShapeVec is element")
assertEqual(isElement(testShapeVec), true)

outputDebugString("Check if testShapeNum is element")
assertEqual(isElement(testShapeNum), true)


outputDebugString("Check if testShapeVec has proper shape")
tester.position = Vector3(192.156, 588.161, 0)
assertElementWithinColShape(tester, testShapeVec)

tester.position = Vector3(258.240, 2527.040, 0)
assertElementWithinColShape(tester, testShapeVec)

tester.position = Vector3(442.044, 634.085, 0)
assertElementWithinColShape(tester, testShapeVec)


outputDebugString("Check if testShapeNum has proper shape")
tester.position = Vector3(192.156, 588.161, 0)
assertElementWithinColShape(tester, testShapeNum)

tester.position = Vector3(258.240, 2527.040, 0)
assertElementWithinColShape(tester, testShapeNum)

tester.position = Vector3(442.044, 634.085, 0)
assertElementWithinColShape(tester, testShapeNum)

outputDebugString("Check if shapes are not created when insufficient amount of points was given")
for _, shape in ipairs(testInvalidShapesVec) do
	assertEqual(shape, false)
end

for _, shape in ipairs(testInvalidShapesNum) do
	assertEqual(shape, false)
end