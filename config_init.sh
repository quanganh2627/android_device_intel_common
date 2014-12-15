# Get selected software configuration

config=`cat /config/local_config`
mount -o bind /system/etc/catalog/$config /local_cfg

log -p i -t config_init "Activating configuration $config"

# Set properties for the selected configuration

# read all FeatureTeam's init.props file
for f in /local_cfg/*/init.props
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
