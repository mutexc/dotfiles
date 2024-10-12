
# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%H:%M %a %d")

# volume levels 
volume=$(pamixer --get-volume)

# Get the Linux version but remove the "-1-ARCH" part
echo $volume"%" "|" $date_formatted 

