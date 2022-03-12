if exists("g:loaded_im_switch_vim_aa")
    finish
endif
let g:loaded_im_switch_vim_aa = 1


if !exists("g:is_windows")
    if(has("win32") || has("win64") || has("win95") || has("win16") || has("windows"))
        let g:is_windows = 1
    else
        let g:is_windows = 0
    endif
endif


if !exists("g:is_git_bash")
    let g:is_git_bash = 0
endif


if g:is_git_bash == 1
    let s:fcitx_remote = expand('<sfile>:p:h:h') . '/tools/im-select.exe'
    let s:ZH = 2052
    let s:EN = 1033
    let s:toZH = s:fcitx_remote . ' 2052'
    let s:toEN = s:fcitx_remote . ' 1033'

elseif g:is_windows == 1
    let s:fcitx_remote = expand('<sfile>:p:h:h') . '\tools\im-select.exe'
    let s:ZH = 2052
    let s:EN = 1033
    let s:toZH = s:fcitx_remote . ' 2052'
    let s:toEN = s:fcitx_remote . ' 1033'

else
    let s:fcitx_remote = 'fcitx5-remote'
    let s:ZH = 2
    let s:EN = 1
    let s:toZH = s:fcitx_remote . ' -o'
    let s:toEN = s:fcitx_remote . ' -c'
endif


function! ToEng()
    let insert_mode = system(s:fcitx_remote)
    if insert_mode == s:ZH
        call system(s:toEN)
    endif
endfunction


function Fcitx2en()
    let inputstatus = system(s:fcitx_remote)
    if inputstatus == s:ZH
        let b:inputtoggle = 1
        call system(s:toEN)
    endif
endfunction


function Fcitx2zh()
    try
        if b:inputtoggle == 1
            call system(s:toZH)
            let b:inputtoggle = 0
        endif
    catch /inputtoggle/
        let b:inputtoggle = 0
    endtry
endfunction


set ttimeoutlen=100
au InsertLeave * call Fcitx2en()
au InsertEnter * call Fcitx2zh()
au CmdlineEnter [:\/?] call ToEng()
au CmdlineLeave [:\/?] call ToEng()
autocmd VimEnter * call ToEng()
