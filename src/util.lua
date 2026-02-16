PI = 3.14159265359
TWO_PI = 2 * PI

-- adds resource folder to beginning of path
function URes (str)
    return "../res/" .. str
end

-- converts degrees to radians
function UToRadians (degAngle)
	return degAngle * (TWO_PI / 360.0)
end

-- converts radians to degrees
function UToDegrees (radAngle)
	return radAngle * (360.0 / TWO_PI)
end

-- performs func on each element of the table
function UForEach (tbl, func)
    for i=1,#tbl do
        func(tbl[i])
    end
end

-- performs func on each element of the table, passes index as well
function UForEachIndexed (tbl, func)
    for i=1,#tbl do
        func(i, tbl[i])
    end
end