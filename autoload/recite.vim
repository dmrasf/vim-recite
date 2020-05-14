
function recite#add_word() abort
    call recite#create_dir()
    let l:word = recite#get_word()
    call recite#create_file(l:word)
endfunction

function recite#create_dir() abort
    let l:dir = g:recite_default_storage
    if !isdirectory(l:dir)
        call mkdir(l:dir)
    endif
endfunction

function recite#get_word() abort
    return 'fd'
endfunction

function recite#create_file(word) abort
    let l:file = g:recite_default_storage . "/recite"
    call writefile([a:word], l:file, "a")
endfunction
