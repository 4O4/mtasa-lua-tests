-- As in https://bugs.mtasa.com/view.php?id=9699
local testArea1 = RadarArea(-50, 50, 100, -100, 0, 255, 0, 175)
local testArea2 = RadarArea(-50,-50,100, 100, 0, 255, 0, 175)

assert(isInsideRadarArea(testArea1, 1, 1))
assert(isInsideRadarArea(testArea2, 1, 1))

-- OOP check
assert(testArea1:isInside(1, 1))
assert(testArea2:isInside(1, 1))