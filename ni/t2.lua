-- a = {"one", "two", "three"}
-- for i, v in ipairs(a) do
--   print(i, v)
-- end

local i = 1

while i ~= 100 do
    print(i)
    i = i + 1 -- Increment i
end

print("Loop finished. i = " .. i)