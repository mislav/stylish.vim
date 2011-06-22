if exists("g:stylish_loaded")
  finish
endif
let g:stylish_loaded = 1

command Stylish call <SID>StylishSetup()

function s:StylishRubyWarning()
  echohl WarningMsg
  echo "stylish.vim requires Vim to be compiled with Ruby support"
  echohl none
endfunction

function s:StylishSetup()
  if has('ruby')
    nmap <Leader>c  :StylishNext<CR>
    vmap <Leader>c  :StylishNext<CR>
    nmap <Leader>cp :StylishPrev<CR>
    vmap <Leader>cp :StylishPrev<CR>
    nmap <Leader>r  :StylishRand<CR>
    vmap <Leader>r  :StylishRand<CR>
    nmap <Leader>f  :StylishFont<CR>
    vmap <Leader>f  :StylishFont<CR>
  else
    call s:StylishRubyWarning()
  endif
endfunction

if !has('ruby')
  finish
endif

function s:StylishInit()
  ruby $stylish ||= Stylish.new
endfunction

command StylishNext call <SID>StylishNext()

function s:StylishNext()
  call s:StylishInit()
  ruby $stylish.next!
endfunction

command StylishPrev call <SID>StylishPrev()

function s:StylishPrev()
  call s:StylishInit()
  ruby $stylish.previous!
endfunction

command StylishRand call <SID>StylishRand()

function s:StylishRand()
  call s:StylishInit()
  ruby $stylish.rand!
endfunction

command StylishFont call <SID>StylishFont()

function s:StylishFont()
  call s:StylishInit()
  ruby $stylish.next_font!
endfunction

ruby << EOF
  begin
    require 'stylish'
  rescue LoadError
    load_path_modified = false
    ::VIM::evaluate('&runtimepath').to_s.split(',').each do |path|
      lib = "#{path}/ruby"
      if !$LOAD_PATH.include?(lib) and File.directory?(lib)
        $LOAD_PATH << lib
        load_path_modified = true
      end
    end
    retry if load_path_modified
  end
EOF
