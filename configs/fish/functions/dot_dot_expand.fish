function dot_dot_expand
  echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
