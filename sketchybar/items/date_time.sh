#!/usr/bin/env sh

sketchybar --add       item               date_time.time right                          \
           --set       date_time.time     update_freq=2                                 \
                                          icon.drawing=off                              \
                                          script="$PLUGIN_DIR/time.sh"                  \
                                                                                        \
           --clone     date_time.date     label_template                                \
           --set       date_time.date     update_freq=60                                \
                                          position=right                                \
                                          label=cal                                     \
                                          drawing=on                                    \
                                          background.padding_right=0                    \
                                          script="$PLUGIN_DIR/date.sh"                  \
                                                                                        \
           --add       bracket            date_time                                     \
                                          date_time.time                                \
                                          date_time.date                                \
                                                                                        \
           --set       date_time          background.drawing=on
