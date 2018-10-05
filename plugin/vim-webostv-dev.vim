" Common Vim properties
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType gitconfig setlocal foldmethod=marker
augroup END
" }}}

let mapleader = ","
let target_host = "wall.lge.com"
set iskeyword+=-
set iskeyword+=/
" LGE webOS TV developer configuration
" Check if this file belongs to a git project {{{
let gitdir = system("git rev-parse --git-dir| tr -d '\n'")
let curr_date = strftime('%c')
let curr_pwd = expand('%:p')
let msg = "echo \"$(date | tr -d '\n') INFO: current_working_dir " . gitdir . "\" >> ${HOME}/.vim/log"
echom(system(msg))
if !isdirectory(gitdir)
  let msg = "echo $(date |tr -d '\n') INFO: This file does not belong to a git project >> ${HOME}/.vim/log"
  echom(system(msg))
  let temp_cmd = "echo " . curr_pwd . " >> ${HOME}/.vim/log"
  echom(system(temp_cmd))
else
  let commit_msg_file = gitdir . "/hooks/commit-msg"
  let get_url_cmd = "git remote -v|grep \\(push\\)$|awk '{print $2}' | tr -d '\n'"
  let remote_push_url = system(get_url_cmd)
  if filereadable(commit_msg_file)
    let msg = "echo \"$(date | tr -d '\n') INFO: " . commit_msg_file . " file exists\" >> ${HOME}/.vim/log"
    echom(system(msg))
  elseif remote_push_url =~# ".*wall\.lge\.com.*"
    let get_hook_cmd = "scp -p -P 29448 " . target_host . ":hooks/commit-msg " . gitdir . "/hooks/"
    let r = system(get_hook_cmd)
    echom curr_date . " INFO: Download " . commit_msg_file . ": Complete"
  else
    let msg = "echo \"$(date | tr -d '\n') INFO: This repository " . remote_push_url . " is not on " . target_host . "\" >> ${HOME}/.vim/log"
    echom(system(msg))
  endif
endif
" }}}

" Meta Layer Commit Message {{{
let g:meta_layer_commit_msg_templates="MODULE_NAM=MODULE_VERSION\n
\\n
\:Release Notes:\n
\#Write a release note\n
\\n
\:Detailed Notes:\n
\#Write detailed notes\n
\\n
\:Testing Performed:\n
\#Write detailed test results\n
\\n
\:Issues Addressed:\n
\[ISSUEKEY-123] Change issue's key and subject\n
\#Write a list of issues registered on a issue tracking system\n
\\n\n
\"
inoremap <leader>mc <esc>gg^i<C-R>=strftime(meta_layer_commit_msg_templates)<CR><esc>ggk^i<CR>
nnoremap <leader>mc gg^i<C-R>=strftime(meta_layer_commit_msg_templates)<CR><esc>ggk^i<CR>
let g:jenkins_script_commit_msg_templates="jenkins-job.sh: CHANGE_SUBJECT (vX.X.X)\n
\\n
\:Release Notes:\n
\#Write a release note\n
\\n
\:Detailed Notes:\n
\#Write detailed notes\n
\\n
\:Testing Performed:\n
\#Write detailed test results\n
\\n
\:QA Notes:\n
\#QA Notes\n
\\n
\:Issues Addressed:\n
\[ISSUEKEY-123] Change issue's key and subject\n
\#Write a list of issues registered on a issue tracking system\n
\\n\n
\"
inoremap <leader>jc <esc>gg^i<C-R>=strftime(jenkins_script_commit_msg_templates)<CR><esc>ggk^i<CR>
nnoremap <leader>jc gg^i<C-R>=strftime(jenkins_script_commit_msg_templates)<CR><esc>ggk^i<CR>
" }}}

" Project name autocompletion {{{
fun! CompleteProjects(findstart, base)
  if a:findstart
	  " locate the start of the word
	  let line = getline('.')
	  let start = col('.') - 1
	  while start > 0 && line[start - 1] =~ '\a'
	    let start -= 1
	  endwhile
	  return start
  else
	  " find months matching with "a:base"
    let get_project_names_cmd = "ssh " . g:target_host . " gerrit ls-projects  -m " . @" . " > ${HOME}/repo_list.txt"
    let r = system(get_project_names_cmd)
	  " ret r = 'starfish/build-starfish webos-pro/meta-lg-webos'
    let hom_dir = system("echo $HOME|tr -d '\n'")
    let r = readfile(hom_dir . '/repo_list.txt')
    " echom r[100]
    let prj_list = []
    let c = 1
    "while c <= 10
    "  call add(prj_list, r[c])
    "  let c += 1
    "endwhile
	  for m in r
	    if m =~ '^' . a:base
		    call complete_add(m)
	    endif
	    sleep 300m	" simulate searching for next match
	    if complete_check()
		    break
	    endif
	  endfor
	  return []
  endif
endfun
inoremap <leader>project <esc>viwy:set completefunc=CompleteProjects<CR>Di<C-X><C-U>
nnoremap <leader>project :set completefunc=CompleteProjects<CR>i<C-X><C-U>
" }}}
