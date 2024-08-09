require("trouble").setup({})

-- Add trouble integration into telescope
local open_with_trouble = require("trouble.sources.telescope").open
local foo = require("trouble.sources.telescope").add
