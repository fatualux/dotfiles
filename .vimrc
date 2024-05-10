function! SourceConfigDir(directory)
  let directory_splat = '$HOME/.vim/' . a:directory . '/*'
  for config_file in split(glob(directory_splat), '\n')
    execute 'source' config_file
  endfor
endfunction

call SourceConfigDir('config')
call SourceConfigDir('plugins')
