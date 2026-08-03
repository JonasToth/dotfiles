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
      {
        "<leader>as",
        function() require("agentic").stop_generation() end,
        mode = { "n" },
        desc = "Stop the generation of the chat."
      },
      {
        "<leader>aA",
        function() require("agentic").add_selection_or_file_to_context() end,
        mode = { "n" },
        desc = "Add the current selection of file to the chat context."
      },
    }
  },
}
