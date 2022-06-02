if exists("g:loaded_im_switch_vim_aa")
    finish
endif
let g:loaded_im_switch_vim_aa = 1


if !exists("g:im_switch_command")
    if executable("fcitx5-remote")
        let g:im_switch_command = "fcitx5-remote"
    elseif executable("fcitx-remote")
        let g:im_switch_command = "fcitx-remote"
    elseif executable("im-select.exe")
        let g:im_switch_command = 'im-select.exe'
    elseif executable(expand('<sfile>:p:h:h') . '/tools/im-select.exe')
        let g:im_switch_command = expand('<sfile>:p:h:h') . '/tools/im-select.exe'
    else
        echoms "需要指定参数 g:im_switch_command "
    endif
endif


let s:fcitx_remote = g:im_switch_command
if g:im_switch_command =~ 'im-select'
    let s:ZH = 2052
    let s:EN = 1033
    let s:toZH = s:fcitx_remote . ' 2052'
    let s:toEN = s:fcitx_remote . ' 1033'

else
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
