"*****************************************************************************************************
" @File 	myib.vim
" @Desp		Some vim functions to make vim more convenient to use
" NOTE: 	This file should be placed in runtimepath/plugin directory
" @Author 	Xiong
" @Version 	1.0
" @Date 	2013-12-13
"*****************************************************************************************************/

"*****************************************************************************/
"@Desp 		This function is responsible for generating the taghl_config.txt	
" 		file for the taghighlight plugin(A.S Budden),depending on the 
"		current file type(python or c).
"		With taghl_config.txt file,taghighlight can highlight library
"		code for the common project.Before using this,you should
"		generate the tags file in the library path.Then the tags file
"		can be referenced by taghl_config.txt.

"@Returns   	Nothing if execute normally.Or error appears.
"****************************************************************************/
function! GenerateTaghl_config()
    "detect the current file type
    let s:current_filetype=&filetype
    "highlight local variables
    let comList=split("IncludeLocals:True")
    let tagConfName="taghl_config.txt"
    let isSurport=0

    "python's built-in library path
    if  s:current_filetype=="python"
	let libList=split("UserLibraries:/usr/lib/python2.7/types_py.taghl,/usr/local/lib/python2.7/dist-packages/types_py.taghl")
	let isSurport=1
    endif

    if s:current_filetype=="c"
	let libList=split("UserLibraries:/usr/include/types_c.taghl")
	let isSurport=1
    endif

    "TODO:Add other surpported file types here,like C++ eg

    "un-surported file found
    if isSurport==0
	echoerr("This File type isn't surpported")
	return
    endif

    "write the txt file
    let totalList=comList+libList
    call writefile(totalList,tagConfName)
endfunction

"Define a command for the function call
command GenTaghlConfig call GenerateTaghl_config()

"Define commands to convert C '{}' style
command! MyCodeStyleOn %s/^\(\s*\)\([_a-zA-Z].*\)\n\s*{$/\1\2{/ge
command! MyCodeStyleOff %s/^\(\s*\)\([_a-zA-Z].*\){$/\1\2\r\1{/ge
