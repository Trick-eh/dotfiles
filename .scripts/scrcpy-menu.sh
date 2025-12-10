#!/bin/bash

monitor_width=$(perl -e 'print 2880/1.5')

entries_functionality="\t Mirror Screen \n\t Mount Phone"

selected_functionality=$(echo -e $entries_functionality | wofi -x $(($monitor_width / 2 - 140)) --height 80 --width 280 --hide-search --dmenu | awk '{print tolower($1)}')

if [[ $selected_functionality != "" ]]; then
    entries_protocol="\t TCPIP\n\t USB"

    selected_protocol=$(echo -e $entries_protocol | wofi -x $(($monitor_width / 2 - 100)) --height 80 --width 200 --hide-search --dmenu | awk '{print tolower($1)}') 
    
    if [[ $selected_protocol != "" ]]; then

        if [[ $selected_protocol = "tcpip" ]]; then
            protocol_flag=e
        else
            protocol_flag=d
        fi

        case $selected_functionality in 
            mirror)
                # should make it to ask for a resolution
                command="scrcpy -m1024 -$protocol_flag"   ;;
            mount)
                entries_mount="\t Videorecorder\n\t Screenrecorder"

                selected_mount=$(echo -e $entries_mount | wofi -x $(($monitor_width / 2 - 140)) --height 80 --width 280 --hide-search --dmenu | awk '{print tolower($1)}')

                case $selected_mount in 
                    videorecorder)
                        command="scrcpy --video-source=camera --camera-size=1920x1080 --camera-facing=front --v4l2-sink=/dev/video4 --no-audio-playback --no-video-playback -$protocol_flag"    ;;
                    screenrecorder)
                        command="scrcpy --video-source=display --v4l2-sink=/dev/video4 --no-video-playback -$protocol_flag"    ;;
                esac
                ;; 
        esac


        $command --monitor eDP-1
    fi
fi
