namespace :enrollment do
  desc 'read and save CSV files'
  task :read_and_save_in_file => :environment do
    puts 'importing files*'
    puts 'writing the values*'

    CSV.open('lib/tasks/test_task.csv', "w") do |csv|
     csv << Enrollment.column_names[1..3]

     Enrollment.all.each do |col_value| 
      csv << col_value.slice(:register_number, :cpf, :institution_id).values
     end
    end

    CSV.foreach('lib/tasks/test_task.csv', headers: true) do |row|
      puts row.inspect
    end

    puts 'done!'
  end
end

desc "passing params with 'rake way'"
task :param, [:first_name, :last_name] => :environment do |task, args|
  puts "parâmetros #{args[:first_name].to_s} #{args[:last_name].to_s}"
end
