local vgafont = {}

vgafont.codepage_table = {
    cp437 = {
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
    },
}

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

function vgafont.load(path, codepage)
    codepage = codepage or "cp437"
    local to_utf8 = vgafont.codepage_table[codepage]
    if not to_utf8 then
        return nil
    end

    local to_code = {}
    for code, char in pairs(to_utf8) do
        to_code[char] = code
    end

    local file = io.open(path, "rb")
    if not file then
        return nil
    end

    local data = file:read("*a")
    file:close()

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
    local glyphs = {}

    for i = 0, 255 do
        local start = i * char_len + 1
        glyphs[i] = bit_string:sub(start, start + char_len - 1)
    end

    return {
        glyphs   = glyphs,
        codepage = codepage,
        to_utf8  = to_utf8,
        to_code  = to_code,
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

function vgafont.get_glyph(font, code)
    if code == nil or code < 0 or code > 255 then
        return nil
    end
    return font.glyphs[code]
end

function vgafont.get_height(font)
    if font and font.glyphs[0] then
        return math.floor(#font.glyphs[0] / 8)
    end
    return 0
end

function vgafont.draw_char(font, x, y, char, scale, color)
    color = color or {1, 1, 1, 1}
    if type(char) == "number" then
        local bit_str = vgafont.get_glyph(font, char)
        if not bit_str then return end
        vgafont._draw_bitmap(bit_str, x, y, scale, color)
    else
        local code = vgafont.char_to_code(font, char)
        if code == nil then return end
        local bit_str = vgafont.get_glyph(font, code)
        if not bit_str then return end
        vgafont._draw_bitmap(bit_str, x, y, scale, color)
    end
end

function vgafont._draw_bitmap(bit_str, x, y, scale, color)
    scale = scale or 1
    local fh = math.floor(#bit_str / 8)

    love.graphics.setColor(unpack(color))

    for yy = 0, fh - 1 do
        for xx = 0, 7 do
            local idx = yy * 8 + xx + 1
            if bit_str:sub(idx, idx) == "1" then
                love.graphics.rectangle(
                    "fill",
                    x + xx * scale,
                    y + yy * scale,
                    scale,
                    scale
                )
            end
        end
    end
end

function vgafont._utf8_len(byte)
    if byte < 128 then return 1 end
    if byte < 192 then return 0 end
    if byte < 224 then return 2 end
    if byte < 240 then return 3 end
    return 4
end

function vgafont.print(font, text, x, y, scale, color)
    scale = scale or 1
    color = color or {1, 1, 1, 1}
    local fh = vgafont.get_height(font)
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
            vgafont.draw_char(font, cx, cy, c, scale, color)
            cx = cx + char_w
        end

        i = i + len
    end
end

return vgafont