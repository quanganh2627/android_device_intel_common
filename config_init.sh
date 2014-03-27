# software configuration related boot actions

CONFIG_PATH=/local_cfg
PROPS_FILE=init.props

config=`cat /config/local_config`
ln -s /system/etc/catalog/$config $CONFIG_PATH

# read all FeatureTeam's init.props file
for f in $CONFIG_PATH/*/$PROPS_FILE
do
    cat $f >> /config.prop
done
