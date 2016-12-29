# A small script that will set the backlight setting for my laptop screen.
#!/bin/bash

maxBacklight=`cat /sys/class/backlight/intel_backlight/max_brightness`;
currentBrightness=`cat /sys/class/backlight/intel_backlight/brightness`;
minBrightness=200;
step=100;

echo "current brightness is $currentBrightness out of $maxBacklight";
case "$1" in
	min)
		echo "Setting to lowest brightness";
		tee /sys/class/backlight/intel_backlight/brightness <<< $minBrightness;
		;;
	max)
		echo "setting to max brightness";
		tee /sys/class/backlight/intel_backlight/brightness <<< $maxBacklight
		;;
	up)
		nextValue=$((currentBrightness + step))
		if [[ $nextValue -gt $maxBacklight ]] 
		then
			if [[ $currentBrightness -lt $maxBacklight ]]
			then
				echo "setting to max brightness";
				tee /sys/class/backlight/intel_backlight/brightness <<< $maxBacklight
			else
				echo "at highest brightness setting";
			fi
		else
			echo "setting brightnewss to $nextValue";
			tee /sys/class/backlight/intel_backlight/brightness <<< $nextValue
		fi
		echo "up"
		;;
	down)
		nextValue=$((currentBrightness - step));
		if [[ $nextValue -lt $minBrightness ]]
		then 
			if [[ $currentBrightness -gt $minBrightness ]]
			then
				echo "Setting to lowest brightness";
				tee /sys/class/backlight/intel_backlight/brightness <<< $minBrightness;
			else
				echo "Alright at lowest brightness";
			fi
		else
			echo "setting brightnewss to $nextValue";
			tee /sys/class/backlight/intel_backlight/brightness <<< $nextValue
		fi
		echo "down"
		;;
	*)
		echo "Usage: backlight.sh [up|down|max|min]";
		;;
esac

	
