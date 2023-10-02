#!/bin/sh
set -e

WORKDIR="/opt/gomplate"
CONFIG_FILE="$WORKDIR/config.yaml"
CONTEXT_FILE="$WORKDIR/context.yaml"
DATASOURCE_DIR="$WORKDIR/datasource.d"
TEMPLATE_DIR="$WORKDIR/template.d"

gomplate_flags_config() {
    if [ ! -f "$CONFIG_FILE" ]; then
        return
    fi

    echo -n "--config "$CONFIG_FILE" "
}

gomplate_flags_context() {
    if [ ! -f "$CONTEXT_FILE" ]; then
        return
    fi

    echo -n "--context $CONTEXT_FILE "
}

gomplate_flags_datasource() {
    if [ ! -z "$(gomplate_flags_config)" ] && [ ! -z "$(gomplate_flags_context)" ]; then
        return
    fi
    if [ ! -d "$DATASOURCE_DIR" ]; then
        return
    fi

    for ds in $(find $DATASOURCE_DIR -type f); do
        echo -n "--datasource \"$(basename -- $ds | sed 's/\.[^.]*$//')=file://${ds}\" "
    done
}

gomplate_flags() {
    gomplate_flags_config
    gomplate_flags_context
    gomplate_flags_datasource
}

gomplate_run() {
    echo "run gomplate"
    for file in $(find "$TEMPLATE_DIR" -type f); do
        out="$(echo "$file" | sed "s|$TEMPLATE_DIR||")"
        mkdir -p $(dirname -- "$out")
        gomplate $(gomplate_flags) -f "$file" -o "$out"
    done
}

gomplate_run
watchexec -w "$WORKDIR" -d 1000 -- echo | while read -r line; do gomplate_run; done
