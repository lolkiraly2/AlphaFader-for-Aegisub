x = "hello word!"

print(x)

szam = 500
hex = string.upper(string.format("%x", szam))
print(hex);

d= math.floor(23.5)
print(d)

tomb = {1,2,3,4,5,6}
print(#tomb)

szoveg = "alma"
fc = string.sub(szoveg, 1, 1)
print(fc)

if fc == 'a' then
    print("Hurra")
end

tesztsor ="{\\i0\\pos(707.96,517.53)}alma korte."
alpha = "FF"
function insert(l,a)
    local len = string.len(l)
    local alphatag = "\\alpha&H" .. a .. "&"
    local secondBracketIndex = string.find(l,"}",1)
	local originalTags = string.sub(l, 2, secondBracketIndex -1)
    local newTags = alphatag .. originalTags
    local text = string.sub(l, secondBracketIndex +1, len)

    return "{" .. newTags .. "}" .. text
end

print(insert(tesztsor,alpha))
