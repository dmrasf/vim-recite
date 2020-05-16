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
    if match(l:charpos, '[a-zA-Z]') == -1
        return
    endif
    let l:patten = '[a-zA-Z]*' . l:charpos . '[a-zA-Z]*'

    execute 'highlight default ReciteWord cterm=reverse gui=reverse'

    let l:wordpos = matchstrpos(l:line, l:patten)
    while l:wordpos[-1] < l:pos
        let l:count = l:wordpos[-1]
        let l:wordpos = matchstrpos(l:line, l:patten, l:count)
    endwhile

    let s:id =  matchaddpos('ReciteWord', [[getcurpos()[1], l:wordpos[1] + 1, l:wordpos[2] - l:wordpos[1]]])

    return l:wordpos[0]
endfunction

function! recite#clear_hi() abort
endfunction

function recite#create_file(word) abort
    let l:file = g:recite_default_storage . "/recite"
    if exists("*strftime")
        let l:time = '"\[' . strftime("%Y-%m-%d") . '\]"'
    end
    let l:isHasTime = execute("!grep " . l:time . " " . l:file . " | wc -l")
    if l:isHasTime == 0
        call writefile(['['.strftime("%Y-%m-%d".']')], l:file, "a")
    endif
    call writefile([a:word], l:file, "a")

endfunction
