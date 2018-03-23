require 'formaggio/capistrano'
set :app_title, "bravo_collection"
set :rvm_ruby_string, "2.3.6"

set :new_relic_environments, []

after "deploy:assets:precompile", "deploy:public:copy_system"
namespace :deploy do
  namespace :public do
    desc "Moves over public/system files"
    task :copy_system, :roles => :web, :max_hosts => 1, :except => { :no_release => true } do
      logger.info ("Preparing to move over static public files....")
      run_locally ("cd public && tar -jcf system.tar.bz2 system")
      run         ("cd #{shared_path} && rm -rf system && mkdir system")
      top.upload  "public/system.tar.bz2", "#{shared_path}", :via => :scp
      run         ("cd #{shared_path} && tar -jxf system.tar.bz2 && rm system.tar.bz2")
      run_locally ("rm public/system.tar.bz2")
    end
  end
end
