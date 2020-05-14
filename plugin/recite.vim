
function! s:set_recite_global_option(argument, default)
    if !has_key(g:, a:argument)
        let g:{a:argument} = a:default
    end
endfunction

call s:set_recite_global_option("recite_disable_default_keybindings", v:false)
call s:set_recite_global_option("recite_default_storage", "/home/dmr/Documents/recite")

function Test() abort
    call recite#add_word()
endfunction

command! RecitePre call Test()

if g:recite_disable_default_keybindings == v:false
    nnoremap <m-e> :RecitePre<CR>
end

