return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      cpp = { "clang-format" },
      c = { "clang-format" },
      java = { "google-java-format" },
      html = { "prettier" },
      css = { "prettier" },
      javascript = { "prettier" },
    },
  },
}
