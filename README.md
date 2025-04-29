![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen.svg)
![Shell Script](https://img.shields.io/badge/made%20with-bash-1f425f.svg)
![Status](https://img.shields.io/badge/status-stable-success.svg)
![Issues](https://img.shields.io/github/issues/DouglasFreshHabian/ScreenSaver)
![Stars](https://img.shields.io/github/stars/DouglasFreshHabian/ScreenSaver?style=social)

[![asciicast](https://asciinema.org/a/717360.svg)](https://asciinema.org/a/717360)
# Customizable Terminal Animation Script
This script allows you to customize a terminal animation with floating emojis, scrolling text, and vibrant background colors. The primary purpose is to enhance the terminal experience with an engaging and interactive visual display.

## ✔️ Features

* Customizable ASCII banner
* Adjustable emoji display
* Background color support (from the 256-color palette)
* Adjustable animation speed

This guide will help you customize the terminal animation script to change the banner text, emojis, background colors, and animation speed.

---

## 🛠 Installation

Clone the repo and run the script:

```bash
git clone https://github.com/DouglasFreshHabian/ScreenSaver.git
cd ScreenSaver
chmod +x ./screensaver.sh
./screensaver.sh
```

---

## 📝 Customization Options
---

## 🖼  ASCII Banner

You can replace the default **"FRESH"** banner with your own ASCII art text. Just replace the content in the `big_banner` variable with your custom ASCII art.

```bash
banner_text="FRESH"  # Replace with your ASCII art text
```
You can use `figlet` with various fonts to create a banner
```bash
figlet -f bigascii12 BANNER

 ######:     :##:    ###   ##  ###   ##  ########  ######:  
 #######      ##     ###   ##  ###   ##  ########  #######  
 ##   :##    ####    ###:  ##  ###:  ##  ##        ##   :## 
 ##    ##    ####    ####  ##  ####  ##  ##        ##    ## 
 ##   :##   :#  #:   ##:#: ##  ##:#: ##  ##        ##   :## 
 #######.    #::#    ## ## ##  ## ## ##  #######   #######: 
 #######.   ##  ##   ## ## ##  ## ## ##  #######   ######   
 ##   :##   ######   ## :#:##  ## :#:##  ##        ##   ##. 
 ##    ##  .######.  ##  ####  ##  ####  ##        ##   ##  
 ##   :##  :##  ##:  ##  :###  ##  :###  ##        ##   :## 
 ########  ###  ###  ##   ###  ##   ###  ########  ##    ##:
 ######    ##:  :##  ##   ###  ##   ###  ########  ##    ###
```
## 😊 Emojis

To customize the emojis used in the animation, create a file called `emojis`. Each emoji should be on a new line in the `emojis` file.

Example of the emojis file:

```bash
🕷
🕵
💣
🖕
🤙
🚀
🔥
🌟
🎉
👾
```
> Note: Once the emojis file is set up, place it in the same directory as the script, and the script will load and use the emojis in the animation.

You can use any emoji or special character you prefer. The script will read these from the file and display them randomly during the animation.

Additionally, if you want to explore even more emojis, you can use the provided `emojis.json` file. It contains hundreds of emojis, and you can search for specific emojis using `grep`.

For example:

```bash
grep "star" emojis.json
```
This command will help you find all related emoji entries (like "star_of_david" and "star_and_crescent").

Here are the results from the emojis.json file:

```bash
{
  "star_of_david": "✡️",
  "eight_pointed_black_star": "✴️",
  "star_and_crescent": "☪️",
  "star": "⭐",
  "night_with_stars": "🌃",
  "star2": "🌟",
  "stars": "🌠",
  "six_pointed_star": "🔯",
  "keycap_star": "*️⃣",
}
```
> Important: `emojis.json` is a grepable json file; `emojis-sorted` consists of all the available emojis, roughly 30 per line, with spacing and has been stripped of all other characters, making copy & paste very easy to perform.


```bash
emoji_file="emojis"  # Make sure this file exists in the same directory or specify the full path
```
---

## 🎨 Using The `color_scheme.conf` Configuration File

To make it easier to switch between different color schemes, we've included a `color_scheme.conf` file where you can define multiple schemes. Inside this file, each scheme has a name (e.g., "Candy Shop") and a list of colors associated with it.

Example of color_scheme.conf:

```bash
# Candy Shop
Candy_Shop=(
    "38;5;45"  # Light Pink
    "38;5;209" # Dark Pink
    "38;5;225" # Purple
)

# Sunset Dream
Sunset_Dream=(
    "38;5;214" # Orange
    "38;5;202" # Red
    "38;5;226" # Yellow
)
```

## 📝 Steps:

1. Load the color scheme by setting the `color_scheme` variable in the `screensaver.sh` script.
  ```bash
     color_scheme_name="Candy_Shop"  # Replace with any scheme from color_scheme.conf
  ```
2. Switch between color schemes by simply changing the value of `color_scheme` to a different scheme name (e.g., "Sunset_Dream").
3. How It Works: The script will read from the `color_scheme.conf` file, load the colors associated with the chosen scheme, and apply them to the terminal animation.

## 🎨 Creating Your Own Color Scheme:

### Background Colors

The script uses a configuration file called `color_scheme.conf` which utilizes the 256-color palette, where you can select colors for the background. You can provide a list of colors by specifying their color codes (0-255) in the array.

Example:

```bash

# Sunset Dream
Sunset_Dream=(
    "38;5;214" # Orange
    "38;5;202" # Red
    "38;5;226" # Yellow
)

```
So to create you own you will need to follow the above format, and choose a name for your color scheme, then create your values, and add your new color scheme to the `color_scheme.conf` file.

> We have provided a script called `show_colors.sh` that you can run and use to reference the colors and associated numbers...

---


## 🖥  Displaying All 256 Colors

To help you choose the colors for the animation, you can run the following bash script that will display all 256 colors. This will allow you to easily pick the color codes you want to use in the script.

## Bash Script to Show All 256 Colors
<details>
  
<summary>🖱 Click here to expand</summary>

```bash
#!/bin/bash

# This script will display all 256 colors available in your terminal with both foreground and background color options.

echo -e "Displaying all 256 colors with both foreground and background options:\n"

# Loop through all 256 color codes
for i in {0..255}; do
    # Print color code with background and foreground colors
    # The first $i is for the foreground color, the second $i is for the background color
    printf "\033[38;5;${i}m Foreground: ${i} \033[48;5;${i}m Background: ${i} \033[0m"

    # Print a new line every 6 colors for better readability
    if (( (i + 1) % 6 == 0 )); then
        echo
    fi
done

echo -e "\nNote: Foreground colors are shown on the left, and background colors are shown on the right."
```
</details>

## Instructions for Running the Script

1. Save the Script:
   Save the script to a file, e.g., show_colors.sh.

2. Make It Executable:
   Run the following command to make the script executable:

```bash
chmod +x show_colors.sh
```

3. Run the Script:
   Execute the script to see all 256 colors:

```bash
./show_colors.sh
```

## How it works:

* This script will display both the foreground and background colors side by side for easy reference.
* It uses both \033[38;5;${i}m for the foreground color and \033[48;5;${i}m for the background color.
* It then prints the color code next to the respective color, helping you visualize the foreground and background together.
* The script prints 6 colors per line for better readability.

## 🎨 Creating Custom Colors

After running the script, you’ll see a grid of colors with their foreground and background combinations, making it easier to choose the colors for your terminal animation script.
Looking for Orange Foreground Color:
```bash
./show_colors.sh
Foreground: 9
```
Now add color to custom color scheme:

```bash
background_colors=(
    "38;5;1"   # Red
    "38;5;40"  # Green
    "38;5;189" # Yellow
    "38;5;159" # Blue
    "38;5;99"  # Cyan
    "38;5;229" # Magenta
    "38;5;9"   # Orange
)

```

## ⏱ Animation Speed

You can adjust the speed of the animation by changing the animation_speed variable. This controls the time between each frame.

```bash
animation_speed=0.08  # Change this to adjust speed (seconds per frame)
```

## 📅 Versioning & Releases

We maintain versioned releases under the "Releases" section of the repository. If you want a specific version, check out the releases page to download and use it directly.

## 📝 License

MIT License — use it freely in personal or commercial projects. Attribution appreciated but not required.

## ✍️ Author

| Name:             | Description                                       |
| :---------------- | :------------------------------------------------ |
| Script:           | screensaver.sh                                    |
| Author:           | Douglas Habian                                    |
| Version:          | 1.1                                               |
| Repo:             | https://github.com/DouglasFreshHabian/ScreenSaver |
## Enjoy creating your own unique terminal animation experience!

### If you have not done so already, please head over to the channel and hit that subscribe button to show some support. Thank you!!!

## 👍 [Stay Fresh](https://www.youtube.com/@DouglasHabian-tq5ck) 

<!-- Reach out to me if you are interested in collaboration or want to contract with me for any of the following:
	Building Github Pages
	Creating Youtube Videos
	Editing Youtube Videos
	Youtube Thumbnail Creation
	Anything Pertaining to Linux! -->

<!-- 
 _____              _       _____                        _          
|  ___| __ ___  ___| |__   |  ___|__  _ __ ___ _ __  ___(_) ___ ___ 
| |_ | '__/ _ \/ __| '_ \  | |_ / _ \| '__/ _ \ '_ \/ __| |/ __/ __|
|  _|| | |  __/\__ \ | | | |  _| (_) | | |  __/ | | \__ \ | (__\__ \
|_|  |_|  \___||___/_| |_| |_|  \___/|_|  \___|_| |_|___/_|\___|___/
        dfresh@tutanota.com Fresh Forensics, LLC 2025 -->

