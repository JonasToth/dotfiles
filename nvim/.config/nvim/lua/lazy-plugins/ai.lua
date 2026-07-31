return {
  {
    "carlos-algms/agentic.nvim",

    --- @type agentic.PartialUserConfig
    opts = {
      provider = "claude-agent-acp",
    },
    keys = {
      {
        "<leader>a",
        function() require("agentic").toggle() end,
        mode = { "n" },
        desc = "Toggle Agentic Chat"
      },
    }
  },
}
