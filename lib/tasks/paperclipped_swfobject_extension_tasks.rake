namespace :radiant do
  namespace :extensions do
    namespace :paperclipped_swfobject do
      
      desc "Runs the migration of the Paperclipped Swfobject extension"
      task :migrate => :environment do
        puts "Paperclipped SWFObject does not have anything to migrate."
      end
      
      desc "Copies public assets of the Paperclipped Swfobject to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[PaperclippedSwfobjectExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(PaperclippedSwfobjectExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
