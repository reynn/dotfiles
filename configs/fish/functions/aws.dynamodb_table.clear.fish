#!/usr/bin/env fish

function aws.dynamodb_table.clear -d "Clear items from a DynamoDB table without dropping it"
    if not command.is_available -c aws
        __log error 'AWS CLI is not installed'
        return 1
    end

    function ___usage
        set -l help_args -a 'Clear items from a DynamoDB table without dropping it'

        __dotfiles_help $help_args
    end

    set table_name
    set projection
    set aws_profile
    set item_count 0
    set item_buffer

    getopts $argv | while read -l key value
        switch $key
            case t table-name
                set table_name $value
            case p projection
                set projection $value
            case P profile
                set aws_profile $value
                # Common args
            case h help
                ___usage
                return 0
            case q quiet
                set -x QUIET true
            case v verbose
                set -x DEBUG true
        end
    end

    if test $table_name = ""
        __log error "Must provide a table name"
        return 1
    end

    set scan_args dynamodb scan --table-name $table_name

    if not test "$projection" = ""
        set -a scan_args --projection-expression $projection
    else
        set key_schema (aws --profile integration-data-lake dynamodb describe-table --table-name $table_name | dasel select -r json --plain -m '.Table.KeySchema.[*].AttributeName' | string join ', ')
        set -a scan_args --projection-expression "$key_schema"
    end

    if test $aws_profile
        set -p scan_args --profile $aws_profile
    end
    __log debug "Scan args: $scan_args"
    set scanned_items (aws $scan_args | jq -c '.Items[]')

    for item in $scanned_items
        # increment the counter
        set item_count (math "$item_count + 1")
        # add the item to the buffer
        set -a item_buffer "{\"DeleteRequest\":{\"Key\":$item}}"
        if test $item_count = 25
            __log debug "Writing $item_count items to AWS"

            set batch_write_args dynamodb batch-write-item --request-items "{\"$table_name\":[$(string join ',' $item_buffer)]}"
            if not test $aws_profile = ""
                set -p batch_write_args --profile $aws_profile
            end

            __log debug "aws $batch_write_args"
            aws $batch_write_args >/dev/null
            # clear the buffer
            set -e item_buffer
            # reset the item count
            set item_count 0
        end
    end

    if test $item_count -gt 0
        set batch_write_args dynamodb batch-write-item --request-items "{\"$table_name\":[$(string join ',' $item_buffer)]}"
        if not test $aws_profile = ""
            set -p batch_write_args --profile $aws_profile
        end

        __log debug "aws $batch_write_args"
        aws $batch_write_args >/dev/null
    end

    __log debug "Processed $item_count items"
end
