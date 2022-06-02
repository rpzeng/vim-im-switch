vim 的中文输入法切换

* windows
    中利用 `im-select.exe` 来切换语言。  
    要求系统语言要安装中文和英语两种，并且英语的语言选项里要安装英语键盘。

* linux
    用fxitx5，或fcitx，插件会自动检测

Option:

```vim
let g:im_switch_command = 'fcitx5-remote' or 'im-select'  " 插件会自动检测这个命
令，一般不需要指定。
```
