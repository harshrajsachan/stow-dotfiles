local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s("vowel", {
    t({
      "bool vowel(char a){",
      "  a=tolower(a);",
      "  return a=='a' || a=='e' || a=='i' || a=='o' || a=='u';",
      "}",
    }),
  }),
}
