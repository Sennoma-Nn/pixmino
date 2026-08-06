local vgafont = {}

vgafont.codepage_table = {}

function vgafont.register_codepage(name, to_utf8)
    local to_code = {}

    for code, char in pairs(to_utf8) do
        to_code[char] = code
    end

    vgafont.codepage_table[name] = {
        to_utf8 = to_utf8,
        to_code  = to_code,
    }
end

do
    local _cp437_to_utf8 = {
        [0]   = "\0",
        [1]   = "☺", [2]   = "☻", [3]   = "♥", [4]   = "♦", [5]   = "♣",
        [6]   = "♠", [7]   = "•", [8]   = "◘", [9]   = "○", [10]  = "◙",
        [11]  = "♂", [12]  = "♀", [13]  = "♪", [14]  = "♫", [15]  = "☼",
        [16]  = "►", [17]  = "◄", [18]  = "↕", [19]  = "‼", [20]  = "¶",
        [21]  = "§", [22]  = "▬", [23]  = "↨", [24]  = "↑", [25]  = "↓",
        [26]  = "→", [27]  = "←", [28]  = "∟", [29]  = "↔", [30]  = "▲",
        [31]  = "▼", [127] = "⌂",
        [128] = "Ç", [129] = "ü", [130] = "é", [131] = "â", [132] = "ä",
        [133] = "à", [134] = "å", [135] = "ç", [136] = "ê", [137] = "ë",
        [138] = "è", [139] = "ï", [140] = "î", [141] = "ì", [142] = "Ä",
        [143] = "Å", [144] = "É", [145] = "æ", [146] = "Æ", [147] = "ô",
        [148] = "ö", [149] = "ò", [150] = "û", [151] = "ù", [152] = "ÿ",
        [153] = "Ö", [154] = "Ü", [155] = "¢", [156] = "£", [157] = "¥",
        [158] = "₧", [159] = "ƒ", [160] = "á", [161] = "í", [162] = "ó",
        [163] = "ú", [164] = "ñ", [165] = "Ñ", [166] = "ª", [167] = "º",
        [168] = "¿", [169] = "⌐", [170] = "¬", [171] = "½", [172] = "¼",
        [173] = "¡", [174] = "«", [175] = "»", [176] = "░", [177] = "▒",
        [178] = "▓", [179] = "│", [180] = "┤", [181] = "╡", [182] = "╢",
        [183] = "╖", [184] = "╕", [185] = "╣", [186] = "║", [187] = "╗",
        [188] = "╝", [189] = "╜", [190] = "╛", [191] = "┐", [192] = "└",
        [193] = "┴", [194] = "┬", [195] = "├", [196] = "─", [197] = "┼",
        [198] = "╞", [199] = "╟", [200] = "╚", [201] = "╔", [202] = "╩",
        [203] = "╦", [204] = "╠", [205] = "═", [206] = "╬", [207] = "╧",
        [208] = "╨", [209] = "╤", [210] = "╥", [211] = "╙", [212] = "╘",
        [213] = "╒", [214] = "╓", [215] = "╫", [216] = "╪", [217] = "┘",
        [218] = "┌", [219] = "█", [220] = "▄", [221] = "▌", [222] = "▐",
        [223] = "▀", [224] = "α", [225] = "ß", [226] = "Γ", [227] = "π",
        [228] = "Σ", [229] = "σ", [230] = "µ", [231] = "τ", [232] = "Φ",
        [233] = "Θ", [234] = "Ω", [235] = "δ", [236] = "∞", [237] = "φ",
        [238] = "ε", [239] = "∩", [240] = "≡", [241] = "±", [242] = "≥",
        [243] = "≤", [244] = "⌠", [245] = "⌡", [246] = "÷", [247] = "≈",
        [248] = "°", [249] = "∙", [250] = "·", [251] = "√", [252] = "ⁿ",
        [253] = "²", [254] = "■", [255] = "\160",
    }

    local _jisx0201_to_utf8 = {
        [92]  = "¥", [126] = "‾",
        [161] = "｡", [162] = "｢", [163] = "｣", [164] = "､", [165] = "･", 
        [166] = "ｦ", [167] = "ｧ", [168] = "ｨ", [169] = "ｩ", [170] = "ｪ", 
        [171] = "ｫ", [172] = "ｬ", [173] = "ｭ", [174] = "ｮ", [175] = "ｯ", 
        [176] = "ｰ", [177] = "ｱ", [178] = "ｲ", [179] = "ｳ", [180] = "ｴ", 
        [181] = "ｵ", [182] = "ｶ", [183] = "ｷ", [184] = "ｸ", [185] = "ｹ", 
        [186] = "ｺ", [187] = "ｻ", [188] = "ｼ", [189] = "ｽ", [190] = "ｾ", 
        [191] = "ｿ", [192] = "ﾀ", [193] = "ﾁ", [194] = "ﾂ", [195] = "ﾃ", 
        [196] = "ﾄ", [197] = "ﾅ", [198] = "ﾆ", [199] = "ﾇ", [200] = "ﾈ", 
        [201] = "ﾉ", [202] = "ﾊ", [203] = "ﾋ", [204] = "ﾌ", [205] = "ﾍ", 
        [206] = "ﾎ", [207] = "ﾏ", [208] = "ﾐ", [209] = "ﾑ", [210] = "ﾒ", 
        [211] = "ﾓ", [212] = "ﾔ", [213] = "ﾕ", [214] = "ﾖ", [215] = "ﾗ", 
        [216] = "ﾘ", [217] = "ﾙ", [218] = "ﾚ", [219] = "ﾛ", [220] = "ﾜ", 
        [221] = "ﾝ", [222] = "ﾞ", [223] = "ﾟ",
    }

    vgafont.register_codepage("cp437", _cp437_to_utf8)
    _cp437_to_utf8 = nil

    vgafont.register_codepage("jisx0201", _jisx0201_to_utf8)
    _jisx0201_to_utf8 = nil
end

function vgafont.load(path, codepage)
    codepage = codepage or "cp437"
    local cp = vgafont.codepage_table[codepage]
    if not cp then
        return nil
    end

    local to_utf8 = cp.to_utf8
    local to_code = cp.to_code

    local data, size = love.filesystem.read(path)
    if not data then
        return nil
    end

    local bits = {}
    for i = 1, #data do
        local byte = string.byte(data, i)
        local s = ""
        for b = 7, 0, -1 do
            s = s .. ((byte >> b) & 1)
        end
        table.insert(bits, s)
    end

    local bit_string = table.concat(bits)
    local char_len = math.floor(#bit_string / 256)
    local fh = math.floor(char_len / 8)

    local glyphs = {}
    for i = 0, 255 do
        local start = i * char_len + 1
        glyphs[i] = bit_string:sub(start, start + char_len - 1)
    end

    local atlas_w = 16 * 8
    local atlas_h = 16 * fh
    local image_data = love.image.newImageData(atlas_w, atlas_h)

    local out_w = 16 * 10
    local out_h = 16 * (fh + 2)
    local outline_data = love.image.newImageData(out_w, out_h)

    for ci = 0, 255 do
        local col = ci % 16
        local row = math.floor(ci / 16)
        local s = glyphs[ci]

        local ox = col * 8
        local oy = row * fh
        for yy = 0, fh - 1 do
            for xx = 0, 7 do
                if s:sub(yy * 8 + xx + 1, yy * 8 + xx + 1) == "1" then
                    image_data:setPixel(ox + xx, oy + yy, 1, 1, 1, 1)
                end
            end
        end

        local ocx = col * 10 + 1
        local ocy = row * (fh + 2) + 1
        local glyph_mask = {}
        for yy = 0, fh - 1 do
            glyph_mask[yy] = {}
            for xx = 0, 7 do
                glyph_mask[yy][xx] = (s:sub(yy * 8 + xx + 1, yy * 8 + xx + 1) == "1")
            end
        end

        local dirs = {
            {-1,-1},{0,-1},{1,-1},
            {-1, 0},{0, 0},{1, 0},
            {-1, 1},{0, 1},{1, 1},
        }
        for yy = 0, fh + 1 do
            for xx = 0, 9 do
                for _, d in ipairs(dirs) do
                    local gx = xx + d[1] - 1
                    local gy = yy + d[2] - 1
                    if gx >= 0 and gx <= 7 and gy >= 0 and gy <= fh - 1 then
                        if glyph_mask[gy][gx] then
                            outline_data:setPixel(col * 10 + xx, row * (fh + 2) + yy, 1, 1, 1, 1)
                            break
                        end
                    end
                end
            end
        end
    end

    local image = love.graphics.newImage(image_data)
    image:setFilter("nearest", "nearest")

    local image_outline = love.graphics.newImage(outline_data)
    image_outline:setFilter("nearest", "nearest")

    local quads = {}
    local quads_outline = {}
    for ci = 0, 255 do
        local col = ci % 16
        local row = math.floor(ci / 16)
        quads[ci] = love.graphics.newQuad(col * 8, row * fh, 8, fh, atlas_w, atlas_h)
        quads_outline[ci] = love.graphics.newQuad(col * 10, row * (fh + 2), 10, fh + 2, out_w, out_h)
    end

    return {
        image         = image,
        image_outline = image_outline,
        quads         = quads,
        quads_outline = quads_outline,
        height        = fh,
        codepage      = codepage,
        to_utf8       = to_utf8,
        to_code       = to_code,
    }
end

function vgafont.char_to_code(font, char)
    local code = rawget(font.to_code, char)
    if code ~= nil then
        return code
    end

    if #char == 1 then
        local byte = string.byte(char)
        if byte <= 255 and rawget(font.to_utf8, byte) == nil then
            return byte
        end
    end

    return nil
end

function vgafont.get_height(font)
    return font.height
end

function vgafont._utf8_len(byte)
    if byte < 128 then return 1 end
    if byte < 192 then return 0 end
    if byte < 224 then return 2 end
    if byte < 240 then return 3 end
    return 4
end

function vgafont._draw_char_ex(font, x, y, code, scale, color, image, quads)
    local q = quads[code]
    if not q then return end
    love.graphics.setColor(unpack(color))
    love.graphics.draw(image, q, x, y, 0, scale, scale)
end

function vgafont._print_ex(font, text, x, y, scale, color, image, quads)
    local fh = font.height
    local char_w = 8 * scale
    local line_h = fh * scale

    local cx = x
    local cy = y
    local i = 1
    local n = #text

    while i <= n do
        local byte = string.byte(text, i)
        local len = vgafont._utf8_len(byte)
        if len == 0 then len = 1 end

        local c = text:sub(i, i + len - 1)

        if c == "\n" then
            cy = cy + line_h
        elseif c == "\r" then
            cx = x
        else
            local code
            if #c == 1 and string.byte(c) <= 255 then
                local byte_code = string.byte(c)
                if rawget(font.to_utf8, byte_code) == nil then
                    code = byte_code
                else
                    code = rawget(font.to_code, c)
                end
            else
                code = vgafont.char_to_code(font, c)
            end

            if code ~= nil and code >= 0 and code <= 255 then
                vgafont._draw_char_ex(font, cx, cy, code, scale, color, image, quads)
            end
            cx = cx + char_w
        end

        i = i + len
    end
end

function vgafont.draw_char(font, x, y, char, scale, color)
    color = color or {1, 1, 1, 1}
    scale = scale or 1

    local code
    if type(char) == "number" then
        code = char
    else
        code = vgafont.char_to_code(font, char)
    end

    if code == nil or code < 0 or code > 255 then return end

    vgafont._draw_char_ex(font, x, y, code, scale, color, font.image, font.quads)
end

function vgafont.print(font, text, x, y, scale, color)
    scale = scale or 1
    color = color or {1, 1, 1, 1}
    vgafont._print_ex(font, text, x, y, scale, color, font.image, font.quads)
end

function vgafont.print_outlined(font, text, x, y, scale, color, outline_color)
    scale = scale or 1
    color = color or {1, 1, 1, 1}
    outline_color = outline_color or {0, 0, 0, 1}

    vgafont._print_ex(font, text, x - 1, y - 1, scale, outline_color, font.image_outline, font.quads_outline)
    vgafont._print_ex(font, text, x, y, scale, color, font.image, font.quads)
end

return vgafont
