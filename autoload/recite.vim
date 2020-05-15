
function recite#add_word() abort
    call recite#create_dir()
    let l:word = recite#get_word()
    if empty(l:word)
        return
    endif
    call recite#create_file(l:word)
endfunction

function recite#create_dir() abort
    let l:dir = g:recite_default_storage
    if !isdirectory(l:dir)
        call mkdir(l:dir)
    endif
endfunction

function recite#get_word() abort
    let l:line = getline(".")
    let l:pos = getcurpos()[-1]
    let l:charpos = l:line[l:pos - 1]
    if match(l:charpos, '[a-z|A-Z]') == -1
        return
    endif
    let l:patten = '[a-z|A-Z]*' . l:charpos . '[a-z|A-Z]*'
    let l:wordpos = matchstrpos(l:line, l:patten)

    while l:wordpos[-1] < l:pos
        let l:count = l:wordpos[-1]
        let l:wordpos = matchstrpos(l:line, l:patten, l:count)
    endwhile

    echo l:wordpos
    return l:wordpos[0]
endfunction

function recite#create_file(word) abort
    let l:file = g:recite_default_storage . "/recite"
    call writefile([a:word], l:file, "a")
endfunction
