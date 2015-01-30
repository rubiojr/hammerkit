MRuby::Build.new do |conf|
  toolchain :gcc
  #enable_debug

  conf.gembox 'default'

  conf.gem :git => 'https://github.com/iij/mruby-env.git'
  conf.gem :git => 'https://github.com/iij/mruby-socket.git'
  conf.gem :git => 'https://github.com/iij/mruby-pack.git'
  conf.gem :git => 'https://github.com/iij/mruby-io.git'
  conf.gem :git => 'https://github.com/mattn/mruby-thread.git'
  conf.gem :git => 'https://github.com/mattn/mruby-md5.git'
  conf.gem :git => 'https://github.com/mattn/mruby-md5.git'
  conf.gem :git => 'https://github.com/mattn/mruby-sqlite3.git'
  conf.gem :git => 'https://github.com/rubiojr/mruby-getoptlong.git'
  conf.gem :git => 'https://github.com/mattn/mruby-json.git'
  conf.gem :git => 'https://github.com/rubiojr/mruby-shutils'
  conf.gem :git => 'https://github.com/matsumoto-r/mruby-redis.git'
  conf.gem :git => 'https://github.com/matsumoto-r/mruby-sleep.git'
  
  conf.gem :core => 'mruby-hammerkit'
end

# Define cross build settings
if ENV['HAMMERKIT_ARCH_i386']
  MRuby::CrossBuild.new('i386') do |conf|
    toolchain :gcc

    conf.cc.flags << "-m32"
    conf.linker.flags << "-m32"

    # include the IIJ gembox
    conf.gembox 'iij'

    conf.gem :git => 'https://github.com/mattn/mruby-updategems.git'
    conf.gem :git => 'https://github.com/matsumoto-r/mruby-simplehttp'
    conf.gem :git => 'https://github.com/rubiojr/mruby-getoptlong.git'
    conf.gem :git => 'https://github.com/mattn/mruby-json.git'
    conf.gem :git => 'https://github.com/luisbebop/mruby-polarssl.git'
    conf.gem :git => 'https://github.com/matsumoto-r/mruby-simplehttp'
    conf.gem :git => 'https://github.com/rubiojr/mruby-shutils'

    conf.gem :core => 'mruby-hammerkit'
  end
end
