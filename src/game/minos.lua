-- Copyright (C) 2026 Sennoma-Nn
-- SPDX-License-Identifier: GPL-3.0-or-later

local PRS_JLSTZ = {
    ["0>R"] = { { 0, 0 }, { -1, 0 }, { -1, 1 }, { 0, -2 }, { -1, -2 }, { 0, 1 } },
    ["R>0"] = { { 0, 0 }, { 0, -1 }, { 1, 0 }, { 1, -1 }, { 0, 2 }, { 1, 2 } },
    ["R>2"] = { { 0, 0 }, { 1, 0 }, { 1, -1 }, { 0, -1 }, { 0, 2 }, { 1, 2 } },
    ["2>R"] = { { 0, 0 }, { -1, 0 }, { -1, -1 }, { -1, 1 }, { 0, -2 }, { -1, -2 } },
    ["2>L"] = { { 0, 0 }, { 1, 0 }, { 1, -1 }, { 1, 1 }, { 0, -2 }, { 1, -2 } },
    ["L>2"] = { { 0, 0 }, { -1, 0 }, { -1, -1 }, { 0, -1 }, { 0, 2 }, { -1, 2 } },
    ["L>0"] = { { 0, 0 }, { 0, -1 }, { -1, 0 }, { -1, -1 }, { 0, 2 }, { -1, 2 } },
    ["0>L"] = { { 0, 0 }, { 1, 0 }, { 1, 1 }, { 0, -2 }, { 1, -2 }, { 0, 1 } },

    ["0>2"] = { { 0, 0 }, { 1, 0 }, { -1, 0 }, { 2, 0 }, { -2, 0 }, { 0, 1 }, { 1, 1 }, { -1, 1 } },
    ["2>0"] = { { 0, 0 }, { -1, 0 }, { 1, 0 }, { -2, 0 }, { 2, 0 }, { 0, -1 }, { -1, -1 }, { 1, -1 } },
    ["R>L"] = { { 0, 0 }, { 0, -1 }, { 0, -2 }, { 1, 0 }, { 1, 2 }, { 1, 1 }, { 0, 2 }, { 0, 1 } },
    ["L>R"] = { { 0, 0 }, { 0, -1 }, { 0, -2 }, { -1, 0 }, { -1, 2 }, { -1, 1 }, { 0, 2 }, { 0, 1 } },
}

local PRS_I     = {
    ["0>R"] = { { 0, 0 }, { -2, 0 }, { 1, 0 }, { -2, -1 }, { 1, 2 } },
    ["R>0"] = { { 0, 0 }, { 2, 0 }, { -1, 0 }, { 2, 1 }, { -1, -2 } },
    ["R>2"] = { { 0, 0 }, { -1, 0 }, { 2, 0 }, { -1, 2 }, { 2, -1 } },
    ["2>R"] = { { 0, 0 }, { 1, 0 }, { -2, 0 }, { 1, -2 }, { -2, 1 } },
    ["2>L"] = { { 0, 0 }, { 2, 0 }, { -1, 0 }, { 2, 1 }, { -1, -2 } },
    ["L>2"] = { { 0, 0 }, { -2, 0 }, { 1, 0 }, { -2, -1 }, { 1, 2 } },
    ["L>0"] = { { 0, 0 }, { 1, 0 }, { -2, 0 }, { 1, -2 }, { -2, 1 } },
    ["0>L"] = { { 0, 0 }, { -1, 0 }, { 2, 0 }, { -1, 2 }, { 2, -1 } },

    ["0>2"] = { { 0, 0 }, { 1, 0 }, { -1, 0 }, { 0, -1 }, { 0, 1 } },
    ["2>0"] = { { 0, 0 }, { -1, 0 }, { 1, 0 }, { 0, 1 }, { 0, -1 } },
    ["R>L"] = { { 0, 0 }, { 0, -1 }, { 0, 1 }, { 0, -2 }, { 1, 0 } },
    ["L>R"] = { { 0, 0 }, { 0, -1 }, { 0, 1 }, { 0, -2 }, { -1, 0 } },
}

local PRS_O     = {
    ["0>R"] = { { 1, 0 }, { 1, -1 }, { 1, 1 } },
    ["R>2"] = { { 1, 0 }, { 1, -1 }, { 1, 1 } },
    ["2>L"] = { { 1, 0 }, { 1, -1 }, { 1, 1 } },
    ["L>0"] = { { 1, 0 }, { 1, -1 }, { 1, 1 } },

    ["R>0"] = { { -1, 0 }, { -1, -1 }, { -1, 1 } },
    ["2>R"] = { { -1, 0 }, { -1, -1 }, { -1, 1 } },
    ["L>2"] = { { -1, 0 }, { -1, -1 }, { -1, 1 } },
    ["0>L"] = { { -1, 0 }, { -1, -1 }, { -1, 1 } },
}

local minos     = {
    I = {
        shapes = {
            { 0, 0, 0, 0 },
            { 1, 1, 1, 1 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 }
        },
        color = { 0.2, 0.8, 1.0, 1 },
        preview = {
            width = 4,
            offset = { 0, 0 }
        },
        spawn = { 0, 1 },
        wallkick = { prs = PRS_I },
        spin = {
            mask = {
                { 0, 0, 0, 0, 0, 0 },
                { 0, 1, 3, 3, 1, 0 },
                { 2, 0, 0, 0, 0, 2 },
                { 0, 1, 4, 4, 1, 0 },
                { 0, 0, 0, 0, 0, 0 },
                { 0, 0, 0, 0, 0, 0 }
            },
            result = function(mask)
                local is_spin = mask[1] >= 3 and mask[2] == 2
                local is_mini = mask[3] == 0 or mask[4] == 0

                return { spin = is_spin, mini = is_mini }
            end,
        },
    },
    O = {
        shapes = {
            { 0, 0, 0, 0 },
            { 0, 1, 1, 0 },
            { 0, 1, 1, 0 },
            { 0, 0, 0, 0 }
        },
        color = { 1.0, 0.9, 0.4, 1 },
        preview = {
            width = 2,
            offset = { -1, 1 }
        },
        spawn = { 0, 1 },
        wallkick = { prs = PRS_O },
        spin = {
            mask = {
                { 0, 1, 1, 0 },
                { 2, 0, 0, 4 },
                { 2, 0, 0, 4 },
                { 0, 3, 3, 0 }
            },
            result = function(mask)
                local is_spin = true
                is_spin = is_spin and mask[1] > 0
                is_spin = is_spin and mask[2] > 0
                is_spin = is_spin and mask[3] > 0
                is_spin = is_spin and mask[4] > 0

                local is_mini = false
                is_mini = is_mini or mask[1] < 2
                is_mini = is_mini or mask[2] < 2
                is_mini = is_mini or mask[3] < 2
                is_mini = is_mini or mask[4] < 2

                return { spin = is_spin, mini = is_mini }
            end,
        },
    },
    T = {
        shapes = {
            { 0, 1, 0 },
            { 1, 1, 1 },
            { 0, 0, 0 }
        },
        color = { 0.7, 0.4, 1.0, 1 },
        preview = {
            width = 3,
            offset = { 0, 0 }
        },
        wallkick = { prs = PRS_JLSTZ },
        spin = {
            mask = {
                { 2, 0, 2 },
                { 0, 0, 0 },
                { 1, 0, 1 }
            },
            result = function(mask)
                local sum = mask[1] + mask[2]
                local is_spin = sum >= 3
                local is_mini = mask[2] ~= 2

                return { spin = is_spin, mini = is_mini }
            end,
        },
    },
    S = {
        shapes = {
            { 0, 1, 1 },
            { 1, 1, 0 },
            { 0, 0, 0 }
        },
        color = { 0.2, 0.9, 0.5, 1 },
        preview = {
            width = 3,
            offset = { 0, 0 }
        },
        wallkick = { prs = PRS_JLSTZ },
        spin = {
            mask = {
                { 0, 0, 0, 3, 0 },
                { 0, 1, 0, 0, 3 },
                { 2, 0, 0, 1, 0 },
                { 0, 2, 0, 0, 0 },
                { 0, 0, 0, 0, 0 }
            },
            result = function(mask)
                local is_spin = mask[1] == 2 or mask[2] == 2 or mask[3] == 2
                local is_mini = (mask[2] == 2 or mask[3] == 2) and mask[1] ~= 2

                return { spin = is_spin, mini = is_mini }
            end,
        },
    },
    Z = {
        shapes = {
            { 1, 1, 0 },
            { 0, 1, 1 },
            { 0, 0, 0 }
        },
        color = { 1.0, 0.4, 0.4, 1 },
        preview = {
            width = 3,
            offset = { 0, 0 }
        },
        wallkick = { prs = PRS_JLSTZ },
        spin = {
            mask = {
                { 0, 3, 0, 0, 0 },
                { 3, 0, 0, 1, 0 },
                { 0, 1, 0, 0, 2 },
                { 0, 0, 0, 2, 0 },
                { 0, 0, 0, 0, 0 }
            },
            result = function(mask)
                local is_spin = mask[1] == 2 or mask[2] == 2 or mask[3] == 2
                local is_mini = (mask[2] == 2 or mask[3] == 2) and mask[1] ~= 2

                return { spin = is_spin, mini = is_mini }
            end,
        },
    },
    J = {
        shapes = {
            { 1, 0, 0 },
            { 1, 1, 1 },
            { 0, 0, 0 }
        },
        color = { 0.3, 0.5, 1.0, 1 },
        preview = {
            width = 3,
            offset = { 0, 0 }
        },
        wallkick = { prs = PRS_JLSTZ },
        spin = {
            mask = {
                { 0, 0, 0, 0, 0 },
                { 3, 0, 2, 1, 0 },
                { 3, 0, 0, 0, 0 },
                { 0, 2, 2, 1, 0 },
                { 0, 0, 0, 0, 0 }
            },
            result = function(mask)
                local is_spin = mask[1] >= 1 and mask[2] >= 1
                local is_mini = mask[3] < 1

                return { spin = is_spin, mini = is_mini }
            end,
        },
    },
    L = {
        shapes = {
            { 0, 0, 1 },
            { 1, 1, 1 },
            { 0, 0, 0 }
        },
        color = { 1.0, 0.6, 0.3, 1 },
        preview = {
            width = 3,
            offset = { 0, 0 }
        },
        wallkick = { prs = PRS_JLSTZ },
        spin = {
            mask = {
                { 0, 0, 0, 0, 0 },
                { 0, 1, 2, 0, 3 },
                { 0, 0, 0, 0, 3 },
                { 0, 1, 2, 2, 0 },
                { 0, 0, 0, 0, 0 }
            },
            result = function(mask)
                local is_spin = mask[1] >= 1 and mask[2] >= 1
                local is_mini = mask[3] < 1

                return { spin = is_spin, mini = is_mini }
            end,
        },
    },
}

return minos
