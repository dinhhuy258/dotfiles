local fm = fm

fm.general.frame_ui = {
  sel_frame_color = "green",
  frame_color = "white",
}

fm.general.log_info_ui = {
  prefix = "[Info] ",
  suffix = "",
  style = {
    fg = "green",
  },
}

fm.general.log_warning_ui = {
  prefix = "[Warning] ",
  suffix = "",
  style = {
    fg = "yellow",
  },
}

fm.general.log_error_ui = {
  prefix = "[Error] ",
  suffix = "",
  style = {
    fg = "red",
  },
}

fm.general.explorer_table.default_ui = {
  prefix = "  ",
  suffix = "",
  file_style = {
    fg = "white",
  },
  directory_style = {
    fg = "cyan",
  },
}

fm.general.explorer_table.focus_ui = {
  prefix = "▸[",
  suffix = "]",
  style = {
    fg = "blue",
    decorations = {
      "bold",
    },
  },
}

fm.general.explorer_table.selection_ui = {
  prefix = " {",
  suffix = "}",
  style = {
    fg = "green",
  },
}

fm.general.explorer_table.focus_selection_ui = {
  prefix = "▸[",
  suffix = "]",
  style = {
    fg = "green",
    decorations = {
      "bold",
    },
  },
}

fm.general.explorer_table.index_header = {
  name = "index",
  percentage = 10,
}

fm.general.explorer_table.name_header = {
  name = "┌──── name",
  percentage = 65,
}

fm.general.explorer_table.permissions_header = {
  name = "permissions",
  percentage = 15,
}

fm.general.explorer_table.size_header = {
  name = "size",
  percentage = 10,
}

fm.general.explorer_table.first_entry_prefix = "├─"
fm.general.explorer_table.entry_prefix = "├─"
fm.general.explorer_table.last_entry_prefix = "└─"

fm.general.sorting = {
  sort_type = "dirFirst",
  reverse = false,
  ignore_case = true,
  ignore_diacritics = true,
}

fm.modes.customs["go-to"] = {
  name = "go-to",
  key_bindings = {
    default = {
      help = "cancel",
      messages = {
        {
          name = "SwitchMode",
          args = {
            "default",
          },
        },
      },
    },
    on_keys = {
      ["~"] = {
        help = "Home",
        messages = {
          {
            name = "ChangeDirectory",
            args = {
              "/Users/dinhhuy258",
            },
          },
          {
            name = "SwitchMode",
            args = {
              "default",
            },
          },
        },
      },
      w = {
        help = "Workspace",
        messages = {
          {
            name = "ChangeDirectory",
            args = {
              "/Users/dinhhuy258/Workspace",
            },
          },
          {
            name = "SwitchMode",
            args = {
              "default",
            },
          },
        },
      },
      D = {
        help = "Documents",
        messages = {
          {
            name = "ChangeDirectory",
            args = {
              "/Users/dinhhuy258/Documents",
            },
          },
          {
            name = "SwitchMode",
            args = {
              "default",
            },
          },
        },
      },
      d = {
        help = "Downloads",
        messages = {
          {
            name = "ChangeDirectory",
            args = {
              "/Users/dinhhuy258/Downloads",
            },
          },
          {
            name = "SwitchMode",
            args = {
              "default",
            },
          },
        },
      },
      h = {
        help = "Desktop",
        messages = {
          {
            name = "ChangeDirectory",
            args = {
              "/Users/dinhhuy258/Desktop",
            },
          },
          {
            name = "SwitchMode",
            args = {
              "default",
            },
          },
        },
      },
      ["ctrl+c"] = {
        help = "quit",
        messages = {
          {
            name = "Quit",
          },
        },
      },
    },
  },
}

fm.modes.customs.yarn = {
  name = "yarn",
  key_bindings = {
    default = {
      help = "cancel",
      messages = {
        {
          name = "SwitchMode",
          args = {
            "default",
          },
        },
      },
    },
    on_keys = {
      p = {
        help = "yarn path",
        messages = {
          {
            name = "BashExecSilently",
            args = {
              [===[
              focus_path="${FM_FOCUS_PATH}"
              if [ "${focus_path}" ]; then
                echo -n ${focus_path} | pbcopy -selection clipboard
                echo LogSuccess "'"${focus_path} was coppied to clipboard"'" >> "${FM_PIPE_MSG_IN:?}"
              fi

              echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
              ]===],
            },
          },
        },
      },
      n = {
        help = "yarn name",
        messages = {
          {
            name = "BashExecSilently",
            args = {
              [===[
              focus_path="${FM_FOCUS_PATH}"
              if [ "${focus_path}" ]; then
                echo -n $(basename ${focus_path}) | pbcopy -selection clipboard
                echo LogSuccess "'"$(basename "${focus_path}") was coppied to clipboard"'" >> "${FM_PIPE_MSG_IN:?}"
              fi

              echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
              ]===],
            },
          },
        },
      },
      d = {
        help = "yarn directory",
        messages = {
          {
            name = "BashExecSilently",
            args = {
              [===[
              focus_path="${FM_FOCUS_PATH}"
              if [ "${focus_path}" ]; then
                echo -n $(dirname ${focus_path}) | pbcopy -selection clipboard
                echo LogSuccess "'"$(dirname "${focus_path}") was coppied to clipboard"'" >> "${FM_PIPE_MSG_IN:?}"
              fi

              echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
              ]===],
            },
          },
        },
      },
      ["ctrl+c"] = {
        help = "quit",
        messages = {
          {
            name = "Quit",
          },
        },
      },
    },
  },
}

fm.modes.customs["mark-save"] = {
  name = "mark-save",
  key_bindings = {
    default = {
      help = "save",
      messages = {
        {
          name = "SetInputBuffer",
          args = {
            "",
          },
        },
        {
          name = "UpdateInputBufferFromKey",
        },
        {
          name = "BashExecSilently",
          args = {
            [===[
            session_path="${FM_SESSION_PATH:?}"
            mark_file="${session_path}/mark"

            focus_path="${FM_FOCUS_PATH:?}"
            key="${FM_INPUT_BUFFER:?}"

            # create a mark file if not exists
            touch ${mark_file}
            # remove conflict mark key in the mark file
            marks=$(sed "/^"${key}";/d" < "${mark_file:?}")
            printf "%s\n" "${marks[@]}" > ${mark_file}
            # add new mark key to the mark file
            echo "${key};${focus_path}" >> ${mark_file}

            echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
            ]===],
          },
        },
      },
    },
    on_keys = {
      esc = {
        help = "cancel",
        messages = {
          {
            name = "SwitchMode",
            args = {
              "default",
            },
          },
        },
      },
      ["ctrl+c"] = {
        help = "quit",
        messages = {
          {
            name = "Quit",
          },
        },
      },
    },
  },
}

fm.modes.customs["mark-load"] = {
  name = "mark-load",
  key_bindings = {
    default = {
      help = "load",
      messages = {
        {
          name = "SetInputBuffer",
          args = {
            "",
          },
        },
        {
          name = "UpdateInputBufferFromKey",
        },
        {
          name = "BashExecSilently",
          args = {
            [===[
            session_path="${FM_SESSION_PATH:?}"
            mark_file="${session_path}/mark"

            # create a mark file if not exists
            touch ${mark_file}

            pressed_key="${FM_INPUT_BUFFER}"

            # go through the mark file and read the value to variable marks
            (while IFS= read -r line; do
            key=$(echo ${line:?} | cut -d ";" -f 1)
            path=$(echo ${line:?} | cut -d ";" -f 2)

            if [ "${key}" = "${pressed_key}" ]; then
              echo FocusPath "'""${path}""'" >> "${FM_PIPE_MSG_IN:?}"
              break
            fi
            done < "${mark_file:?}")

            echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
            ]===],
          },
        },
      },
    },
    on_keys = {
      esc = {
        help = "cancel",
        messages = {
          {
            name = "SwitchMode",
            args = {
              "default",
            },
          },
        },
      },
      ["ctrl+c"] = {
        help = "quit",
        messages = {
          {
            name = "Quit",
          },
        },
      },
    },
  },
}

fm.modes.customs.custom_command = {
  name = "custom_command",
  key_bindings = {
    default = {
      help = "cancel",
      messages = {
        {
          name = "SwitchMode",
          args = {
            "default",
          },
        },
      },
    },
    on_keys = {
      f = {
        help = "ffmpeg",
        messages = {
          {
            name = "BashExec",
            args = {
              [===[
              focus_path="${FM_FOCUS_PATH}"
              if [ "${focus_path}" ]; then
                if ! file --mime-type "${focus_path}" | grep -q "video"; then
                  echo "Error: ${focus_path} is not a video file"
                  read -p "Press enter to continue"
                  echo LogError "'"${focus_path} is not a video file"'" >> "${FM_PIPE_MSG_IN:?}"
                  echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"

                  exit 1
                fi

                file_name=$(basename "${focus_path}")
                new_file_name="ffmpeg_${file_name}"
                ffmpeg -i "${file_name}" "${new_file_name}"
                read -p "Press enter to continue"
              fi

              echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
              ]===],
            },
          },
        },
      },
      ["ctrl+c"] = {
        help = "quit",
        messages = {
          {
            name = "Quit",
          },
        },
      },
    },
  },
}

fm.modes.customs.open = {
  name = "open",
  key_bindings = {
    default = {
      help = "cancel",
      messages = {
        {
          name = "SwitchMode",
          args = {
            "default",
          },
        },
      },
    },
    on_keys = {
      f = {
        help = "open in Finder",
        messages = {
          {
            name = "BashExecSilently",
            args = {
              [===[
              focus_path="${FM_FOCUS_PATH}"
              if [ "${focus_path}" ]; then
                open -R "${focus_path}"
              fi

              echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
              ]===],
            },
          },
        },
      },
      c = {
        help = "open in Visual Studio Code",
        messages = {
          {
            name = "BashExecSilently",
            args = {
              [===[
              focus_path="${FM_FOCUS_PATH}"
              if [ "${focus_path}" ]; then
                open -a "Visual Studio Code" "${focus_path}"
              fi

              echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
              ]===],
            },
          },
        },
      },
      v = {
        help = "open in NeoVim",
        messages = {
          {
            name = "BashExec",
            args = {
              [===[
              focus_path="${FM_FOCUS_PATH}"
              if [ "${focus_path}" ]; then
                nvim "${focus_path}"
              fi

              echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
              ]===],
            },
          },
        },
      },
      t = {
        help = "open new window in tmux",
        messages = {
          {
            name = "BashExec",
            args = {
              [===[
              focus_path="${FM_FOCUS_PATH}"
              if [ "${focus_path}" ]; then
                if [ -f "${focus_path}" ]; then
                  tmux new-window -c "$(dirname ${focus_path})"
                else
                  tmux new-window -c "${focus_path}"
                fi
              fi

              echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
              ]===],
            },
          },
        },
      },
      o = {
        help = "open",
        messages = {
          {
            name = "BashExec",
            args = {
              [===[
              focus_path="${FM_FOCUS_PATH}"
              if [ "${focus_path}" ]; then
                case $(file --mime-type ${focus_path} -b) in
                    text/*) nvim ${focus_path};;
                    application/json) nvim ${focus_path};;
                    *) open "${focus_path}"
                esac
              fi

              echo SwitchMode "'"default"'" >> "${FM_PIPE_MSG_IN:?}"
              ]===],
            },
          },
        },
      },
      ["ctrl+c"] = {
        help = "quit",
        messages = {
          {
            name = "Quit",
          },
        },
      },
    },
  },
}

fm.modes.builtins.default.key_bindings.on_keys["g"] = {
  help = "go to",
  messages = {
    {
      name = "SwitchMode",
      args = {
        "go-to",
      },
    },
  },
}

fm.modes.builtins.default.key_bindings.on_keys["o"] = {
  help = "open",
  messages = {
    {
      name = "SwitchMode",
      args = {
        "open",
      },
    },
  },
}

fm.modes.builtins.default.key_bindings.on_keys["c"] = {
  help = "custom command",
  messages = {
    {
      name = "SwitchMode",
      args = {
        "custom_command",
      },
    },
  },
}

fm.modes.builtins.default.key_bindings.on_keys["y"] = {
  help = "yarn",
  messages = {
    {
      name = "SwitchMode",
      args = {
        "yarn",
      },
    },
  },
}

fm.modes.builtins.default.key_bindings.on_keys["/"] = {
  help = "search",
  messages = {
    {
      name = "BashExec",
      args = {
        [===[
        file_path=$(ls -a | fzf --no-sort)
        if [ "${file_path}" ]; then
          echo FocusPath "'"$PWD/${file_path}"'" >> "${FM_PIPE_MSG_IN:?}"
        fi
        ]===],
      },
    },
  },
}

fm.modes.builtins.default.key_bindings.on_keys["m"] = {
  help = "mark save",
  messages = {
    {
      name = "SwitchMode",
      args = {
        "mark-save",
      },
    },
  },
}

fm.modes.builtins.default.key_bindings.on_keys["`"] = {
  help = "mark load",
  messages = {
    {
      name = "SwitchMode",
      args = {
        "mark-load",
      },
    },
  },
}

fm.modes.builtins.default.key_bindings.on_keys["ctrl+u"] = {
  help = "scroll up",
  messages = {
    {
      name = "BashExecSilently",
      args = {
        [===[
        focus_index="${FM_FOCUS_IDX}"
        echo FocusByIndex "'"$((focus_index-10))"'" >> "${FM_PIPE_MSG_IN:?}"
        ]===],
      },
    },
  },
}

fm.modes.builtins.default.key_bindings.on_keys["ctrl+d"] = {
  help = "scroll down",
  messages = {
    {
      name = "BashExecSilently",
      args = {
        [===[
        focus_index="${FM_FOCUS_IDX}"
        echo FocusByIndex "'"$((focus_index+10))"'" >> "${FM_PIPE_MSG_IN:?}"
        ]===],
      },
    },
  },
}
