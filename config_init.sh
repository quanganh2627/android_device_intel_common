# software configuration related boot actions

CONFIG_PATH=/local_cfg
PROPS_FILE=init.props

config=`cat /config/local_config`
ln -s /system/etc/catalog/$config $CONFIG_PATH

log -p i -t config_init "Activating configuration $config"

# read all FeatureTeam's init.props file
for f in $CONFIG_PATH/*/$PROPS_FILE
do
    while read l; do

        # Ignore empty lines and comments
        case "$l" in
            ''|'#'*)
                continue
                ;;
        esac

        # Set property
        setprop `echo ${l/=/ }`

    done < $f
done

echo > /config_init.done
