#!/usr/bin/env fish

function dotfiles.prompt.update -d 'Update settings for our given prompt'
    set --universal tide_cmd_duration_bg_color C4A000
    set --universal tide_cmd_duration_color 000000
    set --universal tide_cmd_duration_decimals 0
    set --universal tide_cmd_duration_icon ""
    set --universal tide_cmd_duration_threshold 3000
    set --universal tide_context_always_display false
    set --universal tide_context_bg_color 444444
    set --universal tide_context_default_color D7AF87
    set --universal tide_context_root_color D7AF00
    set --universal tide_context_ssh_color D7AF87
    set --universal tide_git_prompt_bg_color 4E9A06
    set --universal tide_jobs_bg_color 444444
    set --universal tide_jobs_color 4E9A06
    set --universal tide_jobs_icon ""
    set --universal tide_left_prompt_frame_color 6C6C6C
    set --universal tide_left_prompt_frame_enabled false
    set --universal tide_left_prompt_item_separator_diff_color ""
    set --universal tide_left_prompt_item_separator_same_color ""
    set --universal tide_left_prompt_item_separator_same_color_color 949494
    set --universal tide_left_prompt_items os
    set --universal --append tide_left_prompt_items pwd
    set --universal --append tide_left_prompt_items git_prompt
    set --universal --append tide_left_prompt_items newline
    set --universal --append tide_left_prompt_items prompt_char
    set --universal tide_left_prompt_pad_items true
    set --universal tide_left_prompt_prefix ""
    set --universal tide_left_prompt_suffix ""
    set --universal tide_nvm_bg_color 75507B
    set --universal tide_nvm_color 2E3436
    set --universal tide_nvm_icon "⬢"
    set --universal tide_os_bg_color CED7CF
    set --universal tide_os_color 080808
    set --universal tide_print_newline_before_prompt true
    set --universal tide_prompt_char_bg_color normal
    set --universal tide_prompt_char_failure_color FF0000
    set --universal tide_prompt_char_icon "❯"
    set --universal tide_prompt_char_success_color 5FD700
    set --universal tide_prompt_char_vi_default_icon "❮"
    set --universal tide_prompt_char_vi_insert_icon "❯"
    set --universal tide_prompt_char_vi_replace_icon "▶"
    set --universal tide_prompt_char_vi_visual_icon V
    set --universal tide_prompt_connection_color 6C6C6C
    set --universal tide_prompt_connection_icon ""
    set --universal tide_pwd_anchors first
    set --universal --append tide_pwd_anchors last
    set --universal --append tide_pwd_anchors git
    set --universal tide_pwd_bg_color blue
    set --universal tide_pwd_color_anchors E4E4E4
    set --universal tide_pwd_color_dirs E4E4E4
    set --universal tide_pwd_color_truncated_dirs BCBCBC
    set --universal tide_pwd_dir_icon ""
    set --universal tide_pwd_home_icon ""
    set --universal tide_pwd_max_dirs 0
    set --universal tide_pwd_truncate_margin 10
    set --universal tide_pwd_unwritable_icon ""
    set --universal tide_right_prompt_frame_color 6C6C6C
    set --universal tide_right_prompt_frame_enabled false
    set --universal tide_right_prompt_item_separator_diff_color ""
    set --universal tide_right_prompt_item_separator_same_color ""
    set --universal tide_right_prompt_item_separator_same_color_color 949494
    set --universal tide_right_prompt_items status
    set --universal --append tide_right_prompt_items cmd_duration
    set --universal --append tide_right_prompt_items context
    set --universal --append tide_right_prompt_items jobs
    set --universal --append tide_right_prompt_items nvm
    set --universal --append tide_right_prompt_items virtual_env
    set --universal --append tide_right_prompt_items rust
    set --universal tide_right_prompt_pad_items true
    set --universal tide_right_prompt_prefix ""
    set --universal tide_right_prompt_suffix ""
    set --universal tide_rust_bg_color FF8700
    set --universal tide_rust_color 2E3436
    set --universal tide_rust_icon ""
    set --universal tide_rust_verbose_version true
    set --universal tide_status_always_display false
    set --universal tide_status_failure_bg_color CC0000
    set --universal tide_status_failure_color FFFF00
    set --universal tide_status_failure_icon "✘"
    set --universal tide_status_success_bg_color 2E3436
    set --universal tide_status_success_color 4E9A06
    set --universal tide_status_success_icon "✔"
    set --universal tide_time_bg_color D3D7CF
    set --universal tide_time_color 000000
    set --universal tide_time_format ""
    set --universal tide_vi_mode_default_bg_color 008000
    set --universal tide_vi_mode_default_color 000000
    set --universal tide_vi_mode_default_icon DEFAULT
    set --universal tide_vi_mode_insert_bg_color 444444
    set --universal tide_vi_mode_replace_bg_color 808000
    set --universal tide_vi_mode_replace_color 000000
    set --universal tide_vi_mode_replace_icon REPLACE
    set --universal tide_vi_mode_visual_bg_color 000080
    set --universal tide_vi_mode_visual_color 000000
    set --universal tide_vi_mode_visual_icon VISUAL
    set --universal tide_virtual_env_bg_color 444444
    set --universal tide_virtual_env_color 00AFAF
    set --universal tide_virtual_env_display_mode projectName
    set --universal tide_virtual_env_icon ""
end
