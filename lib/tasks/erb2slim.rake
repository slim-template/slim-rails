namespace :slim do
  desc 'Convert html.erb to html.slim in app/views'
  task :erb2slim do 
    erb_files = Dir.glob('app/views/**/*.erb').select { |f| File.file? f}
    slim_files = Dir.glob('app/views/**/*.slim').select { |f| File.file? f}

    if erb_files.empty?
      puts "No .erb files found. Task will now exit."
      exit
    end
    
    slim_files_w_out_ext = slim_files.map { |f| f.gsub(/\.slim\z/, '') }
    
    # Get a list of all those erb files that already seem to have .slim equivalents

    already_existing = erb_files.select { |f| short = f.gsub(/\.erb\z/, ''); slim_files_w_out_ext.include?(short) }

    puts '-'*80

    if already_existing.any?
      puts "Some of your .html.erb files seem to already have .slim equivalents:"
      already_existing.map { |f| puts "\t#{f}" }

      # Ask the user whether he/she would like to overwrite them.
      begin
        puts "Would you like to overwrite these .slim files? (y/n)"
        should_overwrite = STDIN.gets.chomp.downcase[0]
      end until ['y', 'n'].include?(should_overwrite)
      puts '-'*80

      # If we are not overwriting, remove each already_existing from our erb_files list
      if should_overwrite == 'n'
        erb_files = erb_files - already_existing

        if erb_files.empty?
          # It is possible no .erb files remain, after we remove already_existing
          puts "No .erb files remain. Task will now exit."
          return
        end
      else
        # Delete the current .slim
        already_existing.each { |f| File.delete(f.gsub(/\.erb\z/, '.slim')) }
      end
    end

    erb_files.each do |file|
      puts "Generating slim for #{file}..."
      `html2slim #{file} #{file.gsub(/\.erb\z/, '.slim')}`
    end

    puts '-'*80

    puts "slim generated for the following files:"
    erb_files.each do |file|
      puts "\t#{file}"
    end

    puts '-'*80
    begin
      puts 'Would you like to delete the original .erb files? (This is not recommended unless you are under version control.) (y/n)'
      should_delete = STDIN.gets.chomp.downcase[0]
    end until ['y', 'n'].include?(should_delete)

    if should_delete == 'y'
      puts "Deleting original .erb files."
      File.delete *erb_files
    else
      puts "Please remember to delete your .erb files once you have ensured they were translated correctly."
    end

    puts '-'*80
    puts "Task complete!"
  end
end    
