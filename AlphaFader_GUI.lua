script_name="AlphaFader"
script_description="Add a fade effect to selected lines using alpha tag"
script_author="Lolkiraly2"
script_version="1.0"

function FadeIn(sub, sel)
    local alpha = 255
    local step = math.floor(255/#sel)

    for si,li in ipairs(sel) do
        
        --Add step and convert hexa
        alpha = alpha - step
        local numhex = string.upper(string.format("%x", alpha))

        local line=sub[li]
        
        --Check first character
        fc = string.sub(line.text, 1, 1)
        if fc  ~= '{' then
            line.text="{\\alpha&H".. numhex .. "}".. line.text

            else
            line.text = insert(line.text,numhex)  

        end 
        
        sub[li]=line        
    end

    return sel
end

function FadeOut(sub, sel)
    local alpha = 0
    local step = math.floor(255/#sel)

    for si,li in ipairs(sel) do
        
        --Add step and convert hexa
        alpha = alpha + step
        local numhex = string.upper(string.format("%x", alpha))

        local line=sub[li]
        
        fc = string.sub(line.text, 1, 1)
        if fc  ~= '{' then
            line.text="{\\alpha&H".. numhex .. "}"..line.text

            else
            line.text = insert(line.text,numhex)  

        end 

        sub[li]=line     
    end
    
    return sel
end

function FadeGradIn(sub, sel, fr)

    --copy line to a temp array
    local lines = {}

    for si,li in ipairs(sel) do
        lines[si] = sub[li]
    end

    local i = 1

    --Modify line
    while i <= #lines do

        local alpha = 255
        local frame = fr
        local stp = math.floor(255/frame)    
        local steps = 0

        --If the i reach the lines lenght than break
        if i+steps == #lines then
            break
        end

        --Modify alpha based on how many frame need to the fade
        while steps < frame do 
            alpha = alpha - stp
            local numhex = string.upper(string.format("%x", alpha))                    
            lines[i+steps].text = insert(lines[i+steps].text,numhex)  
            steps = steps + 1 
        end

        --Find the next section index
        while lines[i].start_time ~= lines[i+steps].start_time  do
            steps = steps + 1 
            -- aegisub.debug.out("i: "..i .. " steps: " .. steps .. "\t(".. lines[i].start_time..") - (".. lines[i+steps].start_time.. ")\n")

            --If the i reach the lines lenght than break
            if i+steps == #lines then
                break
            end
        end
        i = i + steps   
    end

    for si,li in ipairs(sel) do
        sub[li] = lines[si]
    end
    
    return sel
end

function FadeGradOut(sub, sel, fr)

    -- copy line to a temp array
    local lines = {}

    for si, li in ipairs(sel) do
        lines[si] = sub[li]
    end

    local i = #lines

    -- Modify line
    while i >= 0 do

        local alpha = 255
        local frame = fr
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
        end

        -- Find the next section index
        while lines[i].start_time ~= lines[i - steps].start_time do
            steps = steps + 1
           
            -- If the i reach 0 than break
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

function insert(l,a)
    local len = string.len(l)
    local alphatag = "\\alpha&H" .. a .. "&"
    local secondBracketIndex = string.find(l,"}",1)
    local originalTags = string.sub(l, 2, secondBracketIndex -1)
    local newTags = alphatag .. originalTags
    local text = string.sub(l, secondBracketIndex +1, len)

    return "{" .. newTags .. "}" .. text
end

buttons={"Fade in","Fade out", "Gradient fade in", "Gradient fade out", "Cancel"}
dialog_config=
{
    {
        class="label",
        x=0,y=0,width=1,height=1,
        label="(Only for Gradient fade in/out) Frames duration:"
    },
    {
        class="intedit",name="fr",
        x=1,y=0,width=1,height=1,
        min=2
    }
}

function AlphaFader(sub, sel)
    if #sel < 2 then
        aegisub.debug.out("You have to select at least 2 line!")
        
    else

        pressed, results = aegisub.dialog.display(dialog_config,buttons)
        
        if pressed== "Cancel" then
            aegisub.cancel()
        end

        if pressed == "Fade in" then
            FadeIn(sub, sel)
        end

        if pressed == "Fade out" then
            FadeOut(sub, sel)
        end

        if pressed == "Gradient fade in" then
            FadeGradIn(sub, sel,results["fr"])
        end

        if pressed == "Gradient fade out" then
            FadeGradOut(sub, sel,results["fr"])
        end

        aegisub.set_undo_point(script_name)
    end
end

aegisub.register_macro(script_name,script_description,AlphaFader)