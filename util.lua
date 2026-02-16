PI = 3.14159265359
TWO_PI = 2 * PI

function UToRadians (degAngle)
	return degAngle * (TWO_PI / 360.0)
end

function UToDegrees (radAngle)
	return radAngle * (360.0 / TWO_PI)
end

function UForEach (table, func)
    for i=1,#table do
        func(table[i])
    end
end

function UForEachIndexed (table, func)
    for i=1,#table do
        func(i, table[i])
    end
end