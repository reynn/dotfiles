#!/usr/bin/env fish

function bluetooth.connect.device -d 'Connect to a Bluetooth device'

    function __list_devices
        echo "use framework \"IOBluetooth\"
              use scripting additions
              set _results to {}
              repeat with device in (current application's IOBluetoothDevice's pairedDevices() as list)
                  if device's isPaired()
                      set _address to device's addressString as string
                      set _name to device's nameOrAddress as string
                      set _isConnected to device's isConnected as string
                      if _isConnected = \"1\"
                          set _isConnected to \"✔\"
                      else
                          set _isConnected to \"✗\"
                      end if
                      set end of _results to {_address, \"\t\", _name, \"\t\", _isConnected, \"\n\"}
                  end if
              end repeat
              return _results as string" | osascript
    end

    function __connect_device
        set -l address "$argv[1]"
        echo "use framework \"IOBluetooth\"
              use scripting additions

              repeat with device in (current application's IOBluetoothDevice's pairedDevices() as list)
                  set _address to device's addressString() as string
                  if _address = \"$address\"
                      if device's isConnected()
                          device's closeConnection()
                      else
                          device's openConnection()
                      end if
                  end if
              end repeat" | osascript
    end

    function ___usage
        set -l help_args -a 'Connect to a Bluetooth device'

        __dotfiles_help $help_args
    end

    getopts $argv | while read -l key value
        switch $key
            case v verbose
                set -x DEBUG true
            case h help
                ___usage
                return 0
        end
    end

    if not command.is_available -c osascript
        log.error '`osascript` is not installed'
        return 1
    end

    set -l selected (__list_devices \
        | sed '/^$/d' \
        | fzf \
            --delimiter '\t' \
            --with-nth 2,3 \
            --preview \
                'system_profiler SPBluetoothDataType -json 2>/dev/null \
                    | jq -r ".SPBluetoothDataType[].device_title[]["\"{2}\""]
                    | select(type != \"null\")"' \
    )

    set -l device_address (string replace --regex -a '\t' ',' $selected | string split ',')[1]
    set -l device_name (string replace --regex -a '\t' ',' $selected | string split ',')[2]
    if test -z "$device_address"
        log.debug 'No device selected'
        return 0
    end
    log.info -l bluetooth "Connecting to device $device_name [$device_address]"
    __connect_device $device_address
end
