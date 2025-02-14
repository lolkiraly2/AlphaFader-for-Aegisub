script_name = "AlphaFaderGradOut"
script_description = "Add a fade out effect to a gradiant FBF lines"
script_author = "Lolkiraly2"
script_version = "1.0"

-- Main processing function
function FadeGradOut(sub, sel)

    -- copy line to a temp array
    local lines = {}

    for si, li in ipairs(sel) do
        lines[si] = sub[li]
    end

    local i = #lines

    -- Modify line
    while i >= 0 do

        local alpha = 255
        local frame = 10
        local stp = math.floor(255 / frame)
        local steps = 0

        -- If the i reach the lines lenght than break
        if i - steps == 0 then
            break
        end

        -- Modify alpha based on how many frame need to the fade
        while steps < frame do
            alpha = alpha - stp
            local numhex = string.upper(string.format("%x", alpha))
            lines[i - steps].text = insert(lines[i - steps].text, numhex)
            steps = steps + 1
            -- aegisub.debug.out("i: "..i .. " steps: " .. steps .. "\n")
        end

        -- aegisub.debug.out("Kilepett az alfasitasbol\n")

        -- Find the next section index
        while lines[i].start_time ~= lines[i - steps].start_time do
            steps = steps + 1
            -- aegisub.debug.out("i: "..i .. " steps: " .. steps .. "\t(".. lines[i].start_time..") - (".. lines[i+steps].start_time.. ")\n")

            -- If the i reach the lines lenght than break
            if i - steps == 0 then
                break
            end
        end
        i = i - steps
    end

    for si, li in ipairs(sel) do
        sub[li] = lines[si]
    end

    -- Set undo point and maintain selection
    aegisub.set_undo_point(script_name)
    return sel
end

aegisub.register_macro(script_name, script_description, fadeGrad)

-- Insert the alpha tag to the tags and return with the full line
function insert(l, a)
    local len = string.len(l)
    local alphatag = "\\alpha&H" .. a .. "&"
    local secondBracketIndex = string.find(l, "}", 1)
    local originalTags = string.sub(l, 2, secondBracketIndex - 1)
    local newTags = alphatag .. originalTags
    local text = string.sub(l, secondBracketIndex + 1, len)

    return "{" .. newTags .. "}" .. text
end
