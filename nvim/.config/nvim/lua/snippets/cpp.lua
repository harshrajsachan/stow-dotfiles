local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets('cpp', {
  s('template', {
    t {
      '#include <bits/stdc++.h>',
      'using namespace std;',
      '',
      'int main(){',
      '    ios::sync_with_stdio(false);',
      '    cin.tie(nullptr);',
      '',
      '    int t;',
      '    cin >> t;',
      '',
      '    while(t--){',
      '        //input',
      '        ',
    },
    i(1),
    t {
      '',
      '        //solution',
      '        ',
    },
    i(2),
    t {
      '',
      '        //output',
      '    }',
      '    return 0;',
      '}',
    },
  }),
})
