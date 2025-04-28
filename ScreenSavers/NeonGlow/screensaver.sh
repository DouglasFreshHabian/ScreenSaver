#!/bin/bash

# ============================
# Customization Variables
# ============================

# ASCII Banner (can be replaced with any other ASCII art text)
banner_text="NEON"

# File path to custom emojis (user must provide this file)
emoji_file="emojis"  # Make sure this file exists in the same directory or provide the full path

# Load color schemes from the configuration file
source ./color_scheme.conf

# Function to load the selected color scheme
load_color_scheme() {
    local scheme_name=$1
    # Dynamically load the array from color_scheme.conf
    eval "selected_colors=(\"\${$scheme_name[@]}\")"
    if [[ ${#selected_colors[@]} -eq 0 ]]; then
        echo "Color scheme '$scheme_name' not found. Using default scheme."
        return 1
    fi
    return 0
}

# Define your color scheme (change this to the scheme you want)
color_scheme_name="Neon_Glow"  # Change to whatever scheme you like
load_color_scheme "$color_scheme_name" || exit 1  # Load selected color scheme

# Set up the background colors based on the selected scheme
background_colors=("${selected_colors[@]}")

# Speed of the animation (lower is faster, higher is slower)
animation_speed=0.08  # Change this to adjust speed (seconds per frame)

# ============================
# Script Logic (Do not Change Below Here Unless You're Comfortable)
# ============================

cols=$(tput cols)
lines=$(tput lines)

tput civis
trap "tput cnorm; clear; exit" SIGINT

# Read emojis from the provided file
if [[ -f "$emoji_file" ]]; then
    mapfile -t symbols < "$emoji_file"
else
    echo "Emoji file not found. Please create a file called 'emojis' with your desired symbols."
    exit 1
fi

# Characters for background fuzz
chars=('@' '#' '%' '&' '*' '+' '-' '=' '.' ' ')

# Stylized block letters for the banner (default is "FRESH")
read -r -d '' big_banner << 'EOF'
 ###   ##  ########   .####.   ###   ## 
 ###   ##  ########   ######   ###   ## 
 ###:  ##  ##        :##  ##:  ###:  ## 
 ####  ##  ##        ##:  :##  ####  ## 
 ##:#: ##  ##        ##    ##  ##:#: ## 
 ## ## ##  #######   ##    ##  ## ## ## 
 ## ## ##  #######   ##    ##  ## ## ## 
 ## :#:##  ##        ##    ##  ## :#:## 
 ##  ####  ##        ##:  :##  ##  #### 
 ##  :###  ##        :##  ##:  ##  :### 
 ##   ###  ########   ######   ##   ### 
 ##   ###  ########   .####.   ##   ### 
EOF

IFS=$'\n' read -rd '' -a banner_lines <<< "$big_banner"
banner_height=${#banner_lines[@]}
banner_width=${#banner_lines[0]}

# Starting position and velocity for the banner
x=$((RANDOM % (cols - banner_width)))
y=$((RANDOM % (lines - banner_height)))
vx=1
vy=1
color_idx=0

# Frame buffer for static background
declare -a frame_buffer

generate_line() {
    local line=""
    for ((j = 0; j < cols; j++)); do
        rand_char=$((RANDOM % ${#chars[@]}))
        rand_color=${background_colors[$((RANDOM % ${#background_colors[@]}))]}
        char="${chars[$rand_char]}"
        line+="\e[${rand_color}m$char\e[0m"
    done
    echo -e "$line"
}

# Initialize background
for ((i = 0; i < lines; i++)); do
    frame_buffer[i]="$(generate_line)"
done

# Initialize floating emojis
declare -a float_x float_y float_sym float_color
for ((i = 0; i < 10; i++)); do
    float_x[$i]=$((RANDOM % cols))
    float_y[$i]=$((RANDOM % lines))
    float_sym[$i]=${symbols[$((RANDOM % ${#symbols[@]}))]}
    float_color[$i]=${background_colors[$((RANDOM % ${#background_colors[@]}))]}
done

while true; do
    # Scroll static background
    frame_buffer=("${frame_buffer[@]:1}")
    frame_buffer+=("$(generate_line)")

    clear

    # Draw background
    for ((i = 0; i < lines; i++)); do
        echo -e "${frame_buffer[$i]}"
    done

    # Draw floating emojis
    for ((i = 0; i < ${#float_x[@]}; i++)); do
        tput cup ${float_y[$i]} ${float_x[$i]}
        printf "\e[1;${float_color[$i]}m${float_sym[$i]}\e[0m"
        (( float_y[$i]++ ))
        if (( float_y[$i] >= lines )); then
            float_y[$i]=0
            float_x[$i]=$((RANDOM % cols))
            float_sym[$i]=${symbols[$((RANDOM % ${#symbols[@]}))]}
            float_color[$i]=${background_colors[$((RANDOM % ${#background_colors[@]}))]}
        fi
    done

    # Draw banner
    for ((i = 0; i < banner_height; i++)); do
        draw_y=$((y + i))
        if (( draw_y >= 0 && draw_y < lines )); then
            tput cup $draw_y $x
            printf "\e[1;${background_colors[$color_idx]}m%s\e[0m" "${banner_lines[$i]}"
        fi
    done

    # Update banner position
    ((x += vx))
    ((y += vy))

    # Bounce off edges
    (( x <= 0 || x >= cols - banner_width )) && (( vx *= -1 ))
    (( y <= 0 || y >= lines - banner_height )) && (( vy *= -1 ))

    # Rotate color
    (( color_idx = (color_idx + 1) % ${#background_colors[@]} ))

    sleep $animation_speed
done
