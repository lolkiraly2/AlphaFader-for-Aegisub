script_name="AlphaFaderOut"
script_description="Add a fade out effect to selected lines using alpha"
script_author="Lolkiraly2"
script_version="1.0"

--Main processing function
    function fadeout(sub, sel)
        local alpha = 0
        local step = math.floor(255/#sel)
        --Go through all the lines in the selection
        --Keep in mind that si is the index in sel, while li is the line number in sub
        for si,li in ipairs(sel) do
            
            --Add step and convert hexa
            alpha = alpha + step
            local numhex = string.upper(string.format("%x", alpha))

            --Read in the line
            local line=sub[li]
            
            fc = string.sub(line.text, 1, 1)
            if fc  ~= '{' then
                line.text="{\\alpha&H".. numhex .. "}"..line.text

                else
                line.text = insert(line.text,numhex)  

            end 
            
            --Put the line back into the subtitles
            sub[li]=line
            
        end
        
        --Set undo point and maintain selection
        aegisub.set_undo_point(script_name)
        return sel
    end

    --Insert the alpha tag to the tags and return with the full line
    function insert(l,a)
        local len = string.len(l)
        local alphatag = "\\alpha&H" .. a .. "&"
        local secondBracketIndex = string.find(l,"}",1)
        local originalTags = string.sub(l, 2, secondBracketIndex -1)
        local newTags = alphatag .. originalTags
        local text = string.sub(l, secondBracketIndex +1, len)
    
        return "{" .. newTags .. "}" .. text
    end
    aegisub.register_macro(script_name,script_description,fadeout)