#!/bin/sh

BAT=/sys/class/power_supply/BAT0

if [ -d $BAT ]; then
    MANUFACTURER=$(cat $BAT/manufacturer)
    MODEL=$(cat $BAT/model_name)
    CAPACITY=$(cat $BAT/capacity)
    STATUS=$(cat $BAT/status)
    ENERGY_FULL=$(cat $BAT/energy_full)
    ENERGY_FULL_DESIGN=$(cat $BAT/energy_full_design)
    CYCLE_COUNT=$(cat $BAT/cycle_count)

    AGING=$(echo "scale=4; $ENERGY_FULL / $ENERGY_FULL_DESIGN" | bc)
    AGED=$(echo "100 - $AGING * 100" | bc)

    cat << EOF
Manufacturer : $MANUFACTURER
Model        : $MODEL
Status       : $STATUS
Capacity     : $CAPACITY%
Aged         : $AGED%
Cycle Count  : $CYCLE_COUNT
EOF
fi
