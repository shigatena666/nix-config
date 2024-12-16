#!/bin/bash

# Add event to subscribe
sketchybar --add event aerospace_workspace_change

# Define your spaces with names and corresponding Nerd Font icons
SPACES=("home:" "web:󰖟" "code:" "chat:󰍩" "music:󰎆")

# Add and configure spaces
for i in "${!SPACES[@]}"; do
  SPACE="${SPACES[$i]}"
  WORKSPACE_NAME=${SPACE%%:*} # Extract name (everything before ':')
  ICON=${SPACE##*:}           # Extract icon (everything after ':')
  WORKSPACE_NUMBER=$((i + 1)) # Calculate workspace number (1-based index)

  # Add and set space
  sketchybar --add item "workspace.$WORKSPACE_NUMBER" left \
    --subscribe "workspace.$WORKSPACE_NUMBER" aerospace_workspace_change \
    --set "workspace.$WORKSPACE_NUMBER" \
    icon="$ICON" \
    label="$WORKSPACE_NAME" \
    icon.padding_right=5 \
    label.y_offset=-1 \
    click_script="aerospace workspace $WORKSPACE_NUMBER" \
    script="$PLUGIN_DIR/aerospace.sh $WORKSPACE_NUMBER"
done
