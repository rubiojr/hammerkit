#!/bin/bash
set -e

RUBY_VERSION="1.1.0"
BASE_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_DIR=$BASE_PATH/tmp/mruby-$RUBY_VERSION

cd $BASE_PATH
# MRUBY_CONFIG=hammerkit/hammerkit_config.rb make
mkdir -p cache bin tmp
echo $BASE_PATH/cache/mruby-$RUBY_VERSION.tar.gz
if [ ! -f $BASE_PATH/cache/mruby-$RUBY_VERSION.tar.gz ]; then
    echo "Fetching mruby..."
    wget https://github.com/mruby/mruby/archive/$RUBY_VERSION.tar.gz -O $BASE_PATH/cache/mruby-$RUBY_VERSION.tar.gz
    cd $BASE_PATH/tmp && tar xzf $BASE_PATH/cache/mruby-$RUBY_VERSION.tar.gz
fi

cp $BASE_PATH/loader/loader.c $BUILD_DIR/mrbgems/mruby-bin-mruby/tools/mruby/mruby.c
cp $BASE_PATH/loader/loader.rake $BUILD_DIR/mrbgems/mruby-bin-mruby/mrbgem.rake

rm -rf $BUILD_DIR/mrbgems/mruby-hammerkit
cp -r $BASE_PATH/mrbgem-skel $BUILD_DIR/mrbgems/mruby-hammerkit

find $BASE_PATH/../lib/ -type f -name "*.rb"| xargs cat > $BUILD_DIR/mrbgems/mruby-hammerkit/mrblib/lib.rb
echo "def main" >> $BUILD_DIR/mrbgems/mruby-hammerkit/mrblib/lib.rb
cat $BASE_PATH/../main.rb >> $BUILD_DIR/mrbgems/mruby-hammerkit/mrblib/lib.rb
echo "end" >> $BUILD_DIR/mrbgems/mruby-hammerkit/mrblib/lib.rb

cp $BASE_PATH/hammerkit_config.rb $BUILD_DIR/build_config.rb
cd $BUILD_DIR && make
rm -rf $BASE_PATH/../out
mv $BASE_PATH/tmp/*/bin $BASE_PATH/../out
