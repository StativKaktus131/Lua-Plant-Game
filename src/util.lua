PI = 3.14159265359
TWO_PI = 2 * PI


-- mouse over
function UMouseOver (rect)
	return MousePos.x > rect[1] and MousePos.y > rect[2] and MousePos.x < rect[1] + rect[3] and MousePos.y < rect[2] + rect[4]
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