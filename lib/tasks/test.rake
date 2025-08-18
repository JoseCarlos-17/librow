desc 'first task'
  task :message do
    puts "There's not place like our home"
  end

desc 'read files'
  namespace :import do
    task :import_and_read_files do
      puts 'New Message'
    end
  end
