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

    "python's built-in library path
    if  s:current_filetype=="python"
	let libList=split("UserLibraries:/usr/lib/python2.7/types_py.taghl")

    "TODO:Other surpported file types here,like C eg
    "else if s:current_filetype=="c"

    "un-surported file found
    else
	echoerr("This File type isn't surpported")
	return
    endif

    "write the txt file
    let totalList=comList+libList
    call writefile(totalList,tagConfName)
endfunction

"Define a command for the function call
command GenTaghlConfig call GenerateTaghl_config()
