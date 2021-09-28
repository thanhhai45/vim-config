" Prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_config_present = 1

" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 1

autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync

