export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

if [ -z $XDG_DATA_DIRS ]; then
	export XDG_DATA_DIRS=/opt/arch/share:/opt/arch/local/share
else
	export XDG_DATA_DIRS=/opt/arch/share:/opt/arch/local/share:$XDG_DATA_DIRS
fi

if [ -z $XDG_CONFIG_DIRS ]; then
	export XDG_CONFIG_DIRS=/opt/arch/etc/xdg
else
	export XDG_CONFIG_DIRS=/opt/arch/etc/xdg:$XDG_CONFIG_DIRS
fi
