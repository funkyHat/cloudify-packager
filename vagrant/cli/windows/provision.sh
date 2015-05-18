export TAG_NAME="master"
export VERSION=`cat VERSION  | grep version | sed 's/"version": //g' | sed "s/,//g"`

pip install wheel

pip wheel --wheel-dir packaging/source/wheels https://github.com/cloudify-cosmo/cloudify-cli/archive/$TAG_NAME.zip#egg=cloudify-cli \
https://github.com/cloudify-cosmo/cloudify-rest-client/archive/$TAG_NAME.zip#egg=cloudify-rest-client \
https://github.com/cloudify-cosmo/cloudify-dsl-parser/archive/$TAG_NAME.zip#egg=cloudify-dsl-parser \
https://github.com/cloudify-cosmo/cloudify-plugins-common/archive/$TAG_NAME.zip#egg=cloudify-plugins-common \
https://github.com/cloudify-cosmo/cloudify-script-plugin/archive/$TAG_NAME.zip#egg=cloudify-script-plugin

export VERSION_FILE=$(cat VERSION)

python packaging/update_wheel.py --path packaging/source/wheels/cloudify-*.whl --name cloudify_cli/VERSION --data "$VERSION_FILE"
mv packaging/source/wheels/cloudify-*.whl-new packaging/source/wheels/cloudify-*.whl

iscc packaging/create_install_wizard.iss
