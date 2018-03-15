let s:lvimrc_util_path = fnameescape(expand('<sfile>:p:h') . '/utils/digest.py')

function! LVimrcUpdateDigest(file)
    call system(s:lvimrc_util_path . ' update ' . fnameescape(a:file))
    return v:shell_error
endfunction

function! LVimrcVerifyDigest(file)
    call system(s:lvimrc_util_path . ' verify ' . fnameescape(a:file))
    return v:shell_error
endfunction

function! LVimrcLoadRcs(rcs)
    for file in split(a:rcs, "\n")
        if filereadable(file)
            if LVimrcVerifyDigest(file)
                echoerr 'Ignore lvimrc: ' . file
            else
                execute 'source ' . fnameescape(file)
            endif
        endif
    endfor
endfunction

function! LVimrcLoadRcsOnPath()
    let current_path = ''
    call LVimrcLoadRcs(glob('/*lvimrc'))
    call LVimrcLoadRcs(glob('/.*lvimrc'))
    for dir in split(getcwd(), '/')
        let current_path = current_path . '/' . dir
        call LVimrcLoadRcs(glob(current_path . '/*lvimrc'))
        call LVimrcLoadRcs(glob(current_path . '/.*lvimrc'))
    endfor
endfunction

function! LVimrcUpdateSelfDigest()
    execute ':%!' . s:lvimrc_util_path . ' update'
endfunction


augroup LVimrc
    autocmd BufWritePre *lvimrc call LVimrcUpdateSelfDigest()
    autocmd VimEnter * call LVimrcLoadRcsOnPath()
augroup END
