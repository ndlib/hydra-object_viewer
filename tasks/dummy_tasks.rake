namespace :dummy do
  ENGINE_NAME = Hydra::ObjectViewer.name
  desc "Generate a Rails dummy for #{ENGINE_NAME} tests"
  task :generate => [:init, :new_app, :scaffold, :install, :migrate, :configure, :cleanup]

  desc 'Remove dummy application'
  task :remove => :init do
    require 'fileutils'
    $stdout.puts "Removing spec/dummy"
    DummyFileUtils.rm_rf(DUMMY_ROOT)
  end

  desc "Replace the existing Rails dummy for #{ENGINE_NAME} tests"
  task :regenerate => [:remove, :generate]


  task :new_app => [:init] do
    # Cribbed from https://gist.github.com/stas/4131823
    require 'rails'
    require 'hydra_object_viewer'
    require 'rails/generators'
    require 'rails/generators/rails/plugin_new/plugin_new_generator'

    class DummyGenerator < Rails::Generators::PluginNewGenerator

      def self.default_source_root
        Rails::Generators::PluginNewGenerator.default_source_root
      end

      def do_nothing
      end

      alias :create_root :do_nothing
      alias :create_root_files :do_nothing
      alias :create_app_files :do_nothing
      alias :create_config_files :do_nothing
      alias :create_lib_files :do_nothing
      alias :create_public_stylesheets_files :do_nothing
      alias :create_javascript_files :do_nothing
      alias :create_script_files :do_nothing
      alias :update_gemfile :do_nothing
      alias :create_test_files :do_nothing
      alias :finish_template :do_nothing

    end
    puts "Generating #{DUMMY_ROOT}"
    DummyGenerator.start(
      %W(. --force --skip-bundle --old-style-hash --dummy-path=#{DUMMY_ROOT})
         )
  end

  task :scaffold => [:init, :new_app] do
    system("rails generate model Watch title:string description:text")
    system("rails generate model Gear name:string specs:text watch:belongs_to")


    # require 'debugger'; debugger; true
    Rake::Task['dummy:cleanup'].invoke
  end

  task :install => [:init, :new_app] do
  end

  task :configure => [:init, :new_app, :install] do
    initializer_filename = File.join(DUMMY_ROOT, 'config/initializers/hydra_object_viewer_config.rb')
    File.open(initializer_filename, 'w+') do |f|
      f.puts <<-EOF
      Hydra::ObjectViewer.converter.object_finder = lambda {|pid,context|
        begin
          Watch.find(pid)
        rescue ActiveRecord::RecordNotFound
          Gear.find(pid)
        end
      }
      EOF
    end
  end

  task :cleanup => [:init] do
    system("rm -rf #{File.join(DUMMY_ROOT,'spec')}")
  end

  task :migrate => :init do
    puts "Running #{ENGINE_NAME} migrations"
    rakefile = File.join(DUMMY_ROOT, 'Rakefile')
    system("rake -f #{rakefile} db:create db:migrate db:test:prepare")
  end

  task :init do
    DummyFileUtils = FileUtils #::DryRun
    DUMMY_ROOT = File.expand_path("../../spec/dummy", __FILE__).freeze
  end

end
